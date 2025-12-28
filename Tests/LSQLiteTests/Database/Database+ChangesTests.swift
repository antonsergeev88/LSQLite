import LSQLite
import Testing

@Suite("Database+Changes")
final class DatabaseChangesTests {
    private let database: Database

    init() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)
        self.database = openDatabase
        try #require(openDatabase.exec("CREATE TABLE changes(value TEXT)") == .ok)
    }

    deinit {
        _ = database.close()
    }

    @Test("changes and totalChanges track writes")
    func changesAndTotalChangesTrackWrites() throws {
        try #require(database.exec("INSERT INTO changes(value) VALUES ('a')") == .ok)
        #expect(database.changes == 1)
        let totalAfterInsert = database.totalChanges

        try #require(database.exec("UPDATE changes SET value = 'b'") == .ok)
        #expect(database.changes == 1)
        #expect(database.totalChanges == totalAfterInsert + 1)
    }
}
