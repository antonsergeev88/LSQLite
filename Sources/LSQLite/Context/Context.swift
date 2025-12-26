/// Wrapper around the SQLite function evaluation context passed into user-defined functions.
///
/// Related SQLite: `sqlite3_context`, `sqlite3_result_*`, `sqlite3_user_data`, `sqlite3_aggregate_context`, `sqlite3_get_auxdata`
@frozen public struct Context: RawRepresentable {
    public let rawValue: OpaquePointer

    @inlinable public init(rawValue: OpaquePointer) {
        self.rawValue = rawValue
    }
}
