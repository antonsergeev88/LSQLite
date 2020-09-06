import MissedSwiftSQLite

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
