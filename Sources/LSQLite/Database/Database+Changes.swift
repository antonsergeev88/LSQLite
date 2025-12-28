import MissedSwiftSQLite

extension Database {
    /// Number of rows changed by the most recent INSERT, UPDATE, or DELETE on this connection.
    ///
    /// Only changes made directly by the statement are counted; changes from triggers, foreign key
    /// actions, or REPLACE conflict handling are not. Changes applied through INSTEAD OF triggers
    /// on views are not counted; the value is always 0 immediately after modifying a view.
    ///
    /// The value is unchanged by statements other than INSERT/UPDATE/DELETE; CREATE TABLE AS SELECT
    /// does not count as an INSERT for this purpose.
    ///
    /// Inside trigger programs, the value is saved on entry and restored on exit. Each statement
    /// within a trigger updates the value, but it does not include changes made by sub-triggers.
    ///
    /// If another thread modifies the same connection while this value is read, the result is
    /// unpredictable. If the number of changes exceeds the range of `Int32`, the value is undefined.
    ///
    /// Related SQLite: `sqlite3_changes`, `changes() SQL function`, `PRAGMA count_changes`
    @inlinable public var changes: Int32 {
        sqlite3_changes(rawValue)
    }

    /// Total number of rows inserted, updated, or deleted since this connection was opened.
    ///
    /// Changes made by trigger programs and foreign key actions are included, but changes from
    /// REPLACE conflict handling are not. Changes to views intercepted by INSTEAD OF triggers
    /// are not counted.
    ///
    /// The count only reflects work performed through this connection. To detect changes made
    /// by other connections, use the data-version mechanisms instead.
    ///
    /// If another thread modifies the same connection while this value is read, the result is
    /// unpredictable. If the total exceeds the range of `Int32`, the value is undefined.
    ///
    /// Related SQLite: `sqlite3_total_changes`, `sqlite3_changes`, `PRAGMA data_version`, `SQLITE_FCNTL_DATA_VERSION`
    @inlinable public var totalChanges: Int32 {
        sqlite3_total_changes(rawValue)
    }
}
