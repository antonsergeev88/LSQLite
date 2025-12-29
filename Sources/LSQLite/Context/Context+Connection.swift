import MissedSwiftSQLite

extension Context {
    /// Returns the database connection associated with this function context.
    /// - Returns: Database connection for the function invocation, or `nil` if unavailable.
    ///
    /// Related SQLite: `sqlite3_context_db_handle`, `sqlite3_create_function_v2`
    @inlinable public var connection: Connection? {
        return sqlite3_context_db_handle(rawValue).map(Connection.init(rawValue:))
    }
}
