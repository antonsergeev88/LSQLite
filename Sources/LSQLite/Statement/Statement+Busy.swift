import MissedSwiftSQLite

extension Statement {
    /// True if the statement has been stepped and not yet finished or reset.
    /// - Returns: `true` when the statement is currently active.
    ///
    /// Related SQLite: `sqlite3_stmt_busy`
    @inlinable public var isBusy: Bool {
        sqlite3_stmt_busy(rawValue) != 0
    }
}
