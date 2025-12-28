import LSQLite
import Testing

@Suite("Database+Error")
final class DatabaseExtendedResultCodeStatusRawValueTests {
    private let database: Database

    init() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)
        self.database = openDatabase
        try #require(openDatabase.exec("CREATE TABLE items(id INTEGER)") == .ok)
    }

    deinit {
        _ = database.close()
    }

    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(42)
        let status = Database.ExtendedResultCodeStatus(rawValue: rawValue)
        #expect(status.rawValue == rawValue)
    }

    @Test("ExtendedResultCodeStatus descriptions map values")
    func extendedResultCodeStatusDescriptions() {
        #expect(Database.ExtendedResultCodeStatus.off.description == "off")
        #expect(Database.ExtendedResultCodeStatus.on.description == "on")
        #expect(Database.ExtendedResultCodeStatus(rawValue: 3).description == "unknown")
        #expect(Database.ExtendedResultCodeStatus.on.debugDescription == "on (1)")
        #expect(Database.ExtendedResultCodeStatus(rawValue: 3).debugDescription == "unknown (3)")
    }

    @Test("last error fields update after a failure")
    func lastErrorFieldsUpdateAfterFailure() throws {
        #expect(database.exec("INSERT INTO missing_table VALUES (1)") == .error)
        #expect(database.lastErrorCode == .error)
        #expect(database.lastExtendedErrorCode == .error)
        #expect(!database.lastErrorMessage.isEmpty)
    }

    @Test("setExtendedResultCodes toggles status")
    func setExtendedResultCodesTogglesStatus() {
        #expect(database.setExtendedResultCodes(.on) == .ok)
        #expect(database.setExtendedResultCodes(.off) == .ok)
    }
}
