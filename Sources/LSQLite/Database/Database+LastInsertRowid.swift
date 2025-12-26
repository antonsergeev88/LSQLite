import SQLite3

extension Database {
    /// Rowid of the most recent successful INSERT on this connection (rowid tables only).
    ///
    /// Related SQLite: `sqlite3_last_insert_rowid`, `last_insert_rowid()`
    @inlinable public func lastInsertedRowID() -> RowID {
        RowID(rawValue: sqlite3_last_insert_rowid(rawValue))
    }

    /// Overrides the last-inserted rowid value reported for this connection.
    ///
    /// Related SQLite: `sqlite3_set_last_insert_rowid`, `sqlite3_last_insert_rowid`
    @inlinable public func setLastInsertedRowID(_ rowID: RowID) {
        sqlite3_set_last_insert_rowid(rawValue, rowID.rawValue)
    }
}
