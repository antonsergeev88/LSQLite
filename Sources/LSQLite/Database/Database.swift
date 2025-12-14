/// Wrapper around an SQLite database connection handle used by the higher-level `Database` API.
///
/// Related SQLite: `sqlite3`, `sqlite3_open`, `sqlite3_open_v2`, `sqlite3_close`, `sqlite3_close_v2`
@frozen public struct Database: RawRepresentable, @unchecked Sendable {
    public let rawValue: OpaquePointer

    @inlinable public init(rawValue: OpaquePointer) {
        self.rawValue = rawValue
    }
}
