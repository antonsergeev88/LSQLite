import SQLite3

extension Database {
    /// Callback invoked periodically during virtual machine execution; return a code indicating whether to continue.
    ///
    /// Related SQLite: `sqlite3_progress_handler`
    public typealias ProgressHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?) -> Int32

    /// Return codes from a progress handler to keep running or interrupt.
    ///
    /// Related SQLite: `sqlite3_progress_handler`, `SQLITE_INTERRUPT`
    @frozen public struct ProgressHandlerResult: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let `continue` = Self(rawValue: 0)
        public static let interrupt = Self(rawValue: 1)

        /// Debug label for the progress handler result.
        ///
        /// Related SQLite: `sqlite3_progress_handler`, `SQLITE_INTERRUPT`
        public var debugDescription: String {
            switch self {
            case .continue: return "LSQLITE_CONTINUE"
            case .interrupt: return "LSQLITE_INTERRUPT"
            default: return "ProgressHandlerResult(rawValue: \(rawValue))"
            }
        }
    }

    /// Registers a progress handler invoked every `instructionCount` virtual machine steps; return `.interrupt` to halt the operation.
    /// - Parameters:
    ///   - instructionCount: Approximate number of VDBE instructions between callbacks; `<= 0` disables the handler.
    ///   - userData: Custom context passed to the handler.
    ///   - handler: Progress callback; `nil` to clear.
    ///
    /// Related SQLite: `sqlite3_progress_handler`, `sqlite3_exec`, `sqlite3_step`
    @inlinable public func setProgressHandler(instructionCount: Int32, userData: UnsafeMutableRawPointer? = nil, handler: ProgressHandler? = nil) {
        sqlite3_progress_handler(rawValue, instructionCount, handler, userData)
    }
}
