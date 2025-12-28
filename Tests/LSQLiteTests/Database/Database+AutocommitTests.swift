import LSQLite
import Testing

@Suite("Database+Autocommit")
final class DatabaseAutocommitTests {
    private let database: Database

    init() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        self.database = try #require(database)
    }

    deinit {
        _ = database.close()
    }

    @Test("isAutocommit reflects transaction state")
    func autocommitReflectsTransactionState() throws {
        #expect(database.isAutocommit)

        try #require(database.exec("BEGIN") == .ok)
        #expect(!database.isAutocommit)

        try #require(database.exec("COMMIT") == .ok)
        #expect(database.isAutocommit)
    }
}
