import MissedSwiftSQLite

extension Blob {
    /// Moves this handle to a different row of the same table.
    ///
    /// The database, table, and column stay the same. On failure, the handle becomes
    /// aborted and `read` or `write` return `.abort`.
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
    /// - Returns: Result code for the close.
    ///
    /// Related SQLite: `sqlite3_blob_close`
    @inlinable public func close() -> ResultCode {
        sqlite3_blob_close(rawValue).resultCode
    }
}
