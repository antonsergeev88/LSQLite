/// Wrapper around a prepared statement handle.
///
/// A prepared statement is compiled SQL ready for execution. A typical
/// lifecycle is:
/// 1. Prepare SQL into a statement.
/// 2. Bind parameter values.
/// 3. Call `step()` to evaluate the statement and read rows.
/// 4. Call `reset()` to run it again with new bindings.
/// 5. Call `finalize()` to release resources.
///
/// Bind parameters before stepping, or after a reset. Binding while a
/// statement is active results in `.misuse`.
///
/// Column accessors are only valid after `step()` returns `.row` and
/// before the next `step()`, `reset()`, or `finalize()` call.
///
/// Related SQLite: `sqlite3_stmt`, `sqlite3_prepare_v2`, `sqlite3_finalize`
@frozen public struct Statement: RawRepresentable {
    public let rawValue: OpaquePointer

    @inlinable public init(rawValue: OpaquePointer) {
        self.rawValue = rawValue
    }
}
