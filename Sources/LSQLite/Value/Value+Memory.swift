import MissedSwiftSQLite

@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension Value {
    /// Creates a protected copy of this value.
    ///
    /// The copy is independent of the original and safe to inspect with the
    /// Value accessors.
    /// Pointer-valued inputs do not copy and return `nil`.
    /// - Returns: A protected copy, or `nil` on allocation failure or pointer values.
    ///
    /// Related SQLite: `sqlite3_value_dup`
    @inlinable public func createCopy() -> Value? {
        return sqlite3_value_dup(rawValue).map(Value.init(rawValue:))
    }

    /// Releases a value copy created by `createCopy()`.
    ///
    /// Calling this on values not created by `createCopy()` is undefined.
    /// - Returns: Nothing.
    ///
    /// Related SQLite: `sqlite3_value_free`
    @inlinable public func free() {
        sqlite3_value_free(rawValue)
    }
}
