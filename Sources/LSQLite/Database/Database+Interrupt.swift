import MissedSwiftSQLite

extension Database {
    /// Requests that all running statements on this connection abort with `SQLITE_INTERRUPT`.
    ///
    /// Related SQLite: `sqlite3_interrupt`, `SQLITE_INTERRUPT`
    @inlinable public func interrupt() {
        sqlite3_interrupt(rawValue)
    }
}
