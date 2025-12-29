import LSQLite
import Testing

@Suite("Connection+Busy")
final class ConnectionBusyHandlerResultRawValueTests {
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
        let rawValue = Int32(17)
        let busyHandlerResult = Connection.BusyHandlerResult(rawValue: rawValue)
        #expect(busyHandlerResult.rawValue == rawValue)
    }

    @Test("BusyHandlerResult descriptions map values")
    func busyHandlerResultDescriptions() {
        #expect(Connection.BusyHandlerResult.break.description == "break")
        #expect(Connection.BusyHandlerResult.continue.description == "continue")
        #expect(Connection.BusyHandlerResult(rawValue: 99).description == "unknown")
        #expect(Connection.BusyHandlerResult.break.debugDescription == "break (0)")
        #expect(Connection.BusyHandlerResult(rawValue: 99).debugDescription == "unknown (99)")
    }

    @Test("setBusyHandler registers and clears handler")
    func setBusyHandlerRegistersAndClearsHandler() {
        #expect(connection.setBusyHandler(busyHandler) == .ok)
        connection.setTimerBusyHandler(milliseconds: 1)
        #expect(connection.setBusyHandler(userData: nil, nil) == .ok)
    }
}

private func busyHandler(_ userData: UnsafeMutableRawPointer?, _ attempt: Int32) -> Int32 {
    Connection.BusyHandlerResult.break.rawValue
}
