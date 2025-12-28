import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Database+Trace")
struct DatabaseTraceTests {
    @Test("TraceEventCallbackResult init(rawValue:) preserves rawValue")
    func traceEventCallbackResultRawValueRoundTrip() {
        let rawValue = Int32(12)
        let result = Database.TraceEventCallbackResult(rawValue: rawValue)
        #expect(result.rawValue == rawValue)
    }

    @Test("TraceEventCode init(rawValue:) preserves rawValue")
    func traceEventCodeRawValueRoundTrip() {
        let rawValue = UInt32(0x20)
        let code = Database.TraceEventCode(rawValue: rawValue)
        #expect(code.rawValue == rawValue)
    }

    @Test("TraceEventCode init(rawValue:) preserves combined rawValue")
    func traceEventCodeCombinedRawValueRoundTrip() {
        let rawValue = Database.TraceEventCode.statement.rawValue | Database.TraceEventCode.profile.rawValue
        let code = Database.TraceEventCode(rawValue: rawValue)
        #expect(code.rawValue == rawValue)
    }

    @Test("TraceEventCode constants match SQLite")
    func traceEventCodeConstantsMatchSQLite() {
        #expect(Database.TraceEventCode.statement.rawValue == UInt32(SQLITE_TRACE_STMT))
        #expect(Database.TraceEventCode.profile.rawValue == UInt32(SQLITE_TRACE_PROFILE))
        #expect(Database.TraceEventCode.row.rawValue == UInt32(SQLITE_TRACE_ROW))
        #expect(Database.TraceEventCode.close.rawValue == UInt32(SQLITE_TRACE_CLOSE))
    }
}
