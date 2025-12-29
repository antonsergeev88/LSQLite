import LSQLite
import Testing

@Suite("Context+UserData")
struct ContextUserDataTests {
    @Test("userData returns the registered pointer")
    func userDataReturnsRegisteredPointer() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()

        var probe = ContextUserDataProbe()
        #expect(connection.createFunction(name: "ctx_user_data", argumentCount: 0, textEncoding: .utf8, userData: &probe, funcHandler: contextUserDataHandler) == .ok)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT ctx_user_data()", for: connection) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.step() == .row)
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)

        #expect(probe.matched)
        _ = connection.close()
    }
}

private struct ContextUserDataProbe {
    var matched = false
}

private func contextUserDataHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else {
        return
    }
    let wrapper = Context(rawValue: context)
    if let userData = wrapper.userData {
        let probe = userData.assumingMemoryBound(to: ContextUserDataProbe.self)
        probe.pointee.matched = true
    }
    wrapper.resultInt(1)
}
