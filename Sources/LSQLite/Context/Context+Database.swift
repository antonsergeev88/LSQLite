import MissedSwiftSQLite

extension Context {
    @inlinable public var database: Database? {
        return sqlite3_context_db_handle(rawValue).map(Database.init(rawValue:))
    }
}
