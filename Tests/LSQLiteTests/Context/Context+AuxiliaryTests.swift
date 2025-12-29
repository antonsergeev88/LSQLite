import LSQLite
import Testing

@Suite("Context+Auxiliary")
struct ContextAuxiliaryTests {
    @Test("setAuxiliaryData and getAuxiliaryData round-trip pointers")
    func auxiliaryDataRoundTrip() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()

        var probe = ContextAuxiliaryProbe()
        #expect(connection.createFunction(name: "ctx_aux", argumentCount: 1, textEncoding: .utf8, userData: &probe, funcHandler: contextAuxiliaryHandler) == .ok)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT ctx_aux(1), ctx_aux(1)", for: connection) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.step() == .row)
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)

        #expect(probe.callCount == 2)
        #expect(probe.initialWasNil)
        #expect(probe.setCalled)
        _ = connection.close()
    }
}

private struct ContextAuxiliaryProbe {
    var callCount: Int32 = 0
    var initialWasNil = false
    var setCalled = false
}

private func contextAuxiliaryHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else {
        return
    }
    let wrapper = Context(rawValue: context)
    let initial = wrapper.getAuxiliaryData(forArgument: 0)
    if let userData = wrapper.userData {
        let probe = userData.assumingMemoryBound(to: ContextAuxiliaryProbe.self)
        probe.pointee.callCount += 1
        if initial == nil {
            probe.pointee.initialWasNil = true
            wrapper.setAuxiliaryData(userData, forArgument: 0)
            probe.pointee.setCalled = true
        } else {
            _ = initial == userData
        }
    }
    wrapper.resultInt(1)
}
