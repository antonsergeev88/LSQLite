import MissedSwiftSQLite

extension Database {
    public typealias ExecCallback = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ count: Int32, _ values: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>?, _ columns: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>?) -> Int32

    @frozen public struct ExecCallbackResult: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let `continue` = Self(rawValue: 0)
        public static let abort = Self(rawValue: 1)

        public var debugDescription: String {
            switch self {
            case .continue: return "LSQLITE_CONTINUE"
            case .abort: return "LSQLITE_ABORT"
            default: return "ExecCallbackResult(rawValue: \(rawValue))"
            }
        }
    }

    @inlinable public func exec(_ sql: UnsafePointer<Int8>, errorMessage: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>? = nil, userData: UnsafeMutableRawPointer? = nil, callback: ExecCallback? = nil) -> ResultCode {
        sqlite3_exec(rawValue, sql, callback, userData, errorMessage).resultCode
    }
}
