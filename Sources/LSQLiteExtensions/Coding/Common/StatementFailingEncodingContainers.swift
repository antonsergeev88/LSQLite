import Foundation

struct StatementFailingKeyedEncodingContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
    var codingPath: [CodingKey]
    let failure: (StatementCodingFailure) -> Void

    init(codingPath: [CodingKey], failure: @escaping (StatementCodingFailure) -> Void) {
        self.codingPath = codingPath
        self.failure = failure
    }

    mutating func encodeNil(forKey key: Key) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Bool, forKey key: Key) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: String, forKey key: Key) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Double, forKey key: Key) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Float, forKey key: Key) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Int, forKey key: Key) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Int8, forKey key: Key) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Int16, forKey key: Key) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Int32, forKey key: Key) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Int64, forKey key: Key) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: UInt, forKey key: Key) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: UInt8, forKey key: Key) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: UInt16, forKey key: Key) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: UInt32, forKey key: Key) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: UInt64, forKey key: Key) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode<T: Encodable>(_ value: T, forKey key: Key) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> {
        failure(.unsupportedContainer)
        return KeyedEncodingContainer(StatementFailingKeyedEncodingContainer<NestedKey>(codingPath: codingPath, failure: failure))
    }

    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        failure(.unsupportedContainer)
        return StatementFailingUnkeyedEncodingContainer(codingPath: codingPath, failure: failure)
    }

    mutating func superEncoder() -> Encoder {
        failure(.unsupportedContainer)
        return StatementFailingEncoder(codingPath: codingPath, failure: failure)
    }

    mutating func superEncoder(forKey key: Key) -> Encoder {
        failure(.unsupportedContainer)
        return StatementFailingEncoder(codingPath: codingPath, failure: failure)
    }
}

struct StatementFailingUnkeyedEncodingContainer: UnkeyedEncodingContainer {
    var codingPath: [CodingKey]
    var count: Int = 0
    let failure: (StatementCodingFailure) -> Void

    init(codingPath: [CodingKey], failure: @escaping (StatementCodingFailure) -> Void) {
        self.codingPath = codingPath
        self.failure = failure
    }

    mutating func encodeNil() throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Bool) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: String) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Double) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Float) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Int) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Int8) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Int16) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Int32) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Int64) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: UInt) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: UInt8) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: UInt16) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: UInt32) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: UInt64) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode<T: Encodable>(_ value: T) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> {
        failure(.unsupportedContainer)
        return KeyedEncodingContainer(StatementFailingKeyedEncodingContainer<NestedKey>(codingPath: codingPath, failure: failure))
    }

    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        failure(.unsupportedContainer)
        return StatementFailingUnkeyedEncodingContainer(codingPath: codingPath, failure: failure)
    }

    mutating func superEncoder() -> Encoder {
        failure(.unsupportedContainer)
        return StatementFailingEncoder(codingPath: codingPath, failure: failure)
    }
}

struct StatementFailingSingleValueEncodingContainer: SingleValueEncodingContainer {
    var codingPath: [CodingKey]
    let failure: (StatementCodingFailure) -> Void

    init(codingPath: [CodingKey], failure: @escaping (StatementCodingFailure) -> Void) {
        self.codingPath = codingPath
        self.failure = failure
    }

    mutating func encodeNil() throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Bool) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: String) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Double) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Float) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Int) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Int8) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Int16) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Int32) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: Int64) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: UInt) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: UInt8) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: UInt16) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: UInt32) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode(_ value: UInt64) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }

    mutating func encode<T: Encodable>(_ value: T) throws {
        failure(.unsupportedContainer)
        throw StatementCodingFailure.unsupportedContainer
    }
}

final class StatementFailingEncoder: Encoder {
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey: Any] = [:]
    let failure: (StatementCodingFailure) -> Void

    init(codingPath: [CodingKey], failure: @escaping (StatementCodingFailure) -> Void) {
        self.codingPath = codingPath
        self.failure = failure
    }

    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> {
        failure(.unsupportedContainer)
        return KeyedEncodingContainer(StatementFailingKeyedEncodingContainer(codingPath: codingPath, failure: failure))
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        failure(.unsupportedContainer)
        return StatementFailingUnkeyedEncodingContainer(codingPath: codingPath, failure: failure)
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        failure(.unsupportedContainer)
        return StatementFailingSingleValueEncodingContainer(codingPath: codingPath, failure: failure)
    }
}
