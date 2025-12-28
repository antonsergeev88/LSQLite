import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Database+Authorizer")
struct DatabaseAuthorizerTests {
    @Test("AuthorizerHandlerResult init(rawValue:) preserves rawValue")
    func authorizerHandlerResultRawValueRoundTrip() {
        let rawValue = Int32(8)
        let result = Database.AuthorizerHandlerResult(rawValue: rawValue)
        #expect(result.rawValue == rawValue)
    }

    @Test("AuthorizerHandlerActionCode init(rawValue:) preserves rawValue")
    func authorizerHandlerActionCodeRawValueRoundTrip() {
        let rawValue = Int32(9)
        let actionCode = Database.AuthorizerHandlerActionCode(rawValue: rawValue)
        #expect(actionCode.rawValue == rawValue)
    }

    @Test("AuthorizerHandlerResult constants match SQLite")
    func authorizerHandlerResultConstantsMatchSQLite() {
        #expect(Database.AuthorizerHandlerResult.ok.rawValue == SQLITE_OK)
        #expect(Database.AuthorizerHandlerResult.deny.rawValue == SQLITE_DENY)
        #expect(Database.AuthorizerHandlerResult.ignore.rawValue == SQLITE_IGNORE)
    }

    @Test("AuthorizerHandlerActionCode constants match SQLite")
    func authorizerHandlerActionCodeConstantsMatchSQLite() {
        #expect(Database.AuthorizerHandlerActionCode.createIndex.rawValue == SQLITE_CREATE_INDEX)
        #expect(Database.AuthorizerHandlerActionCode.createTable.rawValue == SQLITE_CREATE_TABLE)
        #expect(Database.AuthorizerHandlerActionCode.createTempIndex.rawValue == SQLITE_CREATE_TEMP_INDEX)
        #expect(Database.AuthorizerHandlerActionCode.createTempTable.rawValue == SQLITE_CREATE_TEMP_TABLE)
        #expect(Database.AuthorizerHandlerActionCode.createTempTrigger.rawValue == SQLITE_CREATE_TEMP_TRIGGER)
        #expect(Database.AuthorizerHandlerActionCode.createTempView.rawValue == SQLITE_CREATE_TEMP_VIEW)
        #expect(Database.AuthorizerHandlerActionCode.createTrigger.rawValue == SQLITE_CREATE_TRIGGER)
        #expect(Database.AuthorizerHandlerActionCode.createView.rawValue == SQLITE_CREATE_VIEW)
        #expect(Database.AuthorizerHandlerActionCode.delete.rawValue == SQLITE_DELETE)
        #expect(Database.AuthorizerHandlerActionCode.dropIndex.rawValue == SQLITE_DROP_INDEX)
        #expect(Database.AuthorizerHandlerActionCode.dropTable.rawValue == SQLITE_DROP_TABLE)
        #expect(Database.AuthorizerHandlerActionCode.dropTempIndex.rawValue == SQLITE_DROP_TEMP_INDEX)
        #expect(Database.AuthorizerHandlerActionCode.dropTempTable.rawValue == SQLITE_DROP_TEMP_TABLE)
        #expect(Database.AuthorizerHandlerActionCode.dropTempTrigger.rawValue == SQLITE_DROP_TEMP_TRIGGER)
        #expect(Database.AuthorizerHandlerActionCode.dropTempView.rawValue == SQLITE_DROP_TEMP_VIEW)
        #expect(Database.AuthorizerHandlerActionCode.dropTrigger.rawValue == SQLITE_DROP_TRIGGER)
        #expect(Database.AuthorizerHandlerActionCode.dropView.rawValue == SQLITE_DROP_VIEW)
        #expect(Database.AuthorizerHandlerActionCode.insert.rawValue == SQLITE_INSERT)
        #expect(Database.AuthorizerHandlerActionCode.pragma.rawValue == SQLITE_PRAGMA)
        #expect(Database.AuthorizerHandlerActionCode.read.rawValue == SQLITE_READ)
        #expect(Database.AuthorizerHandlerActionCode.select.rawValue == SQLITE_SELECT)
        #expect(Database.AuthorizerHandlerActionCode.transaction.rawValue == SQLITE_TRANSACTION)
        #expect(Database.AuthorizerHandlerActionCode.update.rawValue == SQLITE_UPDATE)
        #expect(Database.AuthorizerHandlerActionCode.attach.rawValue == SQLITE_ATTACH)
        #expect(Database.AuthorizerHandlerActionCode.detach.rawValue == SQLITE_DETACH)
        #expect(Database.AuthorizerHandlerActionCode.alterTable.rawValue == SQLITE_ALTER_TABLE)
        #expect(Database.AuthorizerHandlerActionCode.reindex.rawValue == SQLITE_REINDEX)
        #expect(Database.AuthorizerHandlerActionCode.analyze.rawValue == SQLITE_ANALYZE)
        #expect(Database.AuthorizerHandlerActionCode.createVTable.rawValue == SQLITE_CREATE_VTABLE)
        #expect(Database.AuthorizerHandlerActionCode.dropVTable.rawValue == SQLITE_DROP_VTABLE)
        #expect(Database.AuthorizerHandlerActionCode.function.rawValue == SQLITE_FUNCTION)
        #expect(Database.AuthorizerHandlerActionCode.savepoint.rawValue == SQLITE_SAVEPOINT)
        #expect(Database.AuthorizerHandlerActionCode.copy.rawValue == SQLITE_COPY)
        #expect(Database.AuthorizerHandlerActionCode.recursive.rawValue == SQLITE_RECURSIVE)
    }
}
