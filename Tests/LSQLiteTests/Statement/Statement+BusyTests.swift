import LSQLite
import Testing

@Suite("Statement+Busy")
final class StatementBusyTests {
    private let database: Database

    init() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        self.database = try #require(database)
    }

    deinit {
        _ = database.close()
    }

    @Test("isBusy reflects step progress")
    func isBusyReflectsStepProgress() throws {
        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT 1 UNION ALL SELECT 2", for: database) == .ok)
        let prepared = try #require(statement)

        #expect(!prepared.isBusy)
        #expect(prepared.step() == .row)
        #expect(prepared.isBusy)
        #expect(prepared.step() == .row)
        #expect(prepared.step() == .done)
        #expect(!prepared.isBusy)
        #expect(prepared.finalize() == .ok)
    }
}
