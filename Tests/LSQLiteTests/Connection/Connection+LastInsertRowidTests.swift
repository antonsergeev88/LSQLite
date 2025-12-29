import LSQLite
import Testing

@Suite("Connection+LastInsertRowid")
final class ConnectionLastInsertRowidTests {
    private let connection: Connection

    init() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        self.connection = connection
        try #require(connection.exec("CREATE TABLE items(id INTEGER PRIMARY KEY)") == .ok)
    }

    deinit {
        _ = connection.close()
    }

    @Test("lastInsertedRowID and setLastInsertedRowID")
    func lastInsertedRowIDAndSetLastInsertedRowID() throws {
        try #require(connection.exec("INSERT INTO items DEFAULT VALUES") == .ok)
        let inserted = connection.lastInsertedRowID()
        #expect(inserted.rawValue > 0)

        let override = RowID(rawValue: 99)
        connection.setLastInsertedRowID(override)
        #expect(connection.lastInsertedRowID().rawValue == 99)
    }
}
