import SQLite3

@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension Database {
    /// Trace callback invoked for subscribed events with event-specific payloads.
    ///
    /// Related SQLite: `sqlite3_trace_v2`
    public typealias TraceEventCallback = @convention(c) (_ traceEventCode: UInt32, _ userData: UnsafeMutableRawPointer?, _ p: UnsafeMutableRawPointer?, _ x: UnsafeMutableRawPointer?) -> Int32

    /// Return code expected from a trace callback.
    ///
    /// Related SQLite: `sqlite3_trace_v2`
    @frozen public struct TraceEventCallbackResult: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let ok = Self(rawValue: 0)

        /// Debug label for the trace callback result.
        ///
        /// Related SQLite: `sqlite3_trace_v2`
        public var debugDescription: String {
            switch self {
            case .ok: return "LSQLITE_OK"
            default: return "TraceEventCallbackResult(rawValue: \(rawValue))"
            }
        }
    }

    /// Event mask values used when registering `setTraceCallback(for:userData:callback:)`.
    ///
    /// Related SQLite: `sqlite3_trace_v2`, `SQLITE_TRACE_STMT`, `SQLITE_TRACE_PROFILE`, `SQLITE_TRACE_ROW`, `SQLITE_TRACE_CLOSE`
    @frozen public struct TraceEventCode: Equatable, OptionSet, CustomDebugStringConvertible {
        public let rawValue: UInt32

        @inlinable public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }

        /// Trace when a prepared statement starts executing (including trigger entries).
        ///
        /// Related SQLite: `SQLITE_TRACE_STMT`, `sqlite3_trace_v2`, `sqlite3_expanded_sql`
        public static let statement = Self(rawValue: UInt32(SQLITE_TRACE_STMT))
        /// Trace profiling information when a statement finishes; X points to elapsed nanoseconds.
        ///
        /// Related SQLite: `SQLITE_TRACE_PROFILE`, `sqlite3_profile`, `sqlite3_trace_v2`
        public static let profile = Self(rawValue: UInt32(SQLITE_TRACE_PROFILE))
        /// Trace each row produced by a prepared statement.
        ///
        /// Related SQLite: `SQLITE_TRACE_ROW`, `sqlite3_trace_v2`
        public static let row = Self(rawValue: UInt32(SQLITE_TRACE_ROW))
        /// Trace when the database connection closes.
        ///
        /// Related SQLite: `SQLITE_TRACE_CLOSE`, `sqlite3_trace_v2`
        public static let close = Self(rawValue: UInt32(SQLITE_TRACE_CLOSE))

        /// Debug label for the trace event code.
        ///
        /// Related SQLite: `sqlite3_trace_v2`, `SQLITE_TRACE_STMT`, `SQLITE_TRACE_PROFILE`, `SQLITE_TRACE_ROW`, `SQLITE_TRACE_CLOSE`
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

    /// Registers or clears a trace callback for the specified events on this connection.
    /// - Parameters:
    ///   - events: Bitmask of `TraceEventCode` values to observe.
    ///   - userData: Custom context passed to the callback.
    ///   - callback: Trace handler; `nil` disables tracing.
    /// - Returns: Result of `sqlite3_trace_v2`.
    ///
    /// Related SQLite: `sqlite3_trace_v2`, `SQLITE_TRACE_STMT`, `SQLITE_TRACE_PROFILE`, `SQLITE_TRACE_ROW`, `SQLITE_TRACE_CLOSE`
    @inlinable public func setTraceCallback(for events: TraceEventCode, userData: UnsafeMutableRawPointer? = nil, callback: TraceEventCallback? = nil) -> ResultCode {
        sqlite3_trace_v2(rawValue, events.rawValue, callback, userData).resultCode
    }
}
