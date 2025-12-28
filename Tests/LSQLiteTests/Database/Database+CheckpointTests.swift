import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Database+Checkpoint")
final class DatabaseCheckpointModeRawValueTests {
    private let database: Database

    init() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        self.database = try #require(database)
    }

    deinit {
        _ = database.close()
    }

    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(9)
        let mode = Database.CheckpointMode(rawValue: rawValue)
        #expect(mode.rawValue == rawValue)
    }

    @Test("CheckpointMode constants match SQLite")
    func checkpointModeConstantsMatchSQLite() {
        #expect(Database.CheckpointMode.passive.rawValue == SQLITE_CHECKPOINT_PASSIVE)
        #expect(Database.CheckpointMode.full.rawValue == SQLITE_CHECKPOINT_FULL)
        #expect(Database.CheckpointMode.restart.rawValue == SQLITE_CHECKPOINT_RESTART)
        #expect(Database.CheckpointMode.truncate.rawValue == SQLITE_CHECKPOINT_TRUNCATE)
    }

    @Test("CheckpointMode descriptions map values")
    func checkpointModeDescriptions() {
        #expect(Database.CheckpointMode.passive.description == "passive")
        #expect(Database.CheckpointMode.full.description == "full")
        #expect(Database.CheckpointMode.restart.description == "restart")
        #expect(Database.CheckpointMode.truncate.description == "truncate")
        #expect(Database.CheckpointMode(rawValue: -2).description == "unknown")
        #expect(Database.CheckpointMode.passive.debugDescription == "SQLITE_CHECKPOINT_PASSIVE")
        #expect(Database.CheckpointMode(rawValue: -2).debugDescription == "-2")
    }

    @Test("autoWALCheckpoint and walCheckpoint return results")
    func autoWALCheckpointAndWalCheckpointReturnResults() {
        #expect(database.autoWALCheckpoint(pageInWALFileCount: 0) == .ok)
        var frameCount: Int32 = -1
        var totalFrameCount: Int32 = -1
        let result = database.walCheckpoint("main", mode: .passive, frameCount: &frameCount, totalFrameCount: &totalFrameCount)
        #expect(result == .ok)
        #expect(frameCount >= -1)
        #expect(totalFrameCount >= -1)
    }
}
