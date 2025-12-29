import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Connection+Checkpoint")
final class ConnectionCheckpointModeRawValueTests {
    private let connection: Connection

    init() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        self.connection = connection
    }

    deinit {
        _ = connection.close()
    }

    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(9)
        let mode = Connection.CheckpointMode(rawValue: rawValue)
        #expect(mode.rawValue == rawValue)
    }

    @Test("CheckpointMode constants match SQLite")
    func checkpointModeConstantsMatchSQLite() {
        #expect(Connection.CheckpointMode.passive.rawValue == SQLITE_CHECKPOINT_PASSIVE)
        #expect(Connection.CheckpointMode.full.rawValue == SQLITE_CHECKPOINT_FULL)
        #expect(Connection.CheckpointMode.restart.rawValue == SQLITE_CHECKPOINT_RESTART)
        #expect(Connection.CheckpointMode.truncate.rawValue == SQLITE_CHECKPOINT_TRUNCATE)
    }

    @Test("CheckpointMode descriptions map values")
    func checkpointModeDescriptions() {
        #expect(Connection.CheckpointMode.passive.description == "passive")
        #expect(Connection.CheckpointMode.full.description == "full")
        #expect(Connection.CheckpointMode.restart.description == "restart")
        #expect(Connection.CheckpointMode.truncate.description == "truncate")
        #expect(Connection.CheckpointMode(rawValue: -2).description == "unknown")
        #expect(Connection.CheckpointMode.passive.debugDescription == "SQLITE_CHECKPOINT_PASSIVE")
        #expect(Connection.CheckpointMode(rawValue: -2).debugDescription == "-2")
    }

    @Test("autoWALCheckpoint and walCheckpoint return results")
    func autoWALCheckpointAndWalCheckpointReturnResults() {
        #expect(connection.autoWALCheckpoint(pageInWALFileCount: 0) == .ok)
        var frameCount: Int32 = -1
        var totalFrameCount: Int32 = -1
        let result = connection.walCheckpoint("main", mode: .passive, frameCount: &frameCount, totalFrameCount: &totalFrameCount)
        #expect(result == .ok)
        #expect(frameCount >= -1)
        #expect(totalFrameCount >= -1)
    }
}
