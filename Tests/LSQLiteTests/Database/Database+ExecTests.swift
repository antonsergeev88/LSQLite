import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Database+Exec")
final class DatabaseExecCallbackResultRawValueTests {
    private let database: Database

    init() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)
        self.database = openDatabase
        try #require(openDatabase.exec("CREATE TABLE items(id INTEGER)") == .ok)
        try #require(openDatabase.exec("INSERT INTO items(id) VALUES (1), (2)") == .ok)
    }

    deinit {
        _ = database.close()
    }

    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(4)
        let callbackResult = Database.ExecCallbackResult(rawValue: rawValue)
        #expect(callbackResult.rawValue == rawValue)
    }

    @Test("ExecCallbackResult descriptions map values")
    func execCallbackResultDescriptions() {
        #expect(Database.ExecCallbackResult.continue.description == "continue")
        #expect(Database.ExecCallbackResult.abort.description == "abort")
        #expect(Database.ExecCallbackResult(rawValue: 9).description == "unknown")
        #expect(Database.ExecCallbackResult.continue.debugDescription == "continue (0)")
        #expect(Database.ExecCallbackResult(rawValue: 9).debugDescription == "unknown (9)")
    }

    @Test("exec invokes callback for rows")
    func execInvokesCallbackForRows() throws {
        var rowCount = Int32(0)
        let result = database.exec("SELECT id FROM items ORDER BY id", userData: &rowCount, callback: execRowCounter)
        #expect(result == .ok)
        #expect(rowCount == 2)
    }

    @Test("exec captures error messages")
    func execCapturesErrorMessages() {
        var errorMessage: UnsafeMutablePointer<Int8>? = nil
        defer {
            if let errorMessage {
                sqlite3_free(errorMessage)
            }
        }
        #expect(database.exec("SELECT * FROM missing_table", errorMessage: &errorMessage) == .error)
        #expect(errorMessage != nil)
    }
}

private func execRowCounter(_ userData: UnsafeMutableRawPointer?, _ count: Int32, _ values: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>?, _ columns: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>?) -> Int32 {
    guard let userData else {
        return Database.ExecCallbackResult.abort.rawValue
    }
    let rowCount = userData.assumingMemoryBound(to: Int32.self)
    rowCount.pointee += 1
    return Database.ExecCallbackResult.continue.rawValue
}
