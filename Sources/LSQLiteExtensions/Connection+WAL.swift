import LSQLite

extension Connection {
    /// Counts reported by a checkpoint operation.
    ///
    /// Related SQLite: `sqlite3_wal_checkpoint_v2`
    @frozen public struct WALCheckpointInfo: Hashable {
        /// Total frames in the log at the time of the checkpoint.
        public let frameCount: Int32
        /// Total frames checkpointed during the operation.
        public let checkpointedFrameCount: Int32

        @inlinable public init(frameCount: Int32, checkpointedFrameCount: Int32) {
            self.frameCount = frameCount
            self.checkpointedFrameCount = checkpointedFrameCount
        }
    }

    /// Reads the configured automatic checkpoint frame threshold.
    /// - Returns: A result code and the current threshold when available.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not an integer.
    ///
    /// Related SQLite: `PRAGMA wal_autocheckpoint`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_int`, `sqlite3_column_type`, `sqlite3_finalize`
    public func autoWALCheckpoint() -> (ResultCode, Int32?) {
        walPragmaInt32("PRAGMA wal_autocheckpoint")
    }

    /// Runs a checkpoint and returns the frame counts.
    /// - Parameters:
    ///   - databaseName: Optional database name qualifier.
    ///   - mode: Checkpoint mode to use.
    /// - Returns: A result code and the frame counts.
    ///
    /// Related SQLite: `sqlite3_wal_checkpoint_v2`, `SQLITE_CHECKPOINT_*`
    public func walCheckpoint(_ databaseName: String? = nil, mode: CheckpointMode = .passive) -> (ResultCode, WALCheckpointInfo) {
        let target = databaseName ?? "main"
        var frameCount: Int32 = -1
        var checkpointedFrameCount: Int32 = -1
        let result = walCheckpoint(target, mode: mode, frameCount: &frameCount, totalFrameCount: &checkpointedFrameCount)
        return (result, WALCheckpointInfo(frameCount: frameCount, checkpointedFrameCount: checkpointedFrameCount))
    }
}

private extension Connection {
    func walPragmaInt32(_ sql: String) -> (ResultCode, Int32?) {
        var statement: Statement?
        let prepareResult = Statement.prepare(&statement, sql: sql, for: self)
        guard let prepared = statement else {
            return (prepareResult, nil)
        }
        defer { _ = prepared.finalize() }
        guard prepareResult == .ok else {
            return (prepareResult, nil)
        }
        let firstStep = prepared.step()
        switch firstStep {
        case .row:
            guard prepared.columnType(at: 0) == .integer else {
                return (.misuse, nil)
            }
            let value = prepared.columnInt(at: 0)
            let secondStep = prepared.step()
            switch secondStep {
            case .done:
                return (.done, value)
            case .row:
                return (.misuse, nil)
            default:
                return (secondStep, nil)
            }
        case .done:
            return (.misuse, nil)
        default:
            return (firstStep, nil)
        }
    }
}
