import Foundation
import LSQLite

final class StatementRowDecoder: Decoder {
    var codingPath: [CodingKey] = []
    var userInfo: [CodingUserInfoKey: Any] = [:]
    var failure: StatementCodingFailure?
    let statement: Statement
    let columnMap: [String: Int32]
    let columnCount: Int
    var decodedIndices: Set<Int32> = []

    init(statement: Statement) throws {
        let count = Int(statement.columnCount)
        var map: [String: Int32] = [:]
        map.reserveCapacity(count)
        if count > 0 {
            for offset in 0..<count {
                let index = Int32(offset)
                guard let name = statement.columnName(at: index), !name.isEmpty else {
                    throw StatementCodingFailure.invalidColumn
                }
                if map[name] != nil {
                    throw StatementCodingFailure.duplicateColumn
                }
                map[name] = index
            }
        }
        self.statement = statement
        self.columnMap = map
        self.columnCount = count
    }

    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> {
        return KeyedDecodingContainer(StatementRowContainer(decoder: self))
    }

    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        fail(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    func singleValueContainer() throws -> SingleValueDecodingContainer {
        fail(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    var decodedColumnCount: Int {
        decodedIndices.count
    }

    func fail(_ error: StatementCodingFailure) {
        if failure == nil {
            failure = error
        }
    }
}

struct StatementRowContainer<Key: CodingKey>: KeyedDecodingContainerProtocol {
    var codingPath: [CodingKey] { decoder.codingPath }
    let decoder: StatementRowDecoder

    init(decoder: StatementRowDecoder) {
        self.decoder = decoder
    }

    var allKeys: [Key] {
        decoder.columnMap.keys.compactMap { Key(stringValue: $0) }
    }

    func contains(_ key: Key) -> Bool {
        decoder.columnMap[key.stringValue] != nil
    }

    func decodeNil(forKey key: Key) throws -> Bool {
        let index = try columnIndex(for: key)
        return decoder.statement.columnType(at: index) == .null
    }

    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        try unsupportedValue()
    }

    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        let index = try nonNullColumnIndex(for: key)
        guard let value = decoder.statement.columnText(at: index) else {
            decoder.fail(.typeMismatch)
            throw StatementCodingFailure.typeMismatch
        }
        return value
    }

    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        let index = try nonNullColumnIndex(for: key)
        return decoder.statement.columnDouble(at: index)
    }

    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        try unsupportedValue()
    }

    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        let index = try nonNullColumnIndex(for: key)
        let value = decoder.statement.columnInt64(at: index)
        guard let intValue = Int(exactly: value) else {
            decoder.fail(.typeMismatch)
            throw StatementCodingFailure.typeMismatch
        }
        return intValue
    }

    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        try unsupportedValue()
    }

    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        try unsupportedValue()
    }

    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        try unsupportedValue()
    }

    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        try unsupportedValue()
    }

    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        try unsupportedValue()
    }

    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        try unsupportedValue()
    }

    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        try unsupportedValue()
    }

    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        try unsupportedValue()
    }

    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        try unsupportedValue()
    }

    func decode<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T {
        if type == Data.self {
            let index = try nonNullColumnIndex(for: key)
            let length = Int(decoder.statement.columnBytes(at: index))
            if length == 0 {
                return Data() as! T
            }
            guard let blob = decoder.statement.columnBlob(at: index) else {
                decoder.fail(.typeMismatch)
                throw StatementCodingFailure.typeMismatch
            }
            let data = Data(bytes: blob, count: length)
            return data as! T
        }
        try unsupportedValue()
    }

    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> {
        decoder.fail(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        decoder.fail(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    func superDecoder() throws -> Decoder {
        decoder.fail(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    func superDecoder(forKey key: Key) throws -> Decoder {
        decoder.fail(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    func columnIndex(for key: Key) throws -> Int32 {
        let name = key.stringValue
        guard let index = decoder.columnMap[name] else {
            decoder.fail(.missingColumn)
            throw StatementCodingFailure.missingColumn
        }
        decoder.decodedIndices.insert(index)
        return index
    }

    func nonNullColumnIndex(for key: Key) throws -> Int32 {
        let index = try columnIndex(for: key)
        guard decoder.statement.columnType(at: index) != .null else {
            decoder.fail(.typeMismatch)
            throw StatementCodingFailure.typeMismatch
        }
        return index
    }

    func unsupportedValue() throws -> Never {
        decoder.fail(.unsupportedValue)
        throw StatementCodingFailure.unsupportedValue
    }
}
