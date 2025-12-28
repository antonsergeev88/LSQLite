import LSQLite
import Testing

@Suite("Statement+Reset")
struct StatementResetTests {
    @Test("reset allows re-stepping the statement")
    func resetAllowsReStepping() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT 1", for: openDatabase) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.step() == .row)
        #expect(prepared.step() == .done)
        #expect(prepared.reset() == .ok)
        #expect(prepared.step() == .row)
        #expect(prepared.finalize() == .ok)
        _ = openDatabase.close()
    }
}
