import MissedSwiftSQLite

extension Database {
    /// Mutex guarding this connection in serialized threading mode; `nil` otherwise.
    ///
    /// Related SQLite: `sqlite3_db_mutex`, `sqlite3_mutex`, `threading mode`
    @inlinable public var mutex: Mutex? {
        return sqlite3_db_mutex(rawValue).map(Mutex.init(rawValue:))
    }
}
