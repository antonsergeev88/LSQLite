/// Wrapper around an open BLOB handle for incremental I/O.
///
/// Create a handle with `Connection.openBlob(_:databaseName:tableName:columnName:rowID:flags:)`
/// and close it when finished. Do not use the handle after closing.
///
/// Related SQLite: `sqlite3_blob`, `sqlite3_blob_open`, `sqlite3_blob_close`, `sqlite3_blob_read`, `sqlite3_blob_write`, `sqlite3_blob_bytes`
@frozen public struct Blob: RawRepresentable {
    public let rawValue: OpaquePointer

    @inlinable public init(rawValue: OpaquePointer) {
        self.rawValue = rawValue
    }
}
