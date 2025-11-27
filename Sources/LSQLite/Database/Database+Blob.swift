import MissedSwiftSQLite

extension Database {
    /// Access flags for incremental BLOB I/O opened via `openBlob(_:databaseName:tableName:columnName:rowID:flags:)`.
    ///
    /// Related SQLite: `sqlite3_blob_open`
    @frozen public struct OpenBlobFlag: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let readonly = Self(rawValue: 0)
        public static let readwrite = Self(rawValue: 1)

        /// Debug label for blob open flags.
        ///
        /// Related SQLite: `sqlite3_blob_open`
        public var debugDescription: String {
            switch self {
            case .readonly: return "LSQLITE_READONLY"
            case .readwrite: return "LSQLITE_READWRITE"
            default: return "OpenBlobFlag(rawValue: \(rawValue))"
            }
        }
    }

    /// Opens a blob handle for incremental I/O against a specific row/column.
    /// - Parameters:
    ///   - blob: Output blob handle.
    ///   - databaseName: Database name (`"main"`, `"temp"`, or attached name).
    ///   - tableName: Table owning the BLOB column.
    ///   - columnName: Column holding the BLOB/TEXT value.
    ///   - rowID: Rowid to target.
    ///   - flags: Access mode for the handle.
    /// - Returns: Result of `sqlite3_blob_open`.
    ///
    /// Related SQLite: `sqlite3_blob_open`, `sqlite3_blob_read`, `sqlite3_blob_write`, `sqlite3_blob_reopen`, `sqlite3_blob_close`
    @inlinable public func openBlob(_ blob: inout Blob?, databaseName: UnsafePointer<Int8>, tableName: UnsafePointer<Int8>, columnName: UnsafePointer<Int8>, rowID: RowID, flags: OpenBlobFlag) -> ResultCode {
        var blobPointer: OpaquePointer? = nil
        let resultCode = sqlite3_blob_open(rawValue, databaseName, tableName, columnName, rowID.rawValue, flags.rawValue, &blobPointer).resultCode
        blob = blobPointer.map(Blob.init(rawValue:))
        return resultCode
    }
}
