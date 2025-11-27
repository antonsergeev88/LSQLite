@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
/// Custom subtype tag associated with SQLite values.
///
/// Related SQLite: `sqlite3_value_subtype`, `sqlite3_result_subtype`
@frozen public struct Subtype: Equatable, RawRepresentable {
    public let rawValue: UInt32

    /// Creates a subtype tag from its raw numeric value.
    ///
    /// Related SQLite: `sqlite3_value_subtype`, `sqlite3_result_subtype`
    @inlinable public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
}
