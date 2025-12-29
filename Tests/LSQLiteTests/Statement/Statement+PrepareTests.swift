import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Statement+Prepare")
final class StatementPrepareFlagRawValueTests {
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
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = UInt32(0x10)
        let prepareFlag = Statement.PrepareFlag(rawValue: rawValue)
        #expect(prepareFlag.rawValue == rawValue)
    }

    @Test("PrepareFlag init(rawValue:) preserves combined rawValue")
    func combinedRawValueRoundTrip() {
        let rawValue = Statement.PrepareFlag.persistent.rawValue | Statement.PrepareFlag.normalize.rawValue
        let prepareFlag = Statement.PrepareFlag(rawValue: rawValue)
        #expect(prepareFlag.rawValue == rawValue)
    }

    @Test("PrepareFlag constants match SQLite")
    func prepareFlagConstantsMatchSQLite() {
        #expect(Statement.PrepareFlag.persistent.rawValue == UInt32(SQLITE_PREPARE_PERSISTENT))
        #expect(Statement.PrepareFlag.normalize.rawValue == UInt32(SQLITE_PREPARE_NORMALIZE))
        #expect(Statement.PrepareFlag.noVTab.rawValue == UInt32(SQLITE_PREPARE_NO_VTAB))
    }

    @Test("PrepareFlag descriptions map values")
    func prepareFlagDescriptions() {
        #expect(Statement.PrepareFlag([]).description == "[]")
        #expect(Statement.PrepareFlag.persistent.description.contains(".persistent"))
        #expect(Statement.PrepareFlag(rawValue: 0x80).description == "unknown")
        let mixed = Statement.PrepareFlag(rawValue: Statement.PrepareFlag.normalize.rawValue | 0x80)
        #expect(mixed.description.contains("unknown"))
        #expect(Statement.PrepareFlag.persistent.debugDescription.contains("SQLITE_PREPARE_PERSISTENT"))
        #expect(mixed.debugDescription.contains("0x"))
        #expect(Statement.PrepareFlag(rawValue: 0x80).debugDescription.hasPrefix("0x"))
    }

    @Test("prepare compiles SQL and provides tail")
    func prepareCompilesSQLAndProvidesTail() throws {
        var statement: Statement?
        var tail: String?
        try #require(Statement.prepare(&statement, sql: "SELECT 1; SELECT 2", tail: &tail, for: connection) == .ok)
        let prepared = try #require(statement)
        #expect(tail?.contains("SELECT 2") == true)
        #expect(prepared.finalize() == .ok)
    }

    @Test("prepare compiles SQL without tail")
    func prepareCompilesSQLWithoutTail() throws {
        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT 1", for: connection) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.finalize() == .ok)
    }

    @Test("prepare with flags compiles SQL")
    @available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
    func prepareWithFlagsCompilesSQL() throws {
        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT 1", for: connection, prepareFlag: [.persistent]) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.finalize() == .ok)
    }
}
