import MissedSwiftSQLite

extension Database {
    @inlinable public var mutex: Mutex? {
        return sqlite3_db_mutex(rawValue).map(Mutex.init(rawValue:))
    }
}
