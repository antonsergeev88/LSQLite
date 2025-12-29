import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Connection+Trace")
struct ConnectionTraceTests {
    @Test("TraceEventCallbackResult init(rawValue:) preserves rawValue")
    func traceEventCallbackResultRawValueRoundTrip() {
        guard #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) else {
            return
        }
        let rawValue = Int32(12)
        let result = Connection.TraceEventCallbackResult(rawValue: rawValue)
        #expect(result.rawValue == rawValue)
    }

    @Test("TraceEventCode init(rawValue:) preserves rawValue")
    func traceEventCodeRawValueRoundTrip() {
        guard #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) else {
            return
        }
        let rawValue = UInt32(0x20)
        let code = Connection.TraceEventCode(rawValue: rawValue)
        #expect(code.rawValue == rawValue)
    }

    @Test("TraceEventCode init(rawValue:) preserves combined rawValue")
    func traceEventCodeCombinedRawValueRoundTrip() {
        guard #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) else {
            return
        }
        let rawValue = Connection.TraceEventCode.statement.rawValue | Connection.TraceEventCode.profile.rawValue
        let code = Connection.TraceEventCode(rawValue: rawValue)
        #expect(code.rawValue == rawValue)
    }

    @Test("TraceEventCode constants match SQLite")
    func traceEventCodeConstantsMatchSQLite() {
        guard #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) else {
            return
        }
        #expect(Connection.TraceEventCode.statement.rawValue == UInt32(SQLITE_TRACE_STMT))
        #expect(Connection.TraceEventCode.profile.rawValue == UInt32(SQLITE_TRACE_PROFILE))
        #expect(Connection.TraceEventCode.row.rawValue == UInt32(SQLITE_TRACE_ROW))
        #expect(Connection.TraceEventCode.close.rawValue == UInt32(SQLITE_TRACE_CLOSE))
    }

    @Test("Trace event descriptions map values")
    func traceEventDescriptionsMapValues() {
        guard #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) else {
            return
        }
        #expect(Connection.TraceEventCallbackResult.ok.description == "ok")
        #expect(Connection.TraceEventCallbackResult(rawValue: 9).description == "unknown")
        #expect(Connection.TraceEventCallbackResult.ok.debugDescription == "ok (0)")
        #expect(Connection.TraceEventCode([]).description == "[]")
        #expect(Connection.TraceEventCode.statement.description.contains(".statement"))
        #expect(Connection.TraceEventCode(rawValue: 0x80).description == "unknown")
        let mixed = Connection.TraceEventCode(rawValue: Connection.TraceEventCode.row.rawValue | 0x80)
        #expect(mixed.description.contains("unknown"))
        #expect(Connection.TraceEventCode.statement.debugDescription.contains("SQLITE_TRACE_STMT"))
        #expect(mixed.debugDescription.contains("0x"))
        #expect(Connection.TraceEventCode(rawValue: 0x80).debugDescription.hasPrefix("0x"))
    }

    @Test("setTraceCallback registers callback")
    func setTraceCallbackRegistersCallback() throws {
        guard #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) else {
            return
        }
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        var probe = TraceProbe()
        #expect(connection.setTraceCallback(for: [.statement], userData: &probe, callback: traceCallback) == .ok)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT 1", for: connection) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.step() == .row)
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)

        #expect(probe.called)
        #expect(connection.setTraceCallback(for: [], userData: nil, callback: nil) == .ok)
        _ = connection.close()
    }
}

private struct TraceProbe {
    var called = false
}

@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
private func traceCallback(_ traceEventCode: UInt32, _ userData: UnsafeMutableRawPointer?, _ p: UnsafeMutableRawPointer?, _ x: UnsafeMutableRawPointer?) -> Int32 {
    guard let userData else {
        return Connection.TraceEventCallbackResult.ok.rawValue
    }
    let probe = userData.assumingMemoryBound(to: TraceProbe.self)
    probe.pointee.called = true
    return Connection.TraceEventCallbackResult.ok.rawValue
}
