import LSQLite
import Testing

@Suite("Database+Statement")
final class DatabaseStatementTests {
    private let database: Database

    init() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        self.database = try #require(database)
    }

    deinit {
        _ = database.close()
    }

    @Test("nextStatement iterates prepared statements")
    func nextStatementIteratesPreparedStatements() throws {
        var first: Statement?
        var second: Statement?
        try #require(Statement.prepare(&first, sql: "SELECT 1", for: database) == .ok)
        try #require(Statement.prepare(&second, sql: "SELECT 2", for: database) == .ok)
        let firstStatement = try #require(first)
        let secondStatement = try #require(second)

        let firstFromAPI = try #require(database.nextStatement(after: nil))
        let secondFromAPI = database.nextStatement(after: firstFromAPI)
        let thirdFromAPI = database.nextStatement(after: secondFromAPI)

        let preparedPointers = [firstStatement.rawValue, secondStatement.rawValue]
        #expect(preparedPointers.contains(firstFromAPI.rawValue))
        #expect(preparedPointers.contains(try #require(secondFromAPI).rawValue))
        #expect(firstFromAPI.rawValue != secondFromAPI?.rawValue)
        #expect(thirdFromAPI == nil)

        #expect(firstStatement.finalize() == .ok)
        #expect(secondStatement.finalize() == .ok)
    }
}
