import MissedSwiftSQLite

extension Statement {
    /// True if the prepared statement does not directly modify the database.
    /// - Returns: `true` when no direct database file changes occur.
    ///
    /// Indirect changes from virtual tables or custom functions are not
    /// reflected.
    ///
    /// Related SQLite: `sqlite3_stmt_readonly`
    @inlinable public var isReadonly: Bool {
        sqlite3_stmt_readonly(rawValue) != 0
    }
}
