import SQLite3

extension Database {
    @frozen public struct ExtendedResultCodeStatus: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let off = Self(rawValue: 0)
        public static let on = Self(rawValue: 1)

        public var debugDescription: String {
            switch self {
            case .off: return "LSQLITE_OFF"
            case .on: return "LSQLITE_ON"
            default: return "ExtendedResultCodeStatus(rawValue: \(rawValue))"
            }
        }
    }

    @inlinable public var lastErrorCode: ResultCode {
        sqlite3_errcode(rawValue).resultCode
    }

    @inlinable public var lastExtendedErrorCode: ResultCode {
        sqlite3_extended_errcode(rawValue).resultCode
    }

    @inlinable public var lastErrorMessage: UnsafePointer<Int8> {
        sqlite3_errmsg(rawValue)
    }

    @inlinable public func setExtendedResultCodes(_ status: ExtendedResultCodeStatus) -> ResultCode {
        sqlite3_extended_result_codes(rawValue, status.rawValue).resultCode
    }
}
