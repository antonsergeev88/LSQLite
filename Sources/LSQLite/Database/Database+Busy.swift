import SQLite3

extension Database {
    public typealias BusyHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ attempt: Int32) -> Int32

    @frozen public struct BusyHandlerResult: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let `break` = Self(rawValue: 0)
        public static let `continue` = Self(rawValue: 1)

        public var debugDescription: String {
            switch self {
            case .break: return "LSQLITE_BREAK"
            case .continue: return "LSQLITE_CONTINUE"
            default: return "BusyHandlerResult(rawValue: \(rawValue))"
            }
        }
    }

    @inlinable public func setBusyHandler(userData: UnsafeMutableRawPointer? = nil, _ handler: BusyHandler? = nil) -> ResultCode {
        sqlite3_busy_handler(rawValue, handler, userData).resultCode
    }

    @inlinable public func setTimerBusyHandler(milliseconds: Int32) {
        sqlite3_busy_timeout(rawValue, milliseconds)
    }
}
