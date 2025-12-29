import LSQLite
import Testing

@Suite("Statement+Column")
final class StatementColumnTests {
    private let connection: Connection

    init() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        self.connection = connection
        try #require(connection.exec("""
            CREATE TABLE col_table(
                text_col TEXT,
                blob_col BLOB,
                int_col INTEGER,
                real_col REAL,
                declared_col TEXT
            )
            """) == .ok)
        try #require(connection.exec("INSERT INTO col_table(text_col, blob_col, int_col, real_col, declared_col) VALUES ('', X'0102', 42, 3.5, 'x')") == .ok)
    }

    deinit {
        _ = connection.close()
    }

    @Test("column metadata and values are available")
    func columnMetadataAndValuesAreAvailable() throws {
        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT text_col, blob_col, int_col, real_col, declared_col, NULL AS null_col, 99 AS literal_col FROM col_table", for: connection) == .ok)
        let prepared = try #require(statement)

        #expect(prepared.columnCount == 7)
        #expect(prepared.dataCount == 0)
        #expect(prepared.step() == .row)
        #expect(prepared.dataCount == 7)

        #expect(prepared.columnName(at: 0) == "text_col")
        #expect(prepared.columnName(at: 5) == "null_col")
        #expect(prepared.columnName(at: 9) == nil)

        #expect(prepared.columnDatabaseName(at: 0) == "main")
        #expect(prepared.columnTableName(at: 0) == "col_table")
        #expect(prepared.columnOriginName(at: 0) == "text_col")
        #expect(prepared.columnDatabaseName(at: 6) == nil)
        #expect(prepared.columnTableName(at: 6) == nil)
        #expect(prepared.columnOriginName(at: 6) == nil)

        #expect(prepared.columnDeclaredType(at: 4) == "TEXT")
        #expect(prepared.columnDeclaredType(at: 6) == nil)

        #expect(prepared.columnBlob(at: 1) != nil)
        #expect(prepared.columnDouble(at: 3) == 3.5)
        #expect(prepared.columnInt(at: 2) == 42)
        #expect(prepared.columnInt64(at: 2) == 42)
        #expect(prepared.columnText(at: 0) == "")
        #expect(prepared.columnText(at: 4) == "x")
        #expect(prepared.columnText(at: 5) == nil)
        #expect(prepared.columnBytes(at: 1) == 2)
        #expect(prepared.columnType(at: 0) == .text)
        #expect(prepared.columnType(at: 5) == .null)

        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)
    }

    @Test("column metadata returns empty identifiers")
    func columnMetadataReturnsEmptyIdentifiers() throws {
        try #require(connection.exec("ATTACH DATABASE ':memory:' AS \"\"") == .ok)
        try #require(connection.exec("CREATE TABLE \"\".\"\" (\"\" \"\")") == .ok)
        try #require(connection.exec("INSERT INTO \"\".\"\" VALUES ('x')") == .ok)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT \"\" FROM \"\".\"\"", for: connection) == .ok)
        let prepared = try #require(statement)

        #expect(prepared.step() == .row)
        #expect(prepared.columnName(at: 0) == "")
        #expect(prepared.columnDatabaseName(at: 0) == "")
        #expect(prepared.columnTableName(at: 0) == "")
        #expect(prepared.columnOriginName(at: 0) == "")
        #expect(prepared.columnDeclaredType(at: 0) == "")
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)
    }
}
