import MissedSwiftSQLite

extension Database {
    public typealias CollationCompareHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ lhsLength: Int32, _ lhs: UnsafeRawPointer?, _ rhsLength: Int32, _ rhs: UnsafeRawPointer?) -> Int32
    public typealias CollationDestroyHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?) -> Void
    public typealias CollationNeededHandler = @convention(c) (UnsafeMutableRawPointer?, OpaquePointer?, Int32, UnsafePointer<Int8>?) -> Void

    @frozen public struct CollationFlag: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let utf8 = Self(rawValue: SQLITE_UTF8)
        public static let utf16le = Self(rawValue: SQLITE_UTF16LE)
        public static let utf16be = Self(rawValue: SQLITE_UTF16BE)
        public static let utf16 = Self(rawValue: SQLITE_UTF16)
        public static let utf16Aligned = Self(rawValue: SQLITE_UTF16_ALIGNED)

        public static let deterministic = Self(rawValue: SQLITE_DETERMINISTIC)

        public var debugDescription: String {
            switch self {
            case .utf8: return "SQLITE_UTF8"
            case .utf16le: return "SQLITE_UTF16LE"
            case .utf16be: return "SQLITE_UTF16BE"
            case .utf16: return "SQLITE_UTF16"
            case .utf16Aligned: return "SQLITE_UTF16_ALIGNED"
            default: return "FunctionFlag(rawValue: \(rawValue))"
            }
        }
    }

    @inlinable public func createCollation(name: UnsafePointer<Int8>, flag: CollationFlag, userData: UnsafeMutableRawPointer? = nil, compareHandler: CollationCompareHandler? = nil, destroyHandler: CollationDestroyHandler? = nil) -> ResultCode {
        sqlite3_create_collation_v2(rawValue, name, flag.rawValue, userData, compareHandler, destroyHandler).resultCode
    }

    @inlinable public func collationNeeded(userData: UnsafeMutableRawPointer? = nil, neededHandler: CollationNeededHandler? = nil) -> ResultCode {
        sqlite3_collation_needed(rawValue, userData, neededHandler).resultCode
    }
}
