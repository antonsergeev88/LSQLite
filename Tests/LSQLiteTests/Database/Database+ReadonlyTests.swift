import LSQLite
import Testing

@Suite("Database+Readonly")
final class DatabaseReadWriteAccessStateRawValueTests {
    private let database: Database

    init() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        self.database = try #require(database)
    }

    deinit {
        _ = database.close()
    }

    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(-7)
        let state = Database.ReadWriteAccessState(rawValue: rawValue)
        #expect(state.rawValue == rawValue)
    }

    @Test("ReadWriteAccessState descriptions map values")
    func readWriteAccessStateDescriptions() {
        #expect(Database.ReadWriteAccessState.noDatabase.description == "no database")
        #expect(Database.ReadWriteAccessState.readwrite.description == "readwrite")
        #expect(Database.ReadWriteAccessState.readonly.description == "readonly")
        #expect(Database.ReadWriteAccessState(rawValue: 9).description == "unknown")
        #expect(Database.ReadWriteAccessState.readwrite.debugDescription == "readwrite (0)")
        #expect(Database.ReadWriteAccessState(rawValue: 9).debugDescription == "unknown (9)")
    }

    @Test("readWriteAccessState returns status for named database")
    func readWriteAccessStateReturnsStatusForNamedDatabase() {
        #expect(database.readWriteAccessState(forDatabaseNamed: "main") == .readwrite)
        #expect(database.readWriteAccessState(forDatabaseNamed: "missing") == .noDatabase)
    }
}
