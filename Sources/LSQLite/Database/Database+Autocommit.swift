import MissedSwiftSQLite

extension Database {
    /// Indicates whether this connection is currently in autocommit mode (no transaction open).
    ///
    /// Related SQLite: `sqlite3_get_autocommit`, `BEGIN`, `COMMIT`, `ROLLBACK`
    @inlinable public var isAutocommit: Bool {
        sqlite3_get_autocommit(rawValue) != 0
    }
}
