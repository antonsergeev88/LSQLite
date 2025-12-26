/// Wrapper around an open SQLite BLOB handle for incremental I/O.
///
/// Related SQLite: `sqlite3_blob_open`, `sqlite3_blob_close`, `sqlite3_blob_read`, `sqlite3_blob_write`, `sqlite3_blob_bytes`
@frozen public struct Blob: RawRepresentable {
    public let rawValue: OpaquePointer

    @inlinable public init(rawValue: OpaquePointer) {
        self.rawValue = rawValue
    }
}
