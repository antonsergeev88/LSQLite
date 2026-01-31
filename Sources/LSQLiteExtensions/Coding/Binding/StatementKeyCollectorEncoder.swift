import Foundation

final class StatementKeyCollectorEncoder: Encoder {
    var codingPath: [CodingKey] = []
    var userInfo: [CodingUserInfoKey: Any] = [:]
    var keys: Set<String> = []
    var failure: StatementCodingFailure?

    init() {}

    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> {
        return KeyedEncodingContainer(StatementKeyCollectorContainer(encoder: self))
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        fail(.unsupportedContainer)
        return StatementFailingUnkeyedEncodingContainer(codingPath: codingPath, failure: fail)
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        fail(.unsupportedContainer)
        return StatementFailingSingleValueEncodingContainer(codingPath: codingPath, failure: fail)
    }

    func record<Key: CodingKey>(_ key: Key) {
        keys.insert(key.stringValue)
    }

    func fail(_ error: StatementCodingFailure) {
        if failure == nil {
            failure = error
        }
    }
}

struct StatementKeyCollectorContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
    var codingPath: [CodingKey] { encoder.codingPath }
    let encoder: StatementKeyCollectorEncoder

    init(encoder: StatementKeyCollectorEncoder) {
        self.encoder = encoder
    }

    mutating func encodeNil(forKey key: Key) throws {
        encoder.record(key)
    }

    mutating func encode(_ value: Bool, forKey key: Key) throws {
        encoder.record(key)
    }

    mutating func encode(_ value: String, forKey key: Key) throws {
        encoder.record(key)
    }

    mutating func encode(_ value: Double, forKey key: Key) throws {
        encoder.record(key)
    }

    mutating func encode(_ value: Float, forKey key: Key) throws {
        encoder.record(key)
    }

    mutating func encode(_ value: Int, forKey key: Key) throws {
        encoder.record(key)
    }

    mutating func encode(_ value: Int8, forKey key: Key) throws {
        encoder.record(key)
    }

    mutating func encode(_ value: Int16, forKey key: Key) throws {
        encoder.record(key)
    }

    mutating func encode(_ value: Int32, forKey key: Key) throws {
        encoder.record(key)
    }

    mutating func encode(_ value: Int64, forKey key: Key) throws {
        encoder.record(key)
    }

    mutating func encode(_ value: UInt, forKey key: Key) throws {
        encoder.record(key)
    }

    mutating func encode(_ value: UInt8, forKey key: Key) throws {
        encoder.record(key)
    }

    mutating func encode(_ value: UInt16, forKey key: Key) throws {
        encoder.record(key)
    }

    mutating func encode(_ value: UInt32, forKey key: Key) throws {
        encoder.record(key)
    }

    mutating func encode(_ value: UInt64, forKey key: Key) throws {
        encoder.record(key)
    }

    mutating func encode<T: Encodable>(_ value: T, forKey key: Key) throws {
        encoder.record(key)
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
}
