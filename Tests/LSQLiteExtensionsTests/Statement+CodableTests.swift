import Foundation
import LSQLite
import LSQLiteExtensions
import Testing

@Suite("Statement+Codable")
final class StatementCodableTests {
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

    @Test("bind encodes supported values")
    func bindEncodesSupportedValues() throws {
        struct Input: Encodable {
            let name: String
            let age: Int
            let score: Double
            let blob: Data
            let noneValue: String?

            enum CodingKeys: String, CodingKey {
                case name
                case age
                case score
                case blob
                case noneValue
            }

            func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(name, forKey: .name)
                try container.encode(age, forKey: .age)
                try container.encode(score, forKey: .score)
                try container.encode(blob, forKey: .blob)
                try container.encodeNil(forKey: .noneValue)
            }
        }

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT :name AS name, :age AS age, :score AS score, :blob AS blob, :noneValue AS noneValue", for: connection) == .ok)
        let prepared = try #require(statement)
        defer { _ = prepared.finalize() }

        let input = Input(name: "Ada", age: 42, score: 98.5, blob: Data([0x0A, 0x0B]), noneValue: nil)
        #expect(prepared.bind(input))
        #expect(prepared.step() == .row)
        #expect(prepared.columnText(at: 0) == "Ada")
        #expect(prepared.columnInt64(at: 1) == 42)
        #expect(prepared.columnDouble(at: 2) == 98.5)
        #expect(prepared.columnBytes(at: 3) == 2)
        #expect(prepared.columnBlob(at: 3) != nil)
        #expect(prepared.columnType(at: 4) == .null)
        #expect(prepared.step() == .done)
    }

    @Test("bind rejects missing keys")
    func bindRejectsMissingKeys() throws {
        struct Input: Encodable {
            let name: String
        }

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT :name AS name, :age AS age", for: connection) == .ok)
        let prepared = try #require(statement)
        defer { _ = prepared.finalize() }

        #expect(prepared.bind(Input(name: "Ada")) == false)
    }

    @Test("bind rejects unsupported types")
    func bindRejectsUnsupportedTypes() throws {
        struct Input: Encodable {
            let flag: Bool
        }

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT :flag AS flag", for: connection) == .ok)
        let prepared = try #require(statement)
        defer { _ = prepared.finalize() }

        #expect(prepared.bind(Input(flag: true)) == false)
    }

    @Test("row decodes supported values")
    func rowDecodesSupportedValues() throws {
        struct Row: Decodable {
            let name: String
            let age: Int
            let score: Double
            let blob: Data
            let noneValue: String?
        }

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT 'Ada' AS name, 42 AS age, 98.5 AS score, X'0A0B' AS blob, NULL AS noneValue", for: connection) == .ok)
        let prepared = try #require(statement)
        defer { _ = prepared.finalize() }

        #expect(prepared.step() == .row)
        let row = try #require(prepared.row(Row.self))
        #expect(row.name == "Ada")
        #expect(row.age == 42)
        #expect(row.score == 98.5)
        #expect(row.blob == Data([0x0A, 0x0B]))
        #expect(row.noneValue == nil)
        #expect(prepared.step() == .done)
    }

    @Test("row rejects column mismatch")
    func rowRejectsColumnMismatch() throws {
        struct Row: Decodable {
            let one: Int
            let two: Int
        }

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT 1 AS one", for: connection) == .ok)
        let prepared = try #require(statement)
        defer { _ = prepared.finalize() }

        #expect(prepared.step() == .row)
        #expect(prepared.row(Row.self) == nil)
    }
}
