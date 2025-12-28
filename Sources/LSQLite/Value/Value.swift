/// Wrapper around a dynamically typed SQLite value used for parameters, results, and introspection.
///
/// Values can represent integers, floating-point numbers, text, blobs, or null.
/// Values are either protected or unprotected. Protected values are safe to inspect.
/// Unprotected values are not thread-safe; copy them with `createCopy()` before
/// calling accessors in the Value extensions.
/// This wrapper does not manage the lifetime of the underlying value; keep the
/// source alive for the duration of any access or copy the value first.
///
/// Related SQLite: `sqlite3_value`, `sqlite3_value_dup`, `sqlite3_column_value`, `sqlite3_result_value`, `sqlite3_bind_value`
@frozen public struct Value: RawRepresentable {
    public let rawValue: OpaquePointer

    @inlinable public init(rawValue: OpaquePointer) {
        self.rawValue = rawValue
    }
}
