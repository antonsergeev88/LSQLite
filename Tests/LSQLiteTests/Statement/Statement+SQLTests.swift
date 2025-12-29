import LSQLite
import Testing

@Suite("Statement+SQL")
struct StatementSQLTests {
    @Test("sql returns original statement text")
    func sqlReturnsOriginalStatementText() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT ?1", for: connection) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.sql == "SELECT ?1")
        #expect(prepared.finalize() == .ok)
        _ = connection.close()
    }

    @Test("expandedSql includes bound values")
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    func expandedSqlIncludesBoundValues() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT ?1", for: connection) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.bindInt(5, at: 1) == .ok)
        let expanded = prepared.expandedSql
        #expect(expanded?.contains("5") == true)
        #expect(prepared.finalize() == .ok)
        _ = connection.close()
    }
}
