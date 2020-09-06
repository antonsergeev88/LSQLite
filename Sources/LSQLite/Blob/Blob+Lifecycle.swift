import MissedSwiftSQLite

extension Blob {
    /**
     CAPI3REF: Move a BLOB Handle to a New Row
     METHOD: sqlite3_blob

     ^This function is used to move an existing [BLOB handle] so that it points
     to a different row of the same database table. ^The new row is identified
     by the rowid value passed as the second argument. Only the row can be
     changed. ^The database, table and column on which the blob handle is open
     remain the same. Moving an existing [BLOB handle] to a new row is
     faster than closing the existing handle and opening a new one.

     ^(The new row must meet the same criteria as for [sqlite3_blob_open()] -
     it must exist and there must be either a blob or text value stored in
     the nominated column.)^ ^If the new row is not present in the table, or if
     it does not contain a blob or text value, or if another error occurs, an
     SQLite error code is returned and the blob handle is considered aborted.
     ^All subsequent calls to [sqlite3_blob_read()], [sqlite3_blob_write()] or
     [sqlite3_blob_reopen()] on an aborted blob handle immediately return
     SQLITE_ABORT. ^Calling [sqlite3_blob_bytes()] on an aborted blob handle
     always returns zero.

     ^This function sets the database handle error code and message.
     */
    @inlinable public func reopen(at rowID: RowID) -> ResultCode {
        sqlite3_blob_reopen(rawValue, rowID.rawValue).resultCode
    }

    /**
     CAPI3REF: Close A BLOB Handle
     DESTRUCTOR: sqlite3_blob

     ^This function closes an open [BLOB handle]. ^(The BLOB handle is closed
     unconditionally.  Even if this routine returns an error code, the
     handle is still closed.)^

     ^If the blob handle being closed was opened for read-write access, and if
     the database is in auto-commit mode and there are no other open read-write
     blob handles or active write statements, the current transaction is
     committed. ^If an error occurs while committing the transaction, an error
     code is returned and the transaction rolled back.

     Calling this function with an argument that is not a NULL pointer or an
     open blob handle results in undefined behaviour. ^Calling this routine
     with a null pointer (such as would be returned by a failed call to
     [sqlite3_blob_open()]) is a harmless no-op. ^Otherwise, if this function
     is passed a valid open blob handle, the values returned by the
     sqlite3_errcode() and sqlite3_errmsg() functions are set before returning.
     */
    @inlinable public func close() -> ResultCode {
        sqlite3_blob_close(rawValue).resultCode
    }
}
