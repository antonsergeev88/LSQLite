import LSQLite
import Testing

@Suite("Database+LastInsertRowid")
final class DatabaseLastInsertRowidTests {
    private let database: Database

    init() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)
        self.database = openDatabase
        try #require(openDatabase.exec("CREATE TABLE items(id INTEGER PRIMARY KEY)") == .ok)
    }

    deinit {
        _ = database.close()
    }

    @Test("lastInsertedRowID and setLastInsertedRowID")
    func lastInsertedRowIDAndSetLastInsertedRowID() throws {
        try #require(database.exec("INSERT INTO items DEFAULT VALUES") == .ok)
        let inserted = database.lastInsertedRowID()
        #expect(inserted.rawValue > 0)

        let override = RowID(rawValue: 99)
        database.setLastInsertedRowID(override)
        #expect(database.lastInsertedRowID().rawValue == 99)
    }
}
