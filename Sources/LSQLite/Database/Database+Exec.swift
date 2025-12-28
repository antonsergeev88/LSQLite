import MissedSwiftSQLite

extension Database {
    /// Row callback invoked by `exec(_:)` when SQL produces result rows.
    ///
    /// Related SQLite: `sqlite3_exec`
    public typealias ExecCallback = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ count: Int32, _ values: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>?, _ columns: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>?) -> Int32

    /// Return codes for `ExecCallback` indicating whether to continue or abort execution.
    ///
    /// Related SQLite: `sqlite3_exec`
    @frozen public struct ExecCallbackResult: Hashable, RawRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        /// Continue executing statements and callbacks.
        ///
        /// Related SQLite: `sqlite3_exec`
        public static let `continue` = Self(rawValue: 0)
        /// Abort execution and return an error to the caller.
        ///
        /// Related SQLite: `sqlite3_exec`
        public static let abort = Self(rawValue: 1)

        public var description: String {
            switch self {
            case .continue: "continue"
            case .abort: "abort"
            default: "unknown"
            }
        }

        public var debugDescription: String {
            "\(description) (\(rawValue.description))"
        }
    }

    /// Executes one or more semicolon-separated SQL statements with an optional row callback.
    /// - Parameters:
    ///   - sql: UTF-8 SQL text to run.
    ///   - errorMessage: Optional storage for an allocated error message; caller should free on error.
    ///   - userData: Custom context passed into each callback invocation.
    ///   - callback: Row callback returning `ExecCallbackResult`; `nil` to ignore rows.
    /// - Returns: Result of `sqlite3_exec`.
    ///
    /// Related SQLite: `sqlite3_exec`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_finalize`
    @inlinable public func exec(_ sql: String, errorMessage: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>? = nil, userData: UnsafeMutableRawPointer? = nil, callback: ExecCallback? = nil) -> ResultCode {
        sqlite3_exec(rawValue, sql, callback, userData, errorMessage).resultCode
    }
}
