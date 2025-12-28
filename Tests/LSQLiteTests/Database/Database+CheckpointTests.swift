import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Database+Checkpoint")
struct DatabaseCheckpointModeRawValueTests {
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
}
