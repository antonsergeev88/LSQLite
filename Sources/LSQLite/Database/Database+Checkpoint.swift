import SQLite3

extension Database {
    /// WAL checkpoint modes used by `walCheckpoint(_:mode:frameCount:totalFrameCount:)` and auto-checkpointing.
    ///
    /// Related SQLite: `SQLITE_CHECKPOINT_PASSIVE`, `SQLITE_CHECKPOINT_FULL`, `SQLITE_CHECKPOINT_RESTART`, `SQLITE_CHECKPOINT_TRUNCATE`
    @frozen public struct CheckpointMode: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let passive = Self(rawValue: SQLITE_CHECKPOINT_PASSIVE)
        public static let full = Self(rawValue: SQLITE_CHECKPOINT_FULL)
        public static let restart = Self(rawValue: SQLITE_CHECKPOINT_RESTART)
        public static let truncate = Self(rawValue: SQLITE_CHECKPOINT_TRUNCATE)

        /// Debug label for the checkpoint mode.
        ///
        /// Related SQLite: `SQLITE_CHECKPOINT_PASSIVE`, `SQLITE_CHECKPOINT_FULL`, `SQLITE_CHECKPOINT_RESTART`, `SQLITE_CHECKPOINT_TRUNCATE`
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

    /// Enables or disables automatic WAL checkpoints when the log reaches the given frame count.
    /// - Parameter pageInWALFileCount: Frame threshold; pass `<= 0` to turn off auto-checkpointing.
    /// - Returns: Result of `sqlite3_wal_autocheckpoint`.
    ///
    /// Related SQLite: `sqlite3_wal_autocheckpoint`, `sqlite3_wal_hook`, `PRAGMA wal_autocheckpoint`, `SQLITE_CHECKPOINT_PASSIVE`
    @inlinable public func autoWALCheckpoint(pageInWALFileCount: Int32) -> ResultCode {
        sqlite3_wal_autocheckpoint(rawValue, pageInWALFileCount).resultCode
    }

    /// Runs a WAL checkpoint on the named database using the requested mode.
    /// - Parameters:
    ///   - databaseName: Target database name (e.g. `"main"`); empty applies to all.
    ///   - mode: Checkpoint mode to use.
    ///   - frameCount: Receives total frames in the WAL, or `-1` on failure.
    ///   - totalFrameCount: Receives total checkpointed frames, or `-1` on failure.
    /// - Returns: Result of `sqlite3_wal_checkpoint_v2`.
    ///
    /// Related SQLite: `sqlite3_wal_checkpoint_v2`, `PRAGMA wal_checkpoint`, `SQLITE_CHECKPOINT_*`
    @inlinable public func walCheckpoint(_ databaseName: String, mode: CheckpointMode, frameCount: UnsafeMutablePointer<Int32>?, totalFrameCount: UnsafeMutablePointer<Int32>?) -> ResultCode {
        sqlite3_wal_checkpoint_v2(rawValue, databaseName, mode.rawValue, frameCount, totalFrameCount).resultCode
    }
}
