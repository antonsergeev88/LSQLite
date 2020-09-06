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

    @frozen public struct TraceEventCode: Equatable, OptionSet, CustomDebugStringConvertible {
        public let rawValue: UInt32

        @inlinable public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }

        public static let statement = Self(rawValue: UInt32(SQLITE_TRACE_STMT))
        public static let profile = Self(rawValue: UInt32(SQLITE_TRACE_PROFILE))
        public static let row = Self(rawValue: UInt32(SQLITE_TRACE_ROW))
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

    @inlinable public func setTraceCallback(for events: TraceEventCode, userData: UnsafeMutableRawPointer? = nil, callback: TraceEventCallback? = nil) -> ResultCode {
        sqlite3_trace_v2(rawValue, events.rawValue, callback, userData).resultCode
    }
}
