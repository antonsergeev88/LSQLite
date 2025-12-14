/// Wrapper around an SQLite value object used for parameters, results, and introspection.
///
/// Related SQLite: `sqlite3_value`, `sqlite3_value_dup`, `sqlite3_column_value`, `sqlite3_result_value`, `sqlite3_bind_value`
@frozen public struct Value: RawRepresentable, @unchecked Sendable {
    public let rawValue: OpaquePointer

    @inlinable public init(rawValue: OpaquePointer) {
        self.rawValue = rawValue
    }
}
