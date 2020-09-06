import MissedSwiftSQLite

extension Database {
    @inlinable public var mutex: Mutex {
        Mutex(rawValue: sqlite3_db_mutex(rawValue))
    }
}
