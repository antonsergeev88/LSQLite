import SQLite3

@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension Value {
    /// Creates a protected copy of this value.
    ///
    /// Related SQLite: `sqlite3_value_dup`
    @inlinable public func createCopy() -> Value? {
        return sqlite3_value_dup(rawValue).map(Value.init(rawValue:))
    }

    /// Releases a value copy created with sqlite3_value_dup.
    ///
    /// Related SQLite: `sqlite3_value_free`
    @inlinable public func free() {
        sqlite3_value_free(rawValue)
    }
}
