import MissedSwiftSQLite

/**
 CAPI3REF: Fundamental Datatypes
 KEYWORDS: SQLITE_TEXT

 ^(Every value in SQLite has one of five fundamental datatypes:

 <ul>
 <li> 64-bit signed integer
 <li> 64-bit IEEE floating point number
 <li> string
 <li> BLOB
 <li> NULL
 </ul>)^

 These constants are codes for each of those types.

 Note that the SQLITE_TEXT constant was also used in SQLite version 2
 for a completely different meaning.  Software that links against both
 SQLite version 2 and SQLite version 3 should use SQLITE3_TEXT, not
 SQLITE_TEXT.
*/
@frozen public struct Datatype: Equatable, CustomDebugStringConvertible {
    public let rawValue: Int32

    @inlinable public init(rawValue: Int32) {
        self.rawValue = rawValue
    }

    public static let integer = Self(rawValue: SQLITE_INTEGER)
    public static let float = Self(rawValue: SQLITE_FLOAT)
    public static let blob = Self(rawValue: SQLITE_BLOB)
    public static let null = Self(rawValue: SQLITE_NULL)
    public static let text = Self(rawValue: SQLITE_TEXT)

    public var debugDescription: String {
        switch self {
        case .integer: return "SQLITE_INTEGER"
        case .float: return "SQLITE_FLOAT"
        case .blob: return "SQLITE_BLOB"
        case .null: return "SQLITE_NULL"
        case .text: return "SQLITE_TEXT"
        default: return "Datatype(rawValue: \(rawValue))"
        }
    }
}
