import MissedSwiftSQLite

extension Statement {
    /// Evaluates the prepared statement once.
    /// - Returns: Result code indicating a row is available, the statement
    ///   finished, or an error occurred.
    ///
    /// After `.done` or an error, call `reset()` before stepping again.
    ///
    /// Related SQLite: `sqlite3_step`
    @inlinable public func step() -> ResultCode {
        sqlite3_step(rawValue).resultCode
    }
}
