import MissedSwiftSQLite

@frozen public struct RowID: Equatable, RawRepresentable {
    public let rawValue: sqlite3_int64

    @inlinable public init(rawValue: sqlite3_int64) {
        self.rawValue = rawValue
    }
}
