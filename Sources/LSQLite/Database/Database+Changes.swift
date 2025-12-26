import SQLite3

extension Database {
    /// Number of rows changed by the most recent INSERT, UPDATE, or DELETE on this connection (excludes trigger side-effects).
    ///
    /// Related SQLite: `sqlite3_changes`, `changes() SQL function`, `PRAGMA count_changes`
    @inlinable public var changes: Int32 {
        sqlite3_changes(rawValue)
    }

    /// Total number of rows inserted, updated, or deleted since this connection was opened (trigger work included).
    ///
    /// Related SQLite: `sqlite3_total_changes`, `sqlite3_changes`, `PRAGMA data_version`, `SQLITE_FCNTL_DATA_VERSION`
    @inlinable public var totalChanges: Int32 {
        sqlite3_total_changes(rawValue)
    }
}
