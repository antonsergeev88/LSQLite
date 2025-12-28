import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Database+Limit")
final class DatabaseLimitCategoryRawValueTests {
    private let database: Database

    init() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        self.database = try #require(database)
    }

    deinit {
        _ = database.close()
    }

    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(5)
        let category = Database.LimitCategory(rawValue: rawValue)
        #expect(category.rawValue == rawValue)
    }

    @Test("LimitCategory constants match SQLite")
    func limitCategoryConstantsMatchSQLite() {
        #expect(Database.LimitCategory.length.rawValue == SQLITE_LIMIT_LENGTH)
        #expect(Database.LimitCategory.sqlLength.rawValue == SQLITE_LIMIT_SQL_LENGTH)
        #expect(Database.LimitCategory.column.rawValue == SQLITE_LIMIT_COLUMN)
        #expect(Database.LimitCategory.exprDepth.rawValue == SQLITE_LIMIT_EXPR_DEPTH)
        #expect(Database.LimitCategory.compoundSelect.rawValue == SQLITE_LIMIT_COMPOUND_SELECT)
        #expect(Database.LimitCategory.vdbeOp.rawValue == SQLITE_LIMIT_VDBE_OP)
        #expect(Database.LimitCategory.functionArg.rawValue == SQLITE_LIMIT_FUNCTION_ARG)
        #expect(Database.LimitCategory.attached.rawValue == SQLITE_LIMIT_ATTACHED)
        #expect(Database.LimitCategory.likePatternLength.rawValue == SQLITE_LIMIT_LIKE_PATTERN_LENGTH)
        #expect(Database.LimitCategory.variableNumber.rawValue == SQLITE_LIMIT_VARIABLE_NUMBER)
        #expect(Database.LimitCategory.triggerDepth.rawValue == SQLITE_LIMIT_TRIGGER_DEPTH)
        #expect(Database.LimitCategory.workerThreads.rawValue == SQLITE_LIMIT_WORKER_THREADS)
    }

    @Test("LimitCategory descriptions map values")
    func limitCategoryDescriptions() {
        #expect(Database.LimitCategory.length.description == "length")
        #expect(Database.LimitCategory.sqlLength.description == "sql length")
        #expect(Database.LimitCategory.column.description == "column")
        #expect(Database.LimitCategory.exprDepth.description == "expression depth")
        #expect(Database.LimitCategory.compoundSelect.description == "compound select")
        #expect(Database.LimitCategory.vdbeOp.description == "vdbe op")
        #expect(Database.LimitCategory.functionArg.description == "function arg")
        #expect(Database.LimitCategory.attached.description == "attached")
        #expect(Database.LimitCategory.likePatternLength.description == "like pattern length")
        #expect(Database.LimitCategory.variableNumber.description == "variable number")
        #expect(Database.LimitCategory.triggerDepth.description == "trigger depth")
        #expect(Database.LimitCategory.workerThreads.description == "worker threads")
        #expect(Database.LimitCategory(rawValue: -3).description == "unknown")
        #expect(Database.LimitCategory.length.debugDescription == "SQLITE_LIMIT_LENGTH")
        #expect(Database.LimitCategory(rawValue: -3).debugDescription == "-3")
    }

    @Test("limit and setLimit round-trip values")
    func limitAndSetLimitRoundTripValues() {
        let current = database.limit(for: .length)
        let previous = database.setLimit(current, for: .length)
        #expect(previous == current)
        #expect(database.limit(for: .length) == current)
    }
}
