import MissedSwiftSQLite

/// Strongly typed wrapper for SQLite `rowid` values.
///
/// Related SQLite: `rowid`, `INTEGER PRIMARY KEY`
@frozen public struct RowID: Equatable, RawRepresentable {
    public let rawValue: sqlite3_int64

    /// Creates a `RowID` from its raw 64-bit identifier.
    ///
    /// Related SQLite: `rowid`
    @inlinable public init(rawValue: sqlite3_int64) {
        self.rawValue = rawValue
    }
}
