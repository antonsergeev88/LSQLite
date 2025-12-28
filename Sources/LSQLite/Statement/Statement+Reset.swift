import MissedSwiftSQLite

extension Statement {
    /// Resets the prepared statement to run again from the beginning.
    /// - Returns: Result code from the previous evaluation, if any.
    ///
    /// Bindings are preserved; use `clearBindings()` to reset them to NULL.
    ///
    /// Related SQLite: `sqlite3_reset`
    @inlinable public func reset() -> ResultCode {
        sqlite3_reset(rawValue).resultCode
    }
}
