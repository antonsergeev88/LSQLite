import MissedSwiftSQLite

@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension Value {
    @inlinable public func createCopy() -> Value {
        Value(rawValue: sqlite3_value_dup(rawValue))
    }

    @inlinable public func free() {
        sqlite3_value_free(rawValue)
    }
}
