import MissedSwiftSQLite

extension Database {
    /// Switch controlling whether extended result codes are reported for this connection.
    ///
    /// Related SQLite: `sqlite3_extended_result_codes`
    @frozen public struct ExtendedResultCodeStatus: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let off = Self(rawValue: 0)
        public static let on = Self(rawValue: 1)

        /// Debug label for the extended result code toggle.
        ///
        /// Related SQLite: `sqlite3_extended_result_codes`
        public var debugDescription: String {
            switch self {
            case .off: return "LSQLITE_OFF"
            case .on: return "LSQLITE_ON"
            default: return "ExtendedResultCodeStatus(rawValue: \(rawValue))"
            }
        }
    }

    /// Last result code set by an API call on this connection.
    ///
    /// Related SQLite: `sqlite3_errcode`, `sqlite3_errmsg`, `sqlite3_errmsg16`
    @inlinable public var lastErrorCode: ResultCode {
        sqlite3_errcode(rawValue).resultCode
    }

    /// Last extended result code set by an API call on this connection.
    ///
    /// Related SQLite: `sqlite3_extended_errcode`, `sqlite3_errcode`
    @inlinable public var lastExtendedErrorCode: ResultCode {
        sqlite3_extended_errcode(rawValue).resultCode
    }

    /// UTF-8 message text for the most recent API call on this connection.
    ///
    /// Related SQLite: `sqlite3_errmsg`, `sqlite3_errmsg16`, `sqlite3_errstr`
    @inlinable public var lastErrorMessage: UnsafePointer<Int8> {
        sqlite3_errmsg(rawValue)
    }

    /// Enables (`.on`) or disables (`.off`) extended result codes for this connection.
    /// - Parameter status: Toggle for extended result codes.
    /// - Returns: Result of `sqlite3_extended_result_codes`.
    ///
    /// Related SQLite: `sqlite3_extended_result_codes`, `sqlite3_extended_errcode`, `sqlite3_errcode`
    @inlinable public func setExtendedResultCodes(_ status: ExtendedResultCodeStatus) -> ResultCode {
        sqlite3_extended_result_codes(rawValue, status.rawValue).resultCode
    }
}
