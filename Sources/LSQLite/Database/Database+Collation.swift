import MissedSwiftSQLite

extension Database {
    /// Comparator used by SQLite to order text for a custom collation.
    ///
    /// Related SQLite: `sqlite3_create_collation_v2`, `sqlite3_create_collation`, `sqlite3_create_collation16`
    public typealias CollationCompareHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ lhsLength: Int32, _ lhs: UnsafeRawPointer?, _ rhsLength: Int32, _ rhs: UnsafeRawPointer?) -> Int32

    /// Cleanup callback invoked when a custom collation is destroyed.
    ///
    /// Related SQLite: `sqlite3_create_collation_v2`
    public typealias CollationDestroyHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?) -> Void

    /// Callback used to lazily create missing collations on demand.
    ///
    /// Related SQLite: `sqlite3_collation_needed`, `sqlite3_collation_needed16`
    public typealias CollationNeededHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ database: OpaquePointer?, _ collationFlag: Int32, _ name: UnsafePointer<Int8>?) -> Void

    /// Text encoding and behavior flags for user-defined collations.
    ///
    /// Related SQLite: `sqlite3_create_collation_v2`, `SQLITE_UTF8`, `SQLITE_UTF16LE`, `SQLITE_UTF16BE`, `SQLITE_UTF16`, `SQLITE_UTF16_ALIGNED`, `SQLITE_DETERMINISTIC`
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

        /// Debug label for the collation flag.
        ///
        /// Related SQLite: `sqlite3_create_collation_v2`, `SQLITE_UTF8`, `SQLITE_UTF16LE`, `SQLITE_UTF16BE`, `SQLITE_UTF16`, `SQLITE_UTF16_ALIGNED`, `SQLITE_DETERMINISTIC`
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

    /// Registers, replaces, or removes a collation on this connection using the provided comparator callbacks.
    /// - Parameters:
    ///   - name: Collation name to create or replace (UTF-8).
    ///   - flag: Text encoding and options for callback inputs.
    ///   - userData: User context passed to `compareHandler` and `destroyHandler`.
    ///   - compareHandler: Comparator returning negative/zero/positive for ordering; `nil` removes the collation.
    ///   - destroyHandler: Optional cleanup invoked when the collation is dropped.
    /// - Returns: Result of `sqlite3_create_collation_v2`.
    ///
    /// Related SQLite: `sqlite3_create_collation_v2`, `sqlite3_create_collation`, `sqlite3_create_collation16`, `sqlite3_close`, `sqlite3_strnicmp`
    @inlinable public func createCollation(name: UnsafePointer<Int8>, flag: CollationFlag, userData: UnsafeMutableRawPointer? = nil, compareHandler: CollationCompareHandler? = nil, destroyHandler: CollationDestroyHandler? = nil) -> ResultCode {
        sqlite3_create_collation_v2(rawValue, name, flag.rawValue, userData, compareHandler, destroyHandler).resultCode
    }

    /// Registers a callback invoked when SQLite encounters an unknown collation name so it can be created on demand.
    /// - Parameters:
    ///   - userData: Custom context forwarded to the callback.
    ///   - neededHandler: Handler describing the desired collation; pass `nil` to clear.
    /// - Returns: Result of `sqlite3_collation_needed`.
    ///
    /// Related SQLite: `sqlite3_collation_needed`, `sqlite3_collation_needed16`, `sqlite3_create_collation_v2`
    @inlinable public func collationNeeded(userData: UnsafeMutableRawPointer? = nil, neededHandler: CollationNeededHandler? = nil) -> ResultCode {
        sqlite3_collation_needed(rawValue, userData, neededHandler).resultCode
    }
}
