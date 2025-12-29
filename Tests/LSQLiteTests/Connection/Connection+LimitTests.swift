import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Connection+Limit")
final class ConnectionLimitCategoryRawValueTests {
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
        let rawValue = Int32(5)
        let category = Connection.LimitCategory(rawValue: rawValue)
        #expect(category.rawValue == rawValue)
    }

    @Test("LimitCategory constants match SQLite")
    func limitCategoryConstantsMatchSQLite() {
        #expect(Connection.LimitCategory.length.rawValue == SQLITE_LIMIT_LENGTH)
        #expect(Connection.LimitCategory.sqlLength.rawValue == SQLITE_LIMIT_SQL_LENGTH)
        #expect(Connection.LimitCategory.column.rawValue == SQLITE_LIMIT_COLUMN)
        #expect(Connection.LimitCategory.exprDepth.rawValue == SQLITE_LIMIT_EXPR_DEPTH)
        #expect(Connection.LimitCategory.compoundSelect.rawValue == SQLITE_LIMIT_COMPOUND_SELECT)
        #expect(Connection.LimitCategory.vdbeOp.rawValue == SQLITE_LIMIT_VDBE_OP)
        #expect(Connection.LimitCategory.functionArg.rawValue == SQLITE_LIMIT_FUNCTION_ARG)
        #expect(Connection.LimitCategory.attached.rawValue == SQLITE_LIMIT_ATTACHED)
        #expect(Connection.LimitCategory.likePatternLength.rawValue == SQLITE_LIMIT_LIKE_PATTERN_LENGTH)
        #expect(Connection.LimitCategory.variableNumber.rawValue == SQLITE_LIMIT_VARIABLE_NUMBER)
        #expect(Connection.LimitCategory.triggerDepth.rawValue == SQLITE_LIMIT_TRIGGER_DEPTH)
        #expect(Connection.LimitCategory.workerThreads.rawValue == SQLITE_LIMIT_WORKER_THREADS)
    }

    @Test("LimitCategory descriptions map values")
    func limitCategoryDescriptions() {
        #expect(Connection.LimitCategory.length.description == "length")
        #expect(Connection.LimitCategory.sqlLength.description == "sql length")
        #expect(Connection.LimitCategory.column.description == "column")
        #expect(Connection.LimitCategory.exprDepth.description == "expression depth")
        #expect(Connection.LimitCategory.compoundSelect.description == "compound select")
        #expect(Connection.LimitCategory.vdbeOp.description == "vdbe op")
        #expect(Connection.LimitCategory.functionArg.description == "function arg")
        #expect(Connection.LimitCategory.attached.description == "attached")
        #expect(Connection.LimitCategory.likePatternLength.description == "like pattern length")
        #expect(Connection.LimitCategory.variableNumber.description == "variable number")
        #expect(Connection.LimitCategory.triggerDepth.description == "trigger depth")
        #expect(Connection.LimitCategory.workerThreads.description == "worker threads")
        #expect(Connection.LimitCategory(rawValue: -3).description == "unknown")
        #expect(Connection.LimitCategory.length.debugDescription == "SQLITE_LIMIT_LENGTH")
        #expect(Connection.LimitCategory(rawValue: -3).debugDescription == "-3")
    }

    @Test("limit and setLimit round-trip values")
    func limitAndSetLimitRoundTripValues() {
        let current = connection.limit(for: .length)
        let previous = connection.setLimit(current, for: .length)
        #expect(previous == current)
        #expect(connection.limit(for: .length) == current)
    }
}
