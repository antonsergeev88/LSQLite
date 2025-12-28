import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Database+Limit")
struct DatabaseLimitCategoryRawValueTests {
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
}
