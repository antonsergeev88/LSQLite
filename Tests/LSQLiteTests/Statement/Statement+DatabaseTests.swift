import LSQLite
import Testing

@Suite("Statement+Database")
struct StatementDatabaseTests {
    @Test("database returns owning connection")
    func databaseReturnsOwningConnection() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT 1", for: openDatabase) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.database?.rawValue == openDatabase.rawValue)
        #expect(prepared.finalize() == .ok)
        _ = openDatabase.close()
    }
}
