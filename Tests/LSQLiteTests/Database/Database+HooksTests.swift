import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Database+Hooks")
struct DatabaseHooksTests {
    @Test("CommitHookHandlerResult init(rawValue:) preserves rawValue")
    func commitHookHandlerResultRawValueRoundTrip() {
        let rawValue = Int32(6)
        let result = Database.CommitHookHandlerResult(rawValue: rawValue)
        #expect(result.rawValue == rawValue)
    }

    @Test("UpdateOperation init(rawValue:) preserves rawValue")
    func updateOperationRawValueRoundTrip() {
        let rawValue = Int32(7)
        let operation = Database.UpdateOperation(rawValue: rawValue)
        #expect(operation.rawValue == rawValue)
    }

    @Test("UpdateOperation constants match SQLite")
    func updateOperationConstantsMatchSQLite() {
        #expect(Database.UpdateOperation.delete.rawValue == SQLITE_DELETE)
        #expect(Database.UpdateOperation.insert.rawValue == SQLITE_INSERT)
        #expect(Database.UpdateOperation.update.rawValue == SQLITE_UPDATE)
    }
}
