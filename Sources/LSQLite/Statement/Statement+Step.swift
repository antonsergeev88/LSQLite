import SQLite3

extension Statement {
    /// Steps the prepared statement once, returning the SQLite result code (row, done, or error).
    ///
    /// Related SQLite: `sqlite3_step`, `sqlite3_reset`
    @inlinable public func step() -> ResultCode {
        sqlite3_step(rawValue).resultCode
    }
}
