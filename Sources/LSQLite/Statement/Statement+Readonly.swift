import SQLite3

extension Statement {
    /// True if the prepared statement does not directly modify the database.
    ///
    /// Related SQLite: `sqlite3_stmt_readonly`
    @inlinable public var isReadonly: Bool {
        sqlite3_stmt_readonly(rawValue) != 0
    }
}
