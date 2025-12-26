import SQLite3

/// Swift wrapper around SQLite's fundamental datatype codes used in value and column inspection.
///
/// Related SQLite: `SQLITE_INTEGER`, `SQLITE_FLOAT`, `SQLITE_BLOB`, `SQLITE_NULL`, `SQLITE_TEXT`, `SQLITE3_TEXT`
@frozen public struct Datatype: Hashable, RawRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
    public let rawValue: Int32

    @inlinable public init(rawValue: Int32) {
        self.rawValue = rawValue
    }

    public static let integer = Self(rawValue: SQLITE_INTEGER)
    public static let float = Self(rawValue: SQLITE_FLOAT)
    public static let blob = Self(rawValue: SQLITE_BLOB)
    public static let null = Self(rawValue: SQLITE_NULL)
    public static let text = Self(rawValue: SQLITE_TEXT)

    public var description: String {
        switch self {
        case .integer: "integer"
        case .float: "float"
        case .blob: "blob"
        case .null: "null"
        case .text: "text"
        default: rawValue.description
        }
    }

    public var debugDescription: String {
        switch self {
        case .integer: "SQLITE_INTEGER"
        case .float: "SQLITE_FLOAT"
        case .blob: "SQLITE_BLOB"
        case .null: "SQLITE_NULL"
        case .text: "SQLITE_TEXT"
        default: rawValue.description
        }
    }
}
