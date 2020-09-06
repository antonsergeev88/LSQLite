import MissedSwiftSQLite

extension Database {
    @inlinable public var mutex: Mutex? {
        guard let mutexPointer = sqlite3_db_mutex(rawValue) else {
            return nil
        }
        return Mutex(rawValue: mutexPointer)
    }
}
