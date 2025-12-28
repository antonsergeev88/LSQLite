import LSQLite
import Testing

@Suite("Statement+SQL")
struct StatementSQLTests {
    @Test("sql returns original statement text")
    func sqlReturnsOriginalStatementText() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT ?1", for: openDatabase) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.sql == "SELECT ?1")
        #expect(prepared.finalize() == .ok)
        _ = openDatabase.close()
    }

    @Test("expandedSql includes bound values")
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    func expandedSqlIncludesBoundValues() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT ?1", for: openDatabase) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.bindInt(5, at: 1) == .ok)
        let expanded = prepared.expandedSql
        #expect(expanded?.contains("5") == true)
        #expect(prepared.finalize() == .ok)
        _ = openDatabase.close()
    }
}
