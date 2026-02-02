import LSQLite
import LSQLiteExtensions
import Testing

@Suite("Connection+Pragma")
final class ConnectionPragmaTests {
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

    @Test("user version round-trips")
    func userVersionRoundTrips() throws {
        #expect(connection.setUserVersion(42) == .done)
        let result = connection.userVersion()
        #expect(result.0 == .done)
        let value = try #require(result.1)
        #expect(value == 42)
    }

    @Test("application id round-trips")
    func applicationIdRoundTrips() throws {
        #expect(connection.setApplicationId(1337) == .done)
        let result = connection.applicationId()
        #expect(result.0 == .done)
        let value = try #require(result.1)
        #expect(value == 1337)
    }

    @Test("foreign keys toggles")
    func foreignKeysToggles() throws {
        #expect(connection.setForeignKeysEnabled(true) == .done)
        let enabled = connection.foreignKeysEnabled()
        #expect(enabled.0 == .done)
        let enabledValue = try #require(enabled.1)
        #expect(enabledValue)

        #expect(connection.setForeignKeysEnabled(false) == .done)
        let disabled = connection.foreignKeysEnabled()
        #expect(disabled.0 == .done)
        let disabledValue = try #require(disabled.1)
        #expect(!disabledValue)
    }
}
