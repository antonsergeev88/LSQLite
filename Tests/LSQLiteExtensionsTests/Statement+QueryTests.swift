import LSQLite
import LSQLiteExtensions
import Testing

@Suite("Statement+Query")
final class StatementQueryTests {
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

    @Test("no-row query reports misuse when rows are produced")
    func noRowQueryReportsMisuseWhenRowsAreProduced() throws {
        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT 1 AS value", for: connection) == .ok)
        let prepared = try #require(statement)
        defer { _ = prepared.finalize() }

        #expect(prepared.query() == .misuse)
    }

    @Test("single-row query reports misuse on second row")
    func singleRowQueryReportsMisuseOnSecondRow() throws {
        struct Row: Decodable {
            let value: Int
        }

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT 1 AS value UNION ALL SELECT 2 AS value", for: connection) == .ok)
        let prepared = try #require(statement)
        defer { _ = prepared.finalize() }

        let result = prepared.query(row: Row.self)
        #expect(result.0 == .misuse)
        #expect(result.1 == nil)
    }

    @Test("statement query is reusable")
    func statementQueryIsReusable() throws {
        struct Input: Encodable {
            let value: Int
        }

        struct Row: Decodable {
            let value: Int
        }

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT :value AS value", for: connection) == .ok)
        let prepared = try #require(statement)
        defer { _ = prepared.finalize() }

        let first = prepared.query(Input(value: 1), row: Row.self)
        #expect(first.0 == .done)
        let firstRow = try #require(first.1)
        #expect(firstRow.value == 1)

        let second = prepared.query(Input(value: 2), row: Row.self)
        #expect(second.0 == .done)
        let secondRow = try #require(second.1)
        #expect(secondRow.value == 2)
    }
}
