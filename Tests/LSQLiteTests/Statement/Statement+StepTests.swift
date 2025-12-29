import LSQLite
import Testing

@Suite("Statement+Step")
struct StatementStepTests {
    @Test("step advances through rows")
    func stepAdvancesThroughRows() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT 1 UNION ALL SELECT 2", for: connection) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.step() == .row)
        #expect(prepared.step() == .row)
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)
        _ = connection.close()
    }
}
