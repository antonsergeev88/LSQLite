import LSQLite
import Testing

@Suite("Connection+Changes")
final class ConnectionChangesTests {
    private let connection: Connection

    init() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        self.connection = connection
        try #require(connection.exec("CREATE TABLE changes(value TEXT)") == .ok)
    }

    deinit {
        _ = connection.close()
    }

    @Test("changes and totalChanges track writes")
    func changesAndTotalChangesTrackWrites() throws {
        try #require(connection.exec("INSERT INTO changes(value) VALUES ('a')") == .ok)
        #expect(connection.changes == 1)
        let totalAfterInsert = connection.totalChanges

        try #require(connection.exec("UPDATE changes SET value = 'b'") == .ok)
        #expect(connection.changes == 1)
        #expect(connection.totalChanges == totalAfterInsert + 1)
    }
}
