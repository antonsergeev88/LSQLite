import SQLite3

extension Statement {
    @inlinable public var database: Database {
        Database(rawValue: sqlite3_db_handle(rawValue))
    }
}
