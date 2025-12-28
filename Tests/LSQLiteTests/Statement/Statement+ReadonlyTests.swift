import LSQLite
import Testing

@Suite("Statement+Readonly")
struct StatementReadonlyTests {
    @Test("isReadonly reflects statement type")
    func isReadonlyReflectsStatementType() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)
        try #require(openDatabase.exec("CREATE TABLE items(id INTEGER)") == .ok)

        var selectStatement: Statement?
        try #require(Statement.prepare(&selectStatement, sql: "SELECT id FROM items", for: openDatabase) == .ok)
        let selectPrepared = try #require(selectStatement)
        #expect(selectPrepared.isReadonly)
        #expect(selectPrepared.finalize() == .ok)

        var insertStatement: Statement?
        try #require(Statement.prepare(&insertStatement, sql: "INSERT INTO items(id) VALUES (1)", for: openDatabase) == .ok)
        let insertPrepared = try #require(insertStatement)
        #expect(!insertPrepared.isReadonly)
        #expect(insertPrepared.finalize() == .ok)

        _ = openDatabase.close()
    }
}
