import LSQLite
import Testing

@Suite("Statement+Finalize")
struct StatementFinalizeTests {
    @Test("finalize releases statement")
    func finalizeReleasesStatement() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT 1", for: openDatabase) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.finalize() == .ok)
        _ = openDatabase.close()
    }
}
