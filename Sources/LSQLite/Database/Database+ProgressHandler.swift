import MissedSwiftSQLite

extension Database {
    public typealias ProgressHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?) -> Int32

    @frozen public struct ProgressHandlerResult: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let `continue` = Self(rawValue: 0)
        public static let interrupt = Self(rawValue: 1)

        public var debugDescription: String {
            switch self {
            case .continue: return "LSQLITE_CONTINUE"
            case .interrupt: return "LSQLITE_INTERRUPT"
            default: return "ProgressHandlerResult(rawValue: \(rawValue))"
            }
        }
    }

    /**
     CAPI3REF: Query Progress Callbacks
     METHOD: sqlite3

     ^The sqlite3_progress_handler(D,N,X,P) interface causes the callback
     function X to be invoked periodically during long running calls to
     [sqlite3_exec()], [sqlite3_step()] and [sqlite3_get_table()] for
     database connection D.  An example use for this
     interface is to keep a GUI updated during a large query.

     ^The parameter P is passed through as the only parameter to the
     callback function X.  ^The parameter N is the approximate number of
     [virtual machine instructions] that are evaluated between successive
     invocations of the callback X.  ^If N is less than one then the progress
     handler is disabled.

     ^Only a single progress handler may be defined at one time per
     [database connection]; setting a new progress handler cancels the
     old one.  ^Setting parameter X to NULL disables the progress handler.
     ^The progress handler is also disabled by setting N to a value less
     than 1.

     ^If the progress callback returns non-zero, the operation is
     interrupted.  This feature can be used to implement a
     "Cancel" button on a GUI progress dialog box.

     The progress handler callback must not do anything that will modify
     the database connection that invoked the progress handler.
     Note that [sqlite3_prepare_v2()] and [sqlite3_step()] both modify their
     database connections for the meaning of "modify" in this paragraph.

    */
    @inlinable public func setProgressHandler(instructionCount: Int32, userData: UnsafeMutableRawPointer? = nil, handler: ProgressHandler? = nil) {
        sqlite3_progress_handler(rawValue, instructionCount, handler, userData)
    }
}
