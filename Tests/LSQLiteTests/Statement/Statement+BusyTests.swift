import LSQLite
import Testing

@Suite("Statement+Busy")
final class StatementBusyTests {
    private let connection: Connection

    init() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        self.connection = connection
    }

    deinit {
        _ = connection.close()
    }

    @Test("isBusy reflects step progress")
    func isBusyReflectsStepProgress() throws {
        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT 1 UNION ALL SELECT 2", for: connection) == .ok)
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
