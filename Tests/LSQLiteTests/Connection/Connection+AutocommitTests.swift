import LSQLite
import Testing

@Suite("Connection+Autocommit")
final class ConnectionAutocommitTests {
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

    @Test("isAutocommit reflects transaction state")
    func autocommitReflectsTransactionState() throws {
        #expect(connection.isAutocommit)

        try #require(connection.exec("BEGIN") == .ok)
        #expect(!connection.isAutocommit)

        try #require(connection.exec("COMMIT") == .ok)
        #expect(connection.isAutocommit)
    }
}
