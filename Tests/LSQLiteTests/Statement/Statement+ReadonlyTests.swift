import LSQLite
import Testing

@Suite("Statement+Readonly")
struct StatementReadonlyTests {
    @Test("isReadonly reflects statement type")
    func isReadonlyReflectsStatementType() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        try #require(connection.exec("CREATE TABLE items(id INTEGER)") == .ok)

        var selectStatement: Statement?
        try #require(Statement.prepare(&selectStatement, sql: "SELECT id FROM items", for: connection) == .ok)
        let selectPrepared = try #require(selectStatement)
        #expect(selectPrepared.isReadonly)
        #expect(selectPrepared.finalize() == .ok)

        var insertStatement: Statement?
        try #require(Statement.prepare(&insertStatement, sql: "INSERT INTO items(id) VALUES (1)", for: connection) == .ok)
        let insertPrepared = try #require(insertStatement)
        #expect(!insertPrepared.isReadonly)
        #expect(insertPrepared.finalize() == .ok)

        _ = connection.close()
    }
}
