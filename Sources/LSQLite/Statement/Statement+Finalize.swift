import SQLite3

extension Statement {
    /// Finalizes and destroys the prepared statement handle.
    ///
    /// Related SQLite: `sqlite3_finalize`
    @inlinable public func finalize() -> ResultCode {
        sqlite3_finalize(rawValue).resultCode
    }
}
