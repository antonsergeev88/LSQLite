import LSQLite
import Testing

@Suite("Context+Connection")
struct ContextConnectionTests {
    @Test("connection returns function connection")
    func connectionReturnsFunctionConnection() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()

        var probe = ContextConnectionProbe()
        #expect(connection.createFunction(name: "ctx_db", argumentCount: 0, textEncoding: .utf8, userData: &probe, funcHandler: contextConnectionHandler) == .ok)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT ctx_db()", for: connection) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.step() == .row)
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)

        #expect(probe.connectionPointer == connection.rawValue)
        _ = connection.close()
    }
}

private struct ContextConnectionProbe {
    var connectionPointer: OpaquePointer?
}

private func contextConnectionHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else {
        return
    }
    let contextWrapper = Context(rawValue: context)
    if let userData = contextWrapper.userData {
        let probe = userData.assumingMemoryBound(to: ContextConnectionProbe.self)
        probe.pointee.connectionPointer = contextWrapper.connection?.rawValue
    }
    contextWrapper.resultInt(1)
}
