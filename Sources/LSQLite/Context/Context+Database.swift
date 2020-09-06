import MissedSwiftSQLite

extension Context {
    @inlinable public var database: Database {
        Database(rawValue: sqlite3_context_db_handle(rawValue))
    }
}
