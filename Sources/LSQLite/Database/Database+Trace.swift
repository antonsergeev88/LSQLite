import MissedSwiftSQLite

@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension Database {
    public typealias TraceEventCallback = @convention(c) (_ traceEventCode: UInt32, _ userData: UnsafeMutableRawPointer?, _ p: UnsafeMutableRawPointer?, _ x: UnsafeMutableRawPointer?) -> Int32

    @frozen public struct TraceEventCallbackResult: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let ok = Self(rawValue: 0)

        public var debugDescription: String {
            switch self {
            case .ok: return "LSQLITE_OK"
            default: return "TraceEventCallbackResult(rawValue: \(rawValue))"
            }
        }
    }

    /**
     CAPI3REF: SQL Trace Event Codes
     KEYWORDS: SQLITE_TRACE

     These constants identify classes of events that can be monitored
     using the [sqlite3_trace_v2()] tracing logic.  The M argument
     to [sqlite3_trace_v2(D,M,X,P)] is an OR-ed combination of one or more of
     the following constants.  ^The first argument to the trace callback
     is one of the following constants.

     New tracing constants may be added in future releases.

     ^A trace callback has four arguments: xCallback(T,C,P,X).
     ^The T argument is one of the integer type codes above.
     ^The C argument is a copy of the context pointer passed in as the
     fourth argument to [sqlite3_trace_v2()].
     The P and X arguments are pointers whose meanings depend on T.
     */
    @frozen public struct TraceEventCode: Equatable, OptionSet, CustomDebugStringConvertible {
        public let rawValue: UInt32

        @inlinable public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }

        /**
         An SQLITE_TRACE_STMT callback is invoked when a prepared statement
         first begins running and possibly at other times during the
         execution of the prepared statement, such as at the start of each
         trigger subprogram. ^The P argument is a pointer to the
         [prepared statement]. ^The X argument is a pointer to a string which
         is the unexpanded SQL text of the prepared statement or an SQL comment
         that indicates the invocation of a trigger.  ^The callback can compute
         the same text that would have been returned by the legacy [sqlite3_trace()]
         interface by using the X argument when X begins with "--" and invoking
         [sqlite3_expanded_sql(P)] otherwise.
         */
        public static let statement = Self(rawValue: UInt32(SQLITE_TRACE_STMT))
        /**
         An SQLITE_TRACE_PROFILE callback provides approximately the same
         information as is provided by the [sqlite3_profile()] callback.
         ^The P argument is a pointer to the [prepared statement] and the
         X argument points to a 64-bit integer which is the estimated of
         the number of nanosecond that the prepared statement took to run.
         ^The SQLITE_TRACE_PROFILE callback is invoked when the statement finishes.
         */
        public static let profile = Self(rawValue: UInt32(SQLITE_TRACE_PROFILE))
        /**
         An SQLITE_TRACE_ROW callback is invoked whenever a prepared
         statement generates a single row of result.
         ^The P argument is a pointer to the [prepared statement] and the
         X argument is unused.
         */
        public static let row = Self(rawValue: UInt32(SQLITE_TRACE_ROW))
        /**
         An SQLITE_TRACE_CLOSE callback is invoked when a database
         connection closes.
         ^The P argument is a pointer to the [database connection] object
         and the X argument is unused.
         */
        public static let close = Self(rawValue: UInt32(SQLITE_TRACE_CLOSE))

        public var debugDescription: String {
            switch self {
            case .statement: return "SQLITE_TRACE_STMT"
            case .profile: return "SQLITE_TRACE_PROFILE"
            case .row: return "SQLITE_TRACE_ROW"
            case .close: return "SQLITE_TRACE_CLOSE"
            default: return "TraceEventCode(rawValue: \(rawValue))"
            }
        }
    }

    /**
     CAPI3REF: SQL Trace Hook
     METHOD: sqlite3

     ^The sqlite3_trace_v2(D,M,X,P) interface registers a trace callback
     function X against [database connection] D, using property mask M
     and context pointer P.  ^If the X callback is
     NULL or if the M mask is zero, then tracing is disabled.  The
     M argument should be the bitwise OR-ed combination of
     zero or more [SQLITE_TRACE] constants.

     ^Each call to either sqlite3_trace() or sqlite3_trace_v2() overrides
     (cancels) any prior calls to sqlite3_trace() or sqlite3_trace_v2().

     ^The X callback is invoked whenever any of the events identified by
     mask M occur.  ^The integer return value from the callback is currently
     ignored, though this may change in future releases.  Callback
     implementations should return zero to ensure future compatibility.

     ^A trace callback is invoked with four arguments: callback(T,C,P,X).
     ^The T argument is one of the [SQLITE_TRACE]
     constants to indicate why the callback was invoked.
     ^The C argument is a copy of the context pointer.
     The P and X arguments are pointers whose meanings depend on T.

     The sqlite3_trace_v2() interface is intended to replace the legacy
     interfaces [sqlite3_trace()] and [sqlite3_profile()], both of which
     are deprecated.
     */
    @inlinable public func setTraceCallback(for events: TraceEventCode, userData: UnsafeMutableRawPointer? = nil, callback: TraceEventCallback? = nil) -> ResultCode {
        sqlite3_trace_v2(rawValue, events.rawValue, callback, userData).resultCode
    }
}
