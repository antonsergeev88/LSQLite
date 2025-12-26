/// Custom subtype tag associated with SQLite values.
///
/// Related SQLite: `sqlite3_value_subtype`, `sqlite3_result_subtype`
@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
@frozen public struct Subtype: Hashable, RawRepresentable, CustomStringConvertible {
    public let rawValue: UInt32

    @inlinable public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public var description: String {
        rawValue.description
    }
}
