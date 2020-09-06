import MissedSwiftSQLite

@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension Value {
    @inlinable public func createCopy() -> Value? {
        return sqlite3_value_dup(rawValue).map(Value.init(rawValue:))
    }

    @inlinable public func free() {
        sqlite3_value_free(rawValue)
    }
}
