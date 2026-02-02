import LSQLite
import LSQLiteExtensions
import Testing

@Suite("Connection+Query")
final class ConnectionQueryTests {
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
        #expect(connection.query("SELECT 1 AS value") == .misuse)
    }

    @Test("single-row query reports misuse on second row")
    func singleRowQueryReportsMisuseOnSecondRow() throws {
        struct Row: Decodable {
            let value: Int
        }

        let result = connection.query("SELECT 1 AS value UNION ALL SELECT 2 AS value", row: Row.self)
        #expect(result.0 == .misuse)
        #expect(result.1 == nil)
    }

    @Test("connection query is reusable")
    func connectionQueryIsReusable() throws {
        struct Input: Encodable {
            let value: Int
        }

        struct Row: Decodable {
            let value: Int
        }

        let first = connection.query("SELECT :value AS value", binding: Input(value: 10), row: Row.self)
        #expect(first.0 == .done)
        let firstRow = try #require(first.1)
        #expect(firstRow.value == 10)

        let second = connection.query("SELECT :value AS value", binding: Input(value: 20), row: Row.self)
        #expect(second.0 == .done)
        let secondRow = try #require(second.1)
        #expect(secondRow.value == 20)
    }
}
