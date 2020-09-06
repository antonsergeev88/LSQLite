import MissedSwiftSQLite

extension Database {
    @frozen public struct CheckpointMode: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let passive = Self(rawValue: SQLITE_CHECKPOINT_PASSIVE)
        public static let full = Self(rawValue: SQLITE_CHECKPOINT_FULL)
        public static let restart = Self(rawValue: SQLITE_CHECKPOINT_RESTART)
        public static let truncate = Self(rawValue: SQLITE_CHECKPOINT_TRUNCATE)

        public var debugDescription: String {
            switch self {
            case .passive: return "SQLITE_CHECKPOINT_PASSIVE"
            case .full: return "SQLITE_CHECKPOINT_FULL"
            case .restart: return "SQLITE_CHECKPOINT_RESTART"
            case .truncate: return "SQLITE_CHECKPOINT_TRUNCATE"
            default: return "CheckpointMode(rawValue: \(rawValue))"
            }
        }
    }

    @inlinable public func autoWALCheckpoint(pageInWALFileCount: Int32) -> ResultCode {
        sqlite3_wal_autocheckpoint(rawValue, pageInWALFileCount).resultCode
    }

    @inlinable public func walCheckpoint(_ databaseName: UnsafePointer<Int8>, mode: CheckpointMode, frameCount: UnsafeMutablePointer<Int32>?, totalFrameCount: UnsafeMutablePointer<Int32>?) -> ResultCode {
        sqlite3_wal_checkpoint_v2(rawValue, databaseName, mode.rawValue, frameCount, totalFrameCount).resultCode
    }
}
