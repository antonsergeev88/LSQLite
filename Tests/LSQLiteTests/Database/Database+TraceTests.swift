import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Database+Trace")
struct DatabaseTraceTests {
    @Test("TraceEventCallbackResult init(rawValue:) preserves rawValue")
    func traceEventCallbackResultRawValueRoundTrip() {
        guard #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) else {
            return
        }
        let rawValue = Int32(12)
        let result = Database.TraceEventCallbackResult(rawValue: rawValue)
        #expect(result.rawValue == rawValue)
    }

    @Test("TraceEventCode init(rawValue:) preserves rawValue")
    func traceEventCodeRawValueRoundTrip() {
        guard #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) else {
            return
        }
        let rawValue = UInt32(0x20)
        let code = Database.TraceEventCode(rawValue: rawValue)
        #expect(code.rawValue == rawValue)
    }

    @Test("TraceEventCode init(rawValue:) preserves combined rawValue")
    func traceEventCodeCombinedRawValueRoundTrip() {
        guard #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) else {
            return
        }
        let rawValue = Database.TraceEventCode.statement.rawValue | Database.TraceEventCode.profile.rawValue
        let code = Database.TraceEventCode(rawValue: rawValue)
        #expect(code.rawValue == rawValue)
    }

    @Test("TraceEventCode constants match SQLite")
    func traceEventCodeConstantsMatchSQLite() {
        guard #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) else {
            return
        }
        #expect(Database.TraceEventCode.statement.rawValue == UInt32(SQLITE_TRACE_STMT))
        #expect(Database.TraceEventCode.profile.rawValue == UInt32(SQLITE_TRACE_PROFILE))
        #expect(Database.TraceEventCode.row.rawValue == UInt32(SQLITE_TRACE_ROW))
        #expect(Database.TraceEventCode.close.rawValue == UInt32(SQLITE_TRACE_CLOSE))
    }

    @Test("Trace event descriptions map values")
    func traceEventDescriptionsMapValues() {
        guard #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) else {
            return
        }
        #expect(Database.TraceEventCallbackResult.ok.description == "ok")
        #expect(Database.TraceEventCallbackResult(rawValue: 9).description == "unknown")
        #expect(Database.TraceEventCallbackResult.ok.debugDescription == "ok (0)")
        #expect(Database.TraceEventCode([]).description == "[]")
        #expect(Database.TraceEventCode.statement.description.contains(".statement"))
        #expect(Database.TraceEventCode(rawValue: 0x80).description == "unknown")
        let mixed = Database.TraceEventCode(rawValue: Database.TraceEventCode.row.rawValue | 0x80)
        #expect(mixed.description.contains("unknown"))
        #expect(Database.TraceEventCode.statement.debugDescription.contains("SQLITE_TRACE_STMT"))
        #expect(mixed.debugDescription.contains("0x"))
        #expect(Database.TraceEventCode(rawValue: 0x80).debugDescription.hasPrefix("0x"))
    }

    @Test("setTraceCallback registers callback")
    func setTraceCallbackRegistersCallback() throws {
        guard #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) else {
            return
        }
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)
        var probe = TraceProbe()
        #expect(openDatabase.setTraceCallback(for: [.statement], userData: &probe, callback: traceCallback) == .ok)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT 1", for: openDatabase) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.step() == .row)
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)

        #expect(probe.called)
        #expect(openDatabase.setTraceCallback(for: [], userData: nil, callback: nil) == .ok)
        _ = openDatabase.close()
    }
}

private struct TraceProbe {
    var called = false
}

@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
private func traceCallback(_ traceEventCode: UInt32, _ userData: UnsafeMutableRawPointer?, _ p: UnsafeMutableRawPointer?, _ x: UnsafeMutableRawPointer?) -> Int32 {
    guard let userData else {
        return Database.TraceEventCallbackResult.ok.rawValue
    }
    let probe = userData.assumingMemoryBound(to: TraceProbe.self)
    probe.pointee.called = true
    return Database.TraceEventCallbackResult.ok.rawValue
}
