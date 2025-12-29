import LSQLite
import Testing

@Suite("Statement+Reset")
struct StatementResetTests {
    @Test("reset allows re-stepping the statement")
    func resetAllowsReStepping() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT 1", for: connection) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.step() == .row)
        #expect(prepared.step() == .done)
        #expect(prepared.reset() == .ok)
        #expect(prepared.step() == .row)
        #expect(prepared.finalize() == .ok)
        _ = connection.close()
    }
}
