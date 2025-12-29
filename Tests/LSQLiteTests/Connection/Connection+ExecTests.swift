import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Connection+Exec")
final class ConnectionExecCallbackResultRawValueTests {
    private let connection: Connection

    init() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        self.connection = connection
        try #require(connection.exec("CREATE TABLE items(id INTEGER)") == .ok)
        try #require(connection.exec("INSERT INTO items(id) VALUES (1), (2)") == .ok)
    }

    deinit {
        _ = connection.close()
    }

    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(4)
        let callbackResult = Connection.ExecCallbackResult(rawValue: rawValue)
        #expect(callbackResult.rawValue == rawValue)
    }

    @Test("ExecCallbackResult descriptions map values")
    func execCallbackResultDescriptions() {
        #expect(Connection.ExecCallbackResult.continue.description == "continue")
        #expect(Connection.ExecCallbackResult.abort.description == "abort")
        #expect(Connection.ExecCallbackResult(rawValue: 9).description == "unknown")
        #expect(Connection.ExecCallbackResult.continue.debugDescription == "continue (0)")
        #expect(Connection.ExecCallbackResult(rawValue: 9).debugDescription == "unknown (9)")
    }

    @Test("exec invokes callback for rows")
    func execInvokesCallbackForRows() throws {
        var rowCount = Int32(0)
        let result = connection.exec("SELECT id FROM items ORDER BY id", userData: &rowCount, callback: execRowCounter)
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
        #expect(connection.exec("SELECT * FROM missing_table", errorMessage: &errorMessage) == .error)
        #expect(errorMessage != nil)
    }
}

private func execRowCounter(_ userData: UnsafeMutableRawPointer?, _ count: Int32, _ values: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>?, _ columns: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>?) -> Int32 {
    guard let userData else {
        return Connection.ExecCallbackResult.abort.rawValue
    }
    let rowCount = userData.assumingMemoryBound(to: Int32.self)
    rowCount.pointee += 1
    return Connection.ExecCallbackResult.continue.rawValue
}
