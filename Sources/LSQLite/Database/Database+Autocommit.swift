import MissedSwiftSQLite

extension Database {
    /// Indicates whether this connection is currently in autocommit mode (no transaction open).
    ///
    /// Autocommit is enabled by default. It is disabled by explicitly beginning a transaction
    /// and re-enabled by committing or rolling back. Some errors can trigger an automatic rollback;
    /// this property is the only reliable way to detect that condition. If another thread changes
    /// the autocommit state while this value is read, the result is undefined.
    ///
    /// Related SQLite: `sqlite3_get_autocommit`, `BEGIN`, `COMMIT`, `ROLLBACK`
    @inlinable public var isAutocommit: Bool {
        sqlite3_get_autocommit(rawValue) != 0
    }
}
