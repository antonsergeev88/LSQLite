import SQLite3

extension Blob {
    /// Moves this BLOB handle to a different row of the same table.
    /// - Parameter rowID: Target rowid.
    /// - Returns: Result of `sqlite3_blob_reopen`.
    ///
    /// Related SQLite: `sqlite3_blob_reopen`, `sqlite3_blob_read`, `sqlite3_blob_write`, `sqlite3_blob_bytes`
    @inlinable public func reopen(at rowID: RowID) -> ResultCode {
        sqlite3_blob_reopen(rawValue, rowID.rawValue).resultCode
    }

    /// Closes this BLOB handle; auto-commit transactions may finalize if no other writers remain.
    /// - Returns: Result of `sqlite3_blob_close`.
    ///
    /// Related SQLite: `sqlite3_blob_close`, `sqlite3_errcode`, `sqlite3_errmsg`
    @inlinable public func close() -> ResultCode {
        sqlite3_blob_close(rawValue).resultCode
    }
}
