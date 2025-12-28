import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Database+Hooks")
final class DatabaseHooksTests {
    private let database: Database

    init() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)
        self.database = openDatabase
        try #require(openDatabase.exec("CREATE TABLE hooks(id INTEGER)") == .ok)
    }

    deinit {
        _ = database.close()
    }

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

    @Test("hook result and operation descriptions map values")
    func hookDescriptionsMapValues() {
        let commitContinue = Database.CommitHookHandlerResult.continue
        #expect(!commitContinue.description.isEmpty)
        #expect(commitContinue.debugDescription.contains(commitContinue.description))

        let commitUnknown = Database.CommitHookHandlerResult(rawValue: 9)
        #expect(!commitUnknown.description.isEmpty)
        #expect(commitUnknown.debugDescription.contains("9"))

        let updateDelete = Database.UpdateOperation.delete
        #expect(!updateDelete.description.isEmpty)
        #expect(updateDelete.debugDescription.contains("SQLITE_DELETE"))

        let updateUnknown = Database.UpdateOperation(rawValue: 999)
        #expect(!updateUnknown.description.isEmpty)
        #expect(updateUnknown.debugDescription.contains("999"))
    }

    @Test("commit, rollback, update, and WAL hooks register and run")
    func hooksRegisterAndRun() throws {
        var probe = HookProbe()
        _ = database.commitHook(&probe, commitHookHandler: commitHook)
        _ = database.rollbackHook(&probe, rollbackHookHandler: rollbackHook)
        _ = database.updateHook(&probe, updateHookHandler: updateHook)
        _ = database.walHook(&probe, walHookHandler: walHook)

        try #require(database.exec("BEGIN") == .ok)
        try #require(database.exec("INSERT INTO hooks(id) VALUES (1)") == .ok)
        try #require(database.exec("COMMIT") == .ok)

        #expect(probe.commitCalls == 1)
        #expect(probe.updateCalls == 1)
        #expect(probe.lastUpdateOperation == Database.UpdateOperation.insert.rawValue)

        try #require(database.exec("BEGIN") == .ok)
        try #require(database.exec("ROLLBACK") == .ok)
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
        return Database.CommitHookHandlerResult.break.rawValue
    }
    let probe = userData.assumingMemoryBound(to: HookProbe.self)
    probe.pointee.commitCalls += 1
    return Database.CommitHookHandlerResult.continue.rawValue
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

private func walHook(_ userData: UnsafeMutableRawPointer?, _ database: OpaquePointer?, _ databaseName: UnsafePointer<Int8>?, _ pageInWALFileCount: Int32) -> Int32 {
    guard let userData else {
        return 0
    }
    let probe = userData.assumingMemoryBound(to: HookProbe.self)
    probe.pointee.walCalls += 1
    return 0
}
