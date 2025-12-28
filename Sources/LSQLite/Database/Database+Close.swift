import MissedSwiftSQLite

extension Database {
    /// Closes the connection immediately.
    ///
    /// This call fails with `.busy` if there are unfinalized statements, open BLOB handles,
    /// or unfinished backups. In that case the connection remains open and usable.
    /// When the close succeeds, any open transaction is rolled back automatically.
    /// - Returns: Result code from the close attempt.
    ///
    /// Related SQLite: `sqlite3_close`, `sqlite3_finalize`, `sqlite3_blob_close`, `sqlite3_backup_finish`
    @inlinable public func close() -> ResultCode {
        sqlite3_close(rawValue).resultCode
    }

    /// Marks the connection for closure and makes it unusable immediately.
    ///
    /// If statements, BLOB handles, or backups remain open, the connection becomes a zombie and is
    /// deallocated after those resources are released. This call returns `.ok` in that case, and
    /// the handle must not be used again. When final teardown happens, any open transaction is
    /// rolled back. This is useful when destruction order is not deterministic.
    /// - Returns: Result code from the close attempt.
    ///
    /// Related SQLite: `sqlite3_close_v2`, `sqlite3_finalize`, `sqlite3_blob_close`, `sqlite3_backup_finish`
    @available(iOS 8.2, macOS 10.10, tvOS 8.2, watchOS 2.0, *)
    @inlinable public func closeV2() -> ResultCode {
        sqlite3_close_v2(rawValue).resultCode
    }
}
