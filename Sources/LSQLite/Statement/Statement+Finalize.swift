import MissedSwiftSQLite

extension Statement {
    /// Finalizes and destroys the prepared statement handle.
    /// - Returns: Result code from the most recent evaluation, if any.
    ///
    /// The statement must not be used after finalization.
    ///
    /// Related SQLite: `sqlite3_finalize`
    @inlinable public func finalize() -> ResultCode {
        sqlite3_finalize(rawValue).resultCode
    }
}
