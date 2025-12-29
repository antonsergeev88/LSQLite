import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Connection+Hooks")
final class ConnectionHooksTests {
    private let connection: Connection

    init() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        self.connection = connection
        try #require(connection.exec("CREATE TABLE hooks(id INTEGER)") == .ok)
    }

    deinit {
        _ = connection.close()
    }

    @Test("CommitHookHandlerResult init(rawValue:) preserves rawValue")
    func commitHookHandlerResultRawValueRoundTrip() {
        let rawValue = Int32(6)
        let result = Connection.CommitHookHandlerResult(rawValue: rawValue)
        #expect(result.rawValue == rawValue)
    }

    @Test("UpdateOperation init(rawValue:) preserves rawValue")
    func updateOperationRawValueRoundTrip() {
        let rawValue = Int32(7)
        let operation = Connection.UpdateOperation(rawValue: rawValue)
        #expect(operation.rawValue == rawValue)
    }

    @Test("UpdateOperation constants match SQLite")
    func updateOperationConstantsMatchSQLite() {
        #expect(Connection.UpdateOperation.delete.rawValue == SQLITE_DELETE)
        #expect(Connection.UpdateOperation.insert.rawValue == SQLITE_INSERT)
        #expect(Connection.UpdateOperation.update.rawValue == SQLITE_UPDATE)
    }

    @Test("hook result and operation descriptions map values")
    func hookDescriptionsMapValues() {
        let commitContinue = Connection.CommitHookHandlerResult.continue
        #expect(!commitContinue.description.isEmpty)
        #expect(commitContinue.debugDescription.contains(commitContinue.description))

        let commitUnknown = Connection.CommitHookHandlerResult(rawValue: 9)
        #expect(!commitUnknown.description.isEmpty)
        #expect(commitUnknown.debugDescription.contains("9"))

        let updateDelete = Connection.UpdateOperation.delete
        #expect(!updateDelete.description.isEmpty)
        #expect(updateDelete.debugDescription.contains("SQLITE_DELETE"))

        let updateUnknown = Connection.UpdateOperation(rawValue: 999)
        #expect(!updateUnknown.description.isEmpty)
        #expect(updateUnknown.debugDescription.contains("999"))
    }

    @Test("commit, rollback, update, and WAL hooks register and run")
    func hooksRegisterAndRun() throws {
        var probe = HookProbe()
        _ = connection.commitHook(&probe, commitHookHandler: commitHook)
        _ = connection.rollbackHook(&probe, rollbackHookHandler: rollbackHook)
        _ = connection.updateHook(&probe, updateHookHandler: updateHook)
        _ = connection.walHook(&probe, walHookHandler: walHook)

        try #require(connection.exec("BEGIN") == .ok)
        try #require(connection.exec("INSERT INTO hooks(id) VALUES (1)") == .ok)
        try #require(connection.exec("COMMIT") == .ok)

        #expect(probe.commitCalls == 1)
        #expect(probe.updateCalls == 1)
        #expect(probe.lastUpdateOperation == Connection.UpdateOperation.insert.rawValue)

        try #require(connection.exec("BEGIN") == .ok)
        try #require(connection.exec("ROLLBACK") == .ok)
        #expect(probe.rollbackCalls == 1)
    }
}

private struct HookProbe {
    var commitCalls: Int32 = 0
    var rollbackCalls: Int32 = 0
    var updateCalls: Int32 = 0
    var walCalls: Int32 = 0
    var lastUpdateOperation: Int32 = 0
}

private func commitHook(_ userData: UnsafeMutableRawPointer?) -> Int32 {
    guard let userData else {
        return Connection.CommitHookHandlerResult.break.rawValue
    }
    let probe = userData.assumingMemoryBound(to: HookProbe.self)
    probe.pointee.commitCalls += 1
    return Connection.CommitHookHandlerResult.continue.rawValue
}

private func rollbackHook(_ userData: UnsafeMutableRawPointer?) {
    guard let userData else {
        return
    }
    let probe = userData.assumingMemoryBound(to: HookProbe.self)
    probe.pointee.rollbackCalls += 1
}

private func updateHook(_ userData: UnsafeMutableRawPointer?, _ updateOperation: Int32, _ databaseName: UnsafePointer<Int8>?, _ tableName: UnsafePointer<Int8>?, _ rowID: Int64) {
    guard let userData else {
        return
    }
    let probe = userData.assumingMemoryBound(to: HookProbe.self)
    probe.pointee.updateCalls += 1
    probe.pointee.lastUpdateOperation = updateOperation
}

private func walHook(_ userData: UnsafeMutableRawPointer?, _ connection: OpaquePointer?, _ databaseName: UnsafePointer<Int8>?, _ pageInWALFileCount: Int32) -> Int32 {
    guard let userData else {
        return 0
    }
    let probe = userData.assumingMemoryBound(to: HookProbe.self)
    probe.pointee.walCalls += 1
    return 0
}
