import MissedSwiftSQLite

extension Database {
    /// Row callback invoked by `exec(_:)` when SQL produces result rows.
    ///
    /// The arrays and strings are only valid for the duration of the callback.
    /// - Parameters:
    ///   - userData: Context pointer supplied to `exec`.
    ///   - count: Number of columns in the row.
    ///   - values: Array of UTF-8 column values; entries are NULL for SQL NULL.
    ///   - columns: Array of UTF-8 column names.
    /// - Returns: Return 0 to continue execution or non-zero to abort.
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
    ///
    /// If `callback` is `nil`, result rows are ignored. If the callback returns a non-zero value,
    /// execution stops immediately and the result is `.abort`.
    ///
    /// If `errorMessage` is non-nil and an error occurs, it is set to a newly allocated UTF-8
    /// error string; the caller must free it using the SQLite allocator's free routine.
    /// If no error occurs, the pointer is set to `nil`.
    ///
    /// If `sql` is empty, only whitespace, or only comments, no statements are evaluated and the
    /// database is unchanged.
    ///
    /// The database must remain open while execution is in progress, and the `sql` buffer must
    /// not be modified. The callback must not access the `values` or `columns` arrays after it returns.
    /// - Parameters:
    ///   - sql: UTF-8 SQL text to run.
    ///   - errorMessage: Storage for an allocated error message when an error occurs.
    ///   - userData: Custom context passed into each callback invocation.
    ///   - callback: Row callback returning `ExecCallbackResult`; `nil` to ignore rows.
    /// - Returns: Result code from the execution attempt.
    ///
    /// Related SQLite: `sqlite3_exec`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_finalize`
    @inlinable public func exec(_ sql: String, errorMessage: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>? = nil, userData: UnsafeMutableRawPointer? = nil, callback: ExecCallback? = nil) -> ResultCode {
        sqlite3_exec(rawValue, sql, callback, userData, errorMessage).resultCode
    }
}
