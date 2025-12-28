import LSQLite
import Testing

@Suite("Statement+Step")
struct StatementStepTests {
    @Test("step advances through rows")
    func stepAdvancesThroughRows() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT 1 UNION ALL SELECT 2", for: openDatabase) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.step() == .row)
        #expect(prepared.step() == .row)
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)
        _ = openDatabase.close()
    }
}
