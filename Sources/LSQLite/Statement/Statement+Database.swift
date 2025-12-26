import MissedSwiftSQLite

extension Statement {
    /// Database connection that owns this prepared statement.
    ///
    /// Related SQLite: `sqlite3_db_handle`
    @inlinable public var database: Database? {
        return sqlite3_db_handle(rawValue).map(Database.init(rawValue:))
    }
}
