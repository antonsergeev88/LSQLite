import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Connection+Authorizer")
struct ConnectionAuthorizerTests {
    @Test("AuthorizerHandlerResult init(rawValue:) preserves rawValue")
    func authorizerHandlerResultRawValueRoundTrip() {
        let rawValue = Int32(8)
        let result = Connection.AuthorizerHandlerResult(rawValue: rawValue)
        #expect(result.rawValue == rawValue)
    }

    @Test("AuthorizerHandlerActionCode init(rawValue:) preserves rawValue")
    func authorizerHandlerActionCodeRawValueRoundTrip() {
        let rawValue = Int32(9)
        let actionCode = Connection.AuthorizerHandlerActionCode(rawValue: rawValue)
        #expect(actionCode.rawValue == rawValue)
    }

    @Test("AuthorizerHandlerResult constants match SQLite")
    func authorizerHandlerResultConstantsMatchSQLite() {
        #expect(Connection.AuthorizerHandlerResult.ok.rawValue == SQLITE_OK)
        #expect(Connection.AuthorizerHandlerResult.deny.rawValue == SQLITE_DENY)
        #expect(Connection.AuthorizerHandlerResult.ignore.rawValue == SQLITE_IGNORE)
    }

    @Test("AuthorizerHandlerActionCode constants match SQLite")
    func authorizerHandlerActionCodeConstantsMatchSQLite() {
        #expect(Connection.AuthorizerHandlerActionCode.createIndex.rawValue == SQLITE_CREATE_INDEX)
        #expect(Connection.AuthorizerHandlerActionCode.createTable.rawValue == SQLITE_CREATE_TABLE)
        #expect(Connection.AuthorizerHandlerActionCode.createTempIndex.rawValue == SQLITE_CREATE_TEMP_INDEX)
        #expect(Connection.AuthorizerHandlerActionCode.createTempTable.rawValue == SQLITE_CREATE_TEMP_TABLE)
        #expect(Connection.AuthorizerHandlerActionCode.createTempTrigger.rawValue == SQLITE_CREATE_TEMP_TRIGGER)
        #expect(Connection.AuthorizerHandlerActionCode.createTempView.rawValue == SQLITE_CREATE_TEMP_VIEW)
        #expect(Connection.AuthorizerHandlerActionCode.createTrigger.rawValue == SQLITE_CREATE_TRIGGER)
        #expect(Connection.AuthorizerHandlerActionCode.createView.rawValue == SQLITE_CREATE_VIEW)
        #expect(Connection.AuthorizerHandlerActionCode.delete.rawValue == SQLITE_DELETE)
        #expect(Connection.AuthorizerHandlerActionCode.dropIndex.rawValue == SQLITE_DROP_INDEX)
        #expect(Connection.AuthorizerHandlerActionCode.dropTable.rawValue == SQLITE_DROP_TABLE)
        #expect(Connection.AuthorizerHandlerActionCode.dropTempIndex.rawValue == SQLITE_DROP_TEMP_INDEX)
        #expect(Connection.AuthorizerHandlerActionCode.dropTempTable.rawValue == SQLITE_DROP_TEMP_TABLE)
        #expect(Connection.AuthorizerHandlerActionCode.dropTempTrigger.rawValue == SQLITE_DROP_TEMP_TRIGGER)
        #expect(Connection.AuthorizerHandlerActionCode.dropTempView.rawValue == SQLITE_DROP_TEMP_VIEW)
        #expect(Connection.AuthorizerHandlerActionCode.dropTrigger.rawValue == SQLITE_DROP_TRIGGER)
        #expect(Connection.AuthorizerHandlerActionCode.dropView.rawValue == SQLITE_DROP_VIEW)
        #expect(Connection.AuthorizerHandlerActionCode.insert.rawValue == SQLITE_INSERT)
        #expect(Connection.AuthorizerHandlerActionCode.pragma.rawValue == SQLITE_PRAGMA)
        #expect(Connection.AuthorizerHandlerActionCode.read.rawValue == SQLITE_READ)
        #expect(Connection.AuthorizerHandlerActionCode.select.rawValue == SQLITE_SELECT)
        #expect(Connection.AuthorizerHandlerActionCode.transaction.rawValue == SQLITE_TRANSACTION)
        #expect(Connection.AuthorizerHandlerActionCode.update.rawValue == SQLITE_UPDATE)
        #expect(Connection.AuthorizerHandlerActionCode.attach.rawValue == SQLITE_ATTACH)
        #expect(Connection.AuthorizerHandlerActionCode.detach.rawValue == SQLITE_DETACH)
        #expect(Connection.AuthorizerHandlerActionCode.alterTable.rawValue == SQLITE_ALTER_TABLE)
        #expect(Connection.AuthorizerHandlerActionCode.reindex.rawValue == SQLITE_REINDEX)
        #expect(Connection.AuthorizerHandlerActionCode.analyze.rawValue == SQLITE_ANALYZE)
        #expect(Connection.AuthorizerHandlerActionCode.createVTable.rawValue == SQLITE_CREATE_VTABLE)
        #expect(Connection.AuthorizerHandlerActionCode.dropVTable.rawValue == SQLITE_DROP_VTABLE)
        #expect(Connection.AuthorizerHandlerActionCode.function.rawValue == SQLITE_FUNCTION)
        #expect(Connection.AuthorizerHandlerActionCode.savepoint.rawValue == SQLITE_SAVEPOINT)
        #expect(Connection.AuthorizerHandlerActionCode.copy.rawValue == SQLITE_COPY)
        #expect(Connection.AuthorizerHandlerActionCode.recursive.rawValue == SQLITE_RECURSIVE)
    }

    @Test("AuthorizerHandlerResult descriptions map values")
    func authorizerHandlerResultDescriptions() {
        #expect(Connection.AuthorizerHandlerResult.ok.description == "ok")
        #expect(Connection.AuthorizerHandlerResult.deny.description == "deny")
        #expect(Connection.AuthorizerHandlerResult.ignore.description == "ignore")
        #expect(Connection.AuthorizerHandlerResult(rawValue: 77).description == "unknown")
        #expect(Connection.AuthorizerHandlerResult.ok.debugDescription == "SQLITE_OK")
        #expect(Connection.AuthorizerHandlerResult(rawValue: 77).debugDescription == "77")
    }

    @Test("AuthorizerHandlerActionCode descriptions map values")
    func authorizerHandlerActionCodeDescriptions() {
        #expect(Connection.AuthorizerHandlerActionCode.createIndex.description == "create index")
        #expect(Connection.AuthorizerHandlerActionCode.dropTable.description == "drop table")
        #expect(Connection.AuthorizerHandlerActionCode.select.description == "select")
        #expect(Connection.AuthorizerHandlerActionCode(rawValue: -1).description == "unknown")
        #expect(Connection.AuthorizerHandlerActionCode.createIndex.debugDescription == "SQLITE_CREATE_INDEX")
        #expect(Connection.AuthorizerHandlerActionCode(rawValue: -1).debugDescription == "-1")
    }

    @Test("setAuthorizerHandler registers callback")
    func setAuthorizerHandlerRegistersCallback() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        try #require(connection.exec("CREATE TABLE auth(id INTEGER)") == .ok)

        var probe = AuthorizerProbe()
        #expect(connection.setAuthorizerHandler(userData: &probe, authorizerHandler) == .ok)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT id FROM auth", for: connection) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.finalize() == .ok)

        #expect(probe.called)
        #expect(connection.setAuthorizerHandler(userData: nil, nil) == .ok)
        _ = connection.close()
    }
}

private struct AuthorizerProbe {
    var called = false
}

private func authorizerHandler(_ userData: UnsafeMutableRawPointer?, _ actionCode: Int32, _ detail1: UnsafePointer<Int8>?, _ detail2: UnsafePointer<Int8>?, _ databaseName: UnsafePointer<Int8>?, _ triggerOrViewName: UnsafePointer<Int8>?) -> Int32 {
    guard let userData else {
        return Connection.AuthorizerHandlerResult.ok.rawValue
    }
    let probe = userData.assumingMemoryBound(to: AuthorizerProbe.self)
    probe.pointee.called = true
    return Connection.AuthorizerHandlerResult.ok.rawValue
}
