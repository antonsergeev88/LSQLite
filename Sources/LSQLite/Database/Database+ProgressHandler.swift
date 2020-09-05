import SQLite3

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

    @inlinable public func setProgressHandler(instructionCount: Int32, userData: UnsafeMutableRawPointer? = nil, handler: ProgressHandler? = nil) {
        sqlite3_progress_handler(rawValue, instructionCount, handler, userData)
    }
}
