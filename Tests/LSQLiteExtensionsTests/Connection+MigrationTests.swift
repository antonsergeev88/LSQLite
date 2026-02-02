import LSQLite
import LSQLiteExtensions
import Testing

@Suite("Connection+Migration")
final class ConnectionMigrationTests {
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

    @Test("migrations apply in order and update version")
    func migrationsApplyInOrderAndUpdateVersion() throws {
        #expect(connection.setUserVersion(0) == .done)
        var applied: [Int32] = []
        let migrations = [
            Connection.Migration(version: 2) { _ in
                applied.append(2)
                return .ok
            },
            Connection.Migration(version: 1) { _ in
                applied.append(1)
                return .ok
            }
        ]
        #expect(connection.migrate(migrations) == .done)
        #expect(applied == [1, 2])

        let version = connection.userVersion()
        #expect(version.0 == .done)
        let value = try #require(version.1)
        #expect(value == 2)

        applied.removeAll()
        #expect(connection.migrate(migrations) == .done)
        #expect(applied.isEmpty)
    }

    @Test("duplicate versions are misuse")
    func duplicateVersionsAreMisuse() {
        #expect(connection.setUserVersion(0) == .done)
        let migrations = [
            Connection.Migration(version: 1) { _ in .ok },
            Connection.Migration(version: 1) { _ in .ok }
        ]
        #expect(connection.migrate(migrations) == .misuse)
    }
}
