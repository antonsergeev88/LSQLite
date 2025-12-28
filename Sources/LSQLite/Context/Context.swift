/// Function evaluation context passed into user-defined SQL functions.
///
/// Use this value during a function callback to set the result, access
/// per-function user data, and manage aggregate or auxiliary state.
/// The context is only valid for the duration of the callback and must be
/// used from that same thread.
///
/// Related SQLite: `sqlite3_context`, `sqlite3_result_*`, `sqlite3_user_data`, `sqlite3_aggregate_context`, `sqlite3_get_auxdata`
@frozen public struct Context: RawRepresentable {
    public let rawValue: OpaquePointer

    @inlinable public init(rawValue: OpaquePointer) {
        self.rawValue = rawValue
    }
}
