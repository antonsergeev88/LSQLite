/// Strongly typed wrapper for SQLite `rowid` values.
///
/// Related SQLite: `rowid`, `INTEGER PRIMARY KEY`
@frozen public struct RowID: Hashable, RawRepresentable, CustomStringConvertible {
    public let rawValue: Int64

    @inlinable public init(rawValue: Int64) {
        self.rawValue = rawValue
    }

    public var description: String {
        rawValue.description
    }
}
