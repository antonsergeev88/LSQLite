import LSQLite
import Testing

@Suite("Statement+Connection")
struct StatementConnectionTests {
    @Test("connection returns owning connection")
    func connectionReturnsOwningConnection() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT 1", for: connection) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.connection?.rawValue == connection.rawValue)
        #expect(prepared.finalize() == .ok)
        _ = connection.close()
    }
}
