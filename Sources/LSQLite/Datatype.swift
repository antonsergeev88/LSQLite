import MissedSwiftSQLite

/// Swift wrapper around SQLite's fundamental datatype codes used in value and column inspection.
///
/// Related SQLite: `SQLITE_INTEGER`, `SQLITE_FLOAT`, `SQLITE_BLOB`, `SQLITE_NULL`, `SQLITE_TEXT`, `SQLITE3_TEXT`
@frozen public struct Datatype: Hashable, RawRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
    public let rawValue: Int32

    @inlinable public init(rawValue: Int32) {
        self.rawValue = rawValue
    }

    /// SQLite INTEGER type.
    ///
    /// Represents signed integer values as defined by SQLite's dynamic type system.
    ///
    /// Related SQLite: `SQLITE_INTEGER`
    public static let integer = Self(rawValue: SQLITE_INTEGER)

    /// SQLite FLOAT type.
    ///
    /// Represents floating-point numeric values (stored as IEEE 64‑bit floats).
    ///
    /// Related SQLite: `SQLITE_FLOAT`
    public static let float = Self(rawValue: SQLITE_FLOAT)

    /// SQLite BLOB type.
    ///
    /// Represents raw binary data stored exactly as provided, without encoding.
    ///
    /// Related SQLite: `SQLITE_BLOB`
    public static let blob = Self(rawValue: SQLITE_BLOB)

    /// SQLite NULL type.
    ///
    /// Represents the absence of a value.
    ///
    /// Related SQLite: `SQLITE_NULL`
    public static let null = Self(rawValue: SQLITE_NULL)

    /// SQLite TEXT type.
    ///
    /// Represents text data stored using the database text encoding (UTF‑8, UTF‑16LE, or UTF‑16BE).
    ///
    /// Related SQLite: `SQLITE3_TEXT`
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
