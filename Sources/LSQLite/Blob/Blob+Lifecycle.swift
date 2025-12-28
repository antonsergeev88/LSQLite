import MissedSwiftSQLite

extension Blob {
    /// Moves this handle to a different row of the same table.
    ///
    /// The database, table, and column stay the same. If the target row is missing or does not
    /// contain a BLOB or TEXT value, the call returns `.error` and the handle becomes aborted.
    /// Aborted handles cause `read`, `write`, and `reopen` to return `.abort`, and `byteCount`
    /// returns 0.
    ///
    /// Note: This call updates the connection error code and message.
    /// - Parameter rowID: Target rowid.
    /// - Returns: Result code for the operation.
    ///
    /// Related SQLite: `sqlite3_blob_reopen`
    @inlinable public func reopen(at rowID: RowID) -> ResultCode {
        sqlite3_blob_reopen(rawValue, rowID.rawValue).resultCode
    }

    /// Closes this handle.
    ///
    /// Closing always releases the handle, even if an error is returned.
    /// If the handle was opened for writing and the connection is in autocommit mode, closing
    /// may commit the current transaction when there are no other open read/write BLOB handles
    /// or active write statements. If the commit fails, an error is returned and the transaction
    /// is rolled back.
    /// - Returns: Result code for the close.
    ///
    /// Related SQLite: `sqlite3_blob_close`
    @inlinable public func close() -> ResultCode {
        sqlite3_blob_close(rawValue).resultCode
    }
}
