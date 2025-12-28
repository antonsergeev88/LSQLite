import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Statement+Prepare")
struct StatementPrepareFlagRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = UInt32(0x10)
        let prepareFlag = Statement.PrepareFlag(rawValue: rawValue)
        #expect(prepareFlag.rawValue == rawValue)
    }

    @Test("PrepareFlag init(rawValue:) preserves combined rawValue")
    func combinedRawValueRoundTrip() {
        let rawValue = Statement.PrepareFlag.persistent.rawValue | Statement.PrepareFlag.normalize.rawValue
        let prepareFlag = Statement.PrepareFlag(rawValue: rawValue)
        #expect(prepareFlag.rawValue == rawValue)
    }

    @Test("PrepareFlag constants match SQLite")
    func prepareFlagConstantsMatchSQLite() {
        #expect(Statement.PrepareFlag.persistent.rawValue == UInt32(SQLITE_PREPARE_PERSISTENT))
        #expect(Statement.PrepareFlag.normalize.rawValue == UInt32(SQLITE_PREPARE_NORMALIZE))
        #expect(Statement.PrepareFlag.noVTab.rawValue == UInt32(SQLITE_PREPARE_NO_VTAB))
    }
}
