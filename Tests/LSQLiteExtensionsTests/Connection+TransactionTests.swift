import LSQLite
import LSQLiteExtensions
import Testing

@Suite("Connection+Transaction")
final class ConnectionTransactionTests {
    private let connection: Connection

    init() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        self.connection = connection
        try #require(connection.exec("CREATE TABLE t(id INTEGER);") == .ok)
    }

    deinit {
        _ = connection.close()
    }

    @Test("begin/commit toggles autocommit")
    func beginCommitTogglesAutocommit() throws {
        #expect(connection.isAutocommit)
        #expect(connection.beginTransaction() == .ok)
        #expect(!connection.isAutocommit)
        #expect(connection.commitTransaction() == .ok)
        #expect(connection.isAutocommit)
    }

    @Test("rollback restores autocommit")
    func rollbackRestoresAutocommit() throws {
        #expect(connection.beginTransaction() == .ok)
        #expect(!connection.isAutocommit)
        #expect(connection.rollbackTransaction() == .ok)
        #expect(connection.isAutocommit)
    }

    @Test("nested transaction leaves outer active")
    func nestedTransactionLeavesOuterActive() throws {
        #expect(connection.beginTransaction() == .ok)
        #expect(!connection.isAutocommit)
        let inner = connection.transaction { db in
            db.exec("INSERT INTO t(id) VALUES (1);")
        }
        #expect(inner == .ok)
        #expect(!connection.isAutocommit)
        #expect(connection.rollbackTransaction() == .ok)
        #expect(connection.isAutocommit)
    }
}
