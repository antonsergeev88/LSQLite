import MissedSwiftSQLite

extension Connection {
    /// Rowid of the most recent successful INSERT on this connection (rowid tables only).
    ///
    /// Rowid is the implicit 64-bit integer key for rowid tables and can be accessed via the
    /// `rowid`, `oid`, or `_rowid_` column names when they are not used by explicit columns.
    /// A column declared as INTEGER PRIMARY KEY is another alias for rowid.
    ///
    /// The value is updated by successful inserts into rowid tables or virtual tables, and is 0
    /// if no such insert has occurred. Inserts into WITHOUT ROWID tables do not affect it.
    /// Inserts that fail due to constraint violations do not change it, except that REPLACE
    /// conflict handling completes successfully and therefore updates the value.
    ///
    /// If an insert occurs within a trigger, the value is the rowid of the inserted row while
    /// the trigger runs and then reverts to the previous value when the trigger completes.
    /// The value can also be set explicitly with `setLastInsertedRowID(_:)`.
    ///
    /// If another thread inserts on the same connection while this value is read, the result is
    /// unpredictable.
    /// - Returns: The most recent insert rowid, or 0 if none has occurred.
    ///
    /// Related SQLite: `sqlite3_last_insert_rowid`, `last_insert_rowid()`
    @inlinable public func lastInsertedRowID() -> RowID {
        RowID(rawValue: sqlite3_last_insert_rowid(rawValue))
    }

    /// Overrides the last-inserted rowid value reported for this connection.
    ///
    /// This sets the value returned by `lastInsertedRowID()` without inserting a row.
    /// - Parameter rowID: New rowid value to report.
    /// - Returns: Nothing.
    ///
    /// Related SQLite: `sqlite3_set_last_insert_rowid`, `sqlite3_last_insert_rowid`
    @inlinable public func setLastInsertedRowID(_ rowID: RowID) {
        sqlite3_set_last_insert_rowid(rawValue, rowID.rawValue)
    }
}
