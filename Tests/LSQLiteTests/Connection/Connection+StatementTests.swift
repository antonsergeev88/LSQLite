import LSQLite
import Testing

@Suite("Connection+Statement")
final class ConnectionStatementTests {
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

    @Test("nextStatement iterates prepared statements")
    func nextStatementIteratesPreparedStatements() throws {
        var first: Statement?
        var second: Statement?
        try #require(Statement.prepare(&first, sql: "SELECT 1", for: connection) == .ok)
        try #require(Statement.prepare(&second, sql: "SELECT 2", for: connection) == .ok)
        let firstStatement = try #require(first)
        let secondStatement = try #require(second)

        let firstFromAPI = try #require(connection.nextStatement(after: nil))
        let secondFromAPI = connection.nextStatement(after: firstFromAPI)
        let thirdFromAPI = connection.nextStatement(after: secondFromAPI)

        let preparedPointers = [firstStatement.rawValue, secondStatement.rawValue]
        #expect(preparedPointers.contains(firstFromAPI.rawValue))
        #expect(preparedPointers.contains(try #require(secondFromAPI).rawValue))
        #expect(firstFromAPI.rawValue != secondFromAPI?.rawValue)
        #expect(thirdFromAPI == nil)

        #expect(firstStatement.finalize() == .ok)
        #expect(secondStatement.finalize() == .ok)
    }
}
