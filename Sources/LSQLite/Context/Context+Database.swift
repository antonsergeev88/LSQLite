import MissedSwiftSQLite

extension Context {
    /// Returns the database connection associated with this function context.
    ///
    /// Related SQLite: `sqlite3_context_db_handle`, `sqlite3_create_function_v2`
    @inlinable public var database: Database? {
        return sqlite3_context_db_handle(rawValue).map(Database.init(rawValue:))
    }
}
