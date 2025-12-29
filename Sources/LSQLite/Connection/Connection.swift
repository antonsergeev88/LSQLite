/// Wrapper around an open database connection handle.
///
/// Create instances using the open routines and close them to release resources.
/// Most database APIs operate on the same connection state represented by this value.
/// Use `rawValue` to access the underlying handle when needed.
///
/// Related SQLite: `sqlite3`, `sqlite3_open`, `sqlite3_open_v2`, `sqlite3_close`, `sqlite3_close_v2`
@frozen public struct Connection: RawRepresentable {
    public let rawValue: OpaquePointer

    @inlinable public init(rawValue: OpaquePointer) {
        self.rawValue = rawValue
    }
}
