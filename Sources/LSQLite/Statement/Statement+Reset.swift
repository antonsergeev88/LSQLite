import MissedSwiftSQLite

extension Statement {
    /// Resets the prepared statement to run again from the beginning.
    ///
    /// Related SQLite: `sqlite3_reset`
    @inlinable public func reset() -> ResultCode {
        sqlite3_reset(rawValue).resultCode
    }
}
