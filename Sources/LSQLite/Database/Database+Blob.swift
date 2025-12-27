import MissedSwiftSQLite

extension Database {
    /// Access flags for incremental BLOB I/O opened via `openBlob(_:databaseName:tableName:columnName:rowID:flags:)`.
    ///
    /// Use `.readonly` for read-only access or `.readwrite` for read/write access. SQLite treats any
    /// non-zero value as read/write; this wrapper uses `1`.
    ///
    /// Related SQLite: `sqlite3_blob_open`
    @frozen public struct OpenBlobFlag: Hashable, RawRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let readonly = Self(rawValue: 0)
        public static let readwrite = Self(rawValue: 1)

        public var description: String {
            switch self {
            case .readonly: return "readonly"
            case .readwrite: return "readwrite"
            default: return rawValue.description
            }
        }

        public var debugDescription: String {
            "\(description) (\(rawValue.description))"
        }
    }

    /// Opens a BLOB handle for incremental I/O against a specific row/column.
    ///
    /// The handle refers to the same value selected by:
    /// ```
    /// SELECT columnName FROM databaseName.tableName WHERE rowid = rowID;
    /// ```
    ///
    /// `databaseName` is the symbolic database name, not a filename. Use `"main"` for the primary
    /// database, `"temp"` for TEMP tables, or the alias from `ATTACH`.
    ///
    /// If `flags` is `.readwrite`, the BLOB is opened for read/write access. If `flags` is `.readonly`,
    /// the BLOB is opened for read-only access.
    ///
    /// On success this returns `.ok` and stores a new `Blob` in `blob`. On error, `blob` is set to
    /// `nil` unless the result is `.misuse`. When the result is not `.misuse`, it is always safe to
    /// call `Blob.close()` after this function returns.
    ///
    /// This call fails with `.error` if any of the following are true:
    /// - Database `databaseName` does not exist.
    /// - Table `tableName` does not exist within `databaseName`.
    /// - Table `tableName` is a WITHOUT ROWID table.
    /// - Column `columnName` does not exist.
    /// - Row `rowID` is not present in the table.
    /// - The specified column value is not TEXT or BLOB.
    /// - Column `columnName` is part of an index, PRIMARY KEY, or UNIQUE constraint and the BLOB is opened for read/write access.
    /// - Foreign key constraints are enabled, `columnName` is part of a child key definition, and the BLOB is opened for read/write access.
    ///
    /// Note: Unless the result is `.misuse`, this call sets the connection error code and message
    /// available via `lastErrorCode` and `lastErrorMessage`.
    ///
    /// A BLOB handle can be read with `Blob.read(into:length:offset:)` and written with
    /// `Blob.write(_:length:offset:)`. Use `Blob.reopen(at:)` to move the handle to a different row in
    /// the same table. The column, table, and database cannot be changed after opening.
    ///
    /// If the row is modified by UPDATE, DELETE, or ON CONFLICT side effects, the handle becomes
    /// expired. Reads and writes on an expired handle return `.abort`. Changes written before
    /// expiration are not rolled back; they will commit if the transaction completes.
    ///
    /// Use `Blob.byteCount` to get the size of the opened BLOB. The size cannot be changed by this
    /// interface; use UPDATE to change the size. Use `Statement.bindZeroBlob(length:at:)`,
    /// `Context.resultZeroBlob(length:)`, or the `zeroblob` SQL function to create a zero-filled
    /// BLOB suitable for incremental I/O.
    ///
    /// To avoid resource leaks, close every open BLOB handle with `Blob.close()`.
    /// - Parameters:
    ///   - blob: Output blob handle.
    ///   - databaseName: Database name (`"main"`, `"temp"`, or attached name).
    ///   - tableName: Table owning the BLOB column.
    ///   - columnName: Column holding the BLOB/TEXT value.
    ///   - rowID: Rowid to target.
    ///   - flags: Access mode for the handle.
    /// - Returns: Result of `sqlite3_blob_open`.
    ///
    /// Related SQLite: `sqlite3_blob_open`, `sqlite3_blob_read`, `sqlite3_blob_write`, `sqlite3_blob_reopen`, `sqlite3_blob_close`, `sqlite3_blob_bytes`
    @inlinable public func openBlob(_ blob: inout Blob?, databaseName: String, tableName: String, columnName: String, rowID: RowID, flags: OpenBlobFlag) -> ResultCode {
        var blobPointer: OpaquePointer? = nil
        let resultCode = sqlite3_blob_open(rawValue, databaseName, tableName, columnName, rowID.rawValue, flags.rawValue, &blobPointer).resultCode
        blob = blobPointer.map(Blob.init(rawValue:))
        return resultCode
    }
}
