import MissedSwiftSQLite

extension Database {
    /// Closes the connection immediately; fails with `.busy` if statements, blobs, or backups are still open.
    /// - Returns: Result of `sqlite3_close`.
    ///
    /// Related SQLite: `sqlite3_close`, `sqlite3_finalize`, `sqlite3_blob_close`, `sqlite3_backup_finish`
    @inlinable public func close() -> ResultCode {
        sqlite3_close(rawValue).resultCode
    }

    /// Marks the connection for closure; remaining statements, blobs, or backups can finish before final teardown.
    /// - Returns: Result of `sqlite3_close_v2`.
    ///
    /// Related SQLite: `sqlite3_close_v2`, `sqlite3_finalize`, `sqlite3_blob_close`, `sqlite3_backup_finish`
    @available(iOS 8.2, macOS 10.10, tvOS 8.2, watchOS 2.0, *)
    @inlinable public func closeV2() -> ResultCode {
        sqlite3_close_v2(rawValue).resultCode
    }
}
