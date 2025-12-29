import LSQLite
import Testing

@Suite("Connection+ProgressHandler")
final class ConnectionProgressHandlerResultRawValueTests {
    private let connection: Connection

    init() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        self.connection = connection
    }

    deinit {
        _ = connection.close()
    }

    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(8)
        let result = Connection.ProgressHandlerResult(rawValue: rawValue)
        #expect(result.rawValue == rawValue)
    }

    @Test("ProgressHandlerResult descriptions map values")
    func progressHandlerResultDescriptions() {
        #expect(Connection.ProgressHandlerResult.continue.description == "continue")
        #expect(Connection.ProgressHandlerResult.interrupt.description == "interrupt")
        #expect(Connection.ProgressHandlerResult(rawValue: 2).description == "unknown")
        #expect(Connection.ProgressHandlerResult.continue.debugDescription == "continue (0)")
        #expect(Connection.ProgressHandlerResult(rawValue: 2).debugDescription == "unknown (2)")
    }

    @Test("setProgressHandler registers handler")
    func setProgressHandlerRegistersHandler() {
        connection.setProgressHandler(instructionCount: 10, handler: progressHandler)
        connection.setProgressHandler(instructionCount: 0, handler: nil)
    }
}

private func progressHandler(_ userData: UnsafeMutableRawPointer?) -> Int32 {
    Connection.ProgressHandlerResult.continue.rawValue
}
