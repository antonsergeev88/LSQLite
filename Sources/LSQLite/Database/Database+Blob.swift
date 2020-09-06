import MissedSwiftSQLite

extension Database {
    @frozen public struct OpenBlobFlag: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let readonly = Self(rawValue: 0)
        public static let readwrite = Self(rawValue: 1)

        public var debugDescription: String {
            switch self {
            case .readonly: return "LSQLITE_READONLY"
            case .readwrite: return "LSQLITE_READWRITE"
            default: return "OpenBlobFlag(rawValue: \(rawValue))"
            }
        }
    }

    /**
     CAPI3REF: Open A BLOB For Incremental I/O
     METHOD: sqlite3
     CONSTRUCTOR: sqlite3_blob

     ^(This interfaces opens a [BLOB handle | handle] to the BLOB located
     in row iRow, column zColumn, table zTable in database zDb;
     in other words, the same BLOB that would be selected by:

     
     SELECT zColumn FROM zDb.zTable WHERE [rowid] = iRow;
     )^

     ^(Parameter zDb is not the filename that contains the database, but
     rather the symbolic name of the database. For attached databases, this is
     the name that appears after the AS keyword in the [ATTACH] statement.
     For the main database file, the database name is "main". For TEMP
     tables, the database name is "temp".)^

     ^If the flags parameter is non-zero, then the BLOB is opened for read
     and write access. ^If the flags parameter is zero, the BLOB is opened for
     read-only access.

     ^(On success, [SQLITE_OK] is returned and the new [BLOB handle] is stored
     in *ppBlob. Otherwise an [error code] is returned and, unless the error
     code is SQLITE_MISUSE, *ppBlob is set to NULL.)^ ^This means that, provided
     the API is not misused, it is always safe to call [sqlite3_blob_close()]
     on *ppBlob after this function it returns.

     This function fails with SQLITE_ERROR if any of the following are true:
     
      ^(Database zDb does not exist)^,
      ^(Table zTable does not exist within database zDb)^,
      ^(Table zTable is a WITHOUT ROWID table)^,
      ^(Column zColumn does not exist)^,
      ^(Row iRow is not present in the table)^,
      ^(The specified column of row iRow contains a value that is not
     a TEXT or BLOB value)^,
      ^(Column zColumn is part of an index, PRIMARY KEY or UNIQUE
     constraint and the blob is being opened for read/write access)^,
      ^([foreign key constraints | Foreign key constraints] are enabled,
     column zColumn is part of a [child key] definition and the blob is
     being opened for read/write access)^.
     

     ^Unless it returns SQLITE_MISUSE, this function sets the
     [database connection] error code and message accessible via
     [sqlite3_errcode()] and [sqlite3_errmsg()] and related functions.

     A BLOB referenced by sqlite3_blob_open() may be read using the
     [sqlite3_blob_read()] interface and modified by using
     [sqlite3_blob_write()].  The [BLOB handle] can be moved to a
     different row of the same table using the [sqlite3_blob_reopen()]
     interface.  However, the column, table, or database of a [BLOB handle]
     cannot be changed after the [BLOB handle] is opened.

     ^(If the row that a BLOB handle points to is modified by an
     [UPDATE], [DELETE], or by [ON CONFLICT] side-effects
     then the BLOB handle is marked as "expired".
     This is true if any column of the row is changed, even a column
     other than the one the BLOB handle is open on.)^
     ^Calls to [sqlite3_blob_read()] and [sqlite3_blob_write()] for
     an expired BLOB handle fail with a return code of [SQLITE_ABORT].
     ^(Changes written into a BLOB prior to the BLOB expiring are not
     rolled back by the expiration of the BLOB.  Such changes will eventually
     commit if the transaction continues to completion.)^

     ^Use the [sqlite3_blob_bytes()] interface to determine the size of
     the opened blob.  ^The size of a blob may not be changed by this
     interface.  Use the [UPDATE] SQL command to change the size of a
     blob.

     ^The [sqlite3_bind_zeroblob()] and [sqlite3_result_zeroblob()] interfaces
     and the built-in [zeroblob] SQL function may be used to create a
     zero-filled blob to read or write using the incremental-blob interface.

     To avoid a resource leak, every open [BLOB handle] should eventually
     be released by a call to [sqlite3_blob_close()].

     See also: [sqlite3_blob_close()],
     [sqlite3_blob_reopen()], [sqlite3_blob_read()],
     [sqlite3_blob_bytes()], [sqlite3_blob_write()].
     */
    @inlinable public func openBlob(_ blob: inout Blob?, databaseName: UnsafePointer<Int8>, tableName: UnsafePointer<Int8>, columnName: UnsafePointer<Int8>, rowID: RowID, flags: OpenBlobFlag) -> ResultCode {
        var blobPointer: OpaquePointer? = nil
        let resultCode = sqlite3_blob_open(rawValue, databaseName, tableName, columnName, rowID.rawValue, flags.rawValue, &blobPointer).resultCode
        blob = blobPointer.map(Blob.init(rawValue:))
        return resultCode
    }
}
