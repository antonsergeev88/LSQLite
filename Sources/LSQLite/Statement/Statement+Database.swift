import MissedSwiftSQLite

extension Statement {
    @inlinable public var database: Database? {
        return sqlite3_db_handle(rawValue).map(Database.init(rawValue:))
    }
}
