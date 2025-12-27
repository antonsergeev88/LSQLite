import MissedSwiftSQLite

extension Database {
    /// Callback invoked when SQLite reports a busy contention; return a retry decision.
    ///
    /// Related SQLite: `sqlite3_busy_handler`, `sqlite3_busy_timeout`
    public typealias BusyHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ attempt: Int32) -> Int32

    /// Result codes a busy handler can return to retry or abort.
    ///
    /// Related SQLite: `sqlite3_busy_handler`, `sqlite3_busy_timeout`, `SQLITE_BUSY`
    @frozen public struct BusyHandlerResult: Hashable, RawRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let `break` = Self(rawValue: 0)
        public static let `continue` = Self(rawValue: 1)

        public var description: String {
            switch self {
            case .break: "break"
            case .continue: "continue"
            default: "unknown"
            }
        }

        public var debugDescription: String {
            "\(description) (\(rawValue.description))"
        }
    }

    /// Registers a busy handler invoked when this connection hits `SQLITE_BUSY`; return `.continue` to retry or `.break` to stop.
    /// - Parameters:
    ///   - userData: Custom pointer passed into the handler.
    ///   - handler: Busy callback; pass `nil` to clear.
    /// - Returns: Result of `sqlite3_busy_handler`.
    ///
    /// Related SQLite: `sqlite3_busy_handler`, `SQLITE_BUSY`, `sqlite3_busy_timeout`, `PRAGMA busy_timeout`
    @inlinable public func setBusyHandler(userData: UnsafeMutableRawPointer? = nil, _ handler: BusyHandler? = nil) -> ResultCode {
        sqlite3_busy_handler(rawValue, handler, userData).resultCode
    }

    /// Sets a default busy handler that sleeps and retries for the given duration, or clears handlers when `milliseconds <= 0`.
    /// - Parameter milliseconds: Total time to keep retrying before returning `SQLITE_BUSY`.
    ///
    /// Related SQLite: `sqlite3_busy_timeout`, `sqlite3_busy_handler`, `PRAGMA busy_timeout`
    @inlinable public func setTimerBusyHandler(milliseconds: Int32) {
        sqlite3_busy_timeout(rawValue, milliseconds)
    }
}
