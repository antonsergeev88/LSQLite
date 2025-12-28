import LSQLite
import Testing

@Suite("Context+Database")
struct ContextDatabaseTests {
    @Test("database returns function connection")
    func databaseReturnsFunctionConnection() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)

        var probe = ContextDatabaseProbe()
        #expect(openDatabase.createFunction(name: "ctx_db", argumentCount: 0, textEncoding: .utf8, userData: &probe, funcHandler: contextDatabaseHandler) == .ok)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT ctx_db()", for: openDatabase) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.step() == .row)
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)

        #expect(probe.databasePointer == openDatabase.rawValue)
        _ = openDatabase.close()
    }
}

private struct ContextDatabaseProbe {
    var databasePointer: OpaquePointer?
}

private func contextDatabaseHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else {
        return
    }
    let contextWrapper = Context(rawValue: context)
    if let userData = contextWrapper.userData {
        let probe = userData.assumingMemoryBound(to: ContextDatabaseProbe.self)
        probe.pointee.databasePointer = contextWrapper.database?.rawValue
    }
    contextWrapper.resultInt(1)
}
