import MissedSwiftSQLite

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

    /**
     CAPI3REF: Register A Callback To Handle SQLITE_BUSY Errors
     KEYWORDS: {busy-handler callback} {busy handler}
     METHOD: sqlite3

     ^The sqlite3_busy_handler(D,X,P) routine sets a callback function X
     that might be invoked with argument P whenever
     an attempt is made to access a database table associated with
     [database connection] D when another thread
     or process has the table locked.
     The sqlite3_busy_handler() interface is used to implement
     [sqlite3_busy_timeout()] and [PRAGMA busy_timeout].

     ^If the busy callback is NULL, then [SQLITE_BUSY]
     is returned immediately upon encountering the lock.  ^If the busy callback
     is not NULL, then the callback might be invoked with two arguments.

     ^The first argument to the busy handler is a copy of the void* pointer which
     is the third argument to sqlite3_busy_handler().  ^The second argument to
     the busy handler callback is the number of times that the busy handler has
     been invoked previously for the same locking event.  ^If the
     busy callback returns 0, then no additional attempts are made to
     access the database and [SQLITE_BUSY] is returned
     to the application.
     ^If the callback returns non-zero, then another attempt
     is made to access the database and the cycle repeats.

     The presence of a busy handler does not guarantee that it will be invoked
     when there is lock contention. ^If SQLite determines that invoking the busy
     handler could result in a deadlock, it will go ahead and return [SQLITE_BUSY]
     to the application instead of invoking the
     busy handler.
     Consider a scenario where one process is holding a read lock that
     it is trying to promote to a reserved lock and
     a second process is holding a reserved lock that it is trying
     to promote to an exclusive lock.  The first process cannot proceed
     because it is blocked by the second and the second process cannot
     proceed because it is blocked by the first.  If both processes
     invoke the busy handlers, neither will make any progress.  Therefore,
     SQLite returns [SQLITE_BUSY] for the first process, hoping that this
     will induce the first process to release its read lock and allow
     the second process to proceed.

     ^The default busy callback is NULL.

     ^(There can only be a single busy handler defined for each
     [database connection].  Setting a new busy handler clears any
     previously set handler.)^  ^Note that calling [sqlite3_busy_timeout()]
     or evaluating [PRAGMA busy_timeout=N] will change the
     busy handler and thus clear any previously set busy handler.

     The busy callback should not take any actions which modify the
     database connection that invoked the busy handler.  In other words,
     the busy handler is not reentrant.  Any such actions
     result in undefined behavior.

     A busy handler must not close the database connection
     or [prepared statement] that invoked the busy handler.
     */
    @inlinable public func setBusyHandler(userData: UnsafeMutableRawPointer? = nil, _ handler: BusyHandler? = nil) -> ResultCode {
        sqlite3_busy_handler(rawValue, handler, userData).resultCode
    }

    /**
     CAPI3REF: Set A Busy Timeout
     METHOD: sqlite3

     ^This routine sets a [sqlite3_busy_handler | busy handler] that sleeps
     for a specified amount of time when a table is locked.  ^The handler
     will sleep multiple times until at least "ms" milliseconds of sleeping
     have accumulated.  ^After at least "ms" milliseconds of sleeping,
     the handler returns 0 which causes [sqlite3_step()] to return
     [SQLITE_BUSY].

     ^Calling this routine with an argument less than or equal to zero
     turns off all busy handlers.

     ^(There can only be a single busy handler for a particular
     [database connection] at any given moment.  If another busy handler
     was defined  (using [sqlite3_busy_handler()]) prior to calling
     this routine, that other busy handler is cleared.)^

     See also:  [PRAGMA busy_timeout]
     */
    @inlinable public func setTimerBusyHandler(milliseconds: Int32) {
        sqlite3_busy_timeout(rawValue, milliseconds)
    }
}
