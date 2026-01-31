import Foundation
import LSQLite

final class StatementBindingEncoder: Encoder {
    var codingPath: [CodingKey] = []
    var userInfo: [CodingUserInfoKey: Any] = [:]
    var failure: StatementCodingFailure?
    let statement: Statement
    let parameterMap: [String: Int32]

    init(statement: Statement, parameterMap: [String: Int32]) {
        self.statement = statement
        self.parameterMap = parameterMap
    }

    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> {
        return KeyedEncodingContainer(StatementBindingContainer(encoder: self))
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        fail(.unsupportedContainer)
        return StatementFailingUnkeyedEncodingContainer(codingPath: codingPath, failure: fail)
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        fail(.unsupportedContainer)
        return StatementFailingSingleValueEncodingContainer(codingPath: codingPath, failure: fail)
    }

    func fail(_ error: StatementCodingFailure) {
        if failure == nil {
            failure = error
        }
    }
}

struct StatementBindingContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
    var codingPath: [CodingKey] { encoder.codingPath }
    let encoder: StatementBindingEncoder

    init(encoder: StatementBindingEncoder) {
        self.encoder = encoder
    }

    mutating func encodeNil(forKey key: Key) throws {
        let index = try parameterIndex(for: key)
        try bindResult(encoder.statement.bindNull(at: index))
    }

    mutating func encode(_ value: Bool, forKey key: Key) throws {
        try unsupportedValue()
    }

    mutating func encode(_ value: String, forKey key: Key) throws {
        let index = try parameterIndex(for: key)
        try bindResult(encoder.statement.bindText(value, at: index))
    }

    mutating func encode(_ value: Double, forKey key: Key) throws {
        let index = try parameterIndex(for: key)
        try bindResult(encoder.statement.bindDouble(value, at: index))
    }

    mutating func encode(_ value: Float, forKey key: Key) throws {
        try unsupportedValue()
    }

    mutating func encode(_ value: Int, forKey key: Key) throws {
        let index = try parameterIndex(for: key)
        try bindResult(encoder.statement.bindInt64(Int64(value), at: index))
    }

    mutating func encode(_ value: Int8, forKey key: Key) throws {
        try unsupportedValue()
    }

    mutating func encode(_ value: Int16, forKey key: Key) throws {
        try unsupportedValue()
    }

    mutating func encode(_ value: Int32, forKey key: Key) throws {
        try unsupportedValue()
    }

    mutating func encode(_ value: Int64, forKey key: Key) throws {
        try unsupportedValue()
    }

    mutating func encode(_ value: UInt, forKey key: Key) throws {
        try unsupportedValue()
    }

    mutating func encode(_ value: UInt8, forKey key: Key) throws {
        try unsupportedValue()
    }

    mutating func encode(_ value: UInt16, forKey key: Key) throws {
        try unsupportedValue()
    }

    mutating func encode(_ value: UInt32, forKey key: Key) throws {
        try unsupportedValue()
    }

    mutating func encode(_ value: UInt64, forKey key: Key) throws {
        try unsupportedValue()
    }

    mutating func encode<T: Encodable>(_ value: T, forKey key: Key) throws {
        if let data = value as? Data {
            let index = try parameterIndex(for: key)
            try bindData(data, at: index)
            return
        }
        try unsupportedValue()
    }

    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> {
        encoder.fail(.unsupportedContainer)
        return KeyedEncodingContainer(StatementFailingKeyedEncodingContainer(codingPath: codingPath, failure: encoder.fail))
    }

    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        encoder.fail(.unsupportedContainer)
        return StatementFailingUnkeyedEncodingContainer(codingPath: codingPath, failure: encoder.fail)
    }

    mutating func superEncoder() -> Encoder {
        encoder.fail(.unsupportedContainer)
        return StatementFailingEncoder(codingPath: codingPath, failure: encoder.fail)
    }

    mutating func superEncoder(forKey key: Key) -> Encoder {
        encoder.fail(.unsupportedContainer)
        return StatementFailingEncoder(codingPath: codingPath, failure: encoder.fail)
    }

    func parameterIndex(for key: Key) throws -> Int32 {
        let name = key.stringValue
        guard let index = encoder.parameterMap[name] else {
            encoder.fail(.invalidParameter)
            throw StatementCodingFailure.invalidParameter
        }
        return index
    }

    func bindResult(_ result: ResultCode) throws {
        guard result == .ok else {
            encoder.fail(.unsupportedValue)
            throw StatementCodingFailure.unsupportedValue
        }
    }

    func bindData(_ data: Data, at index: Int32) throws {
        if data.isEmpty {
            try bindResult(encoder.statement.bindZeroBlob(length: 0, at: index))
            return
        }
        let result: ResultCode = data.withUnsafeBytes { buffer in
            guard let baseAddress = buffer.baseAddress else {
                return encoder.statement.bindZeroBlob(length: 0, at: index)
            }
            return encoder.statement.bindTransientBlob(baseAddress, length: Int32(buffer.count), at: index)
        }
        try bindResult(result)
    }

    func unsupportedValue() throws {
        encoder.fail(.unsupportedValue)
        throw StatementCodingFailure.unsupportedValue
    }
}
