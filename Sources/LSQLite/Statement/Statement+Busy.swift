import MissedSwiftSQLite

extension Statement {
    /// True if the statement has been stepped and not yet finished or reset.
    ///
    /// Related SQLite: `sqlite3_stmt_busy`, `sqlite3_step`, `sqlite3_reset`
    @inlinable public var isBusy: Bool {
        sqlite3_stmt_busy(rawValue) != 0
    }
}
