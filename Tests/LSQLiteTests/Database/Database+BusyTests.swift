import LSQLite
import Testing

@Suite("Database+Busy")
final class DatabaseBusyHandlerResultRawValueTests {
    private let database: Database

    init() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        self.database = try #require(database)
    }

    deinit {
        _ = database.close()
    }

    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(17)
        let busyHandlerResult = Database.BusyHandlerResult(rawValue: rawValue)
        #expect(busyHandlerResult.rawValue == rawValue)
    }

    @Test("BusyHandlerResult descriptions map values")
    func busyHandlerResultDescriptions() {
        #expect(Database.BusyHandlerResult.break.description == "break")
        #expect(Database.BusyHandlerResult.continue.description == "continue")
        #expect(Database.BusyHandlerResult(rawValue: 99).description == "unknown")
        #expect(Database.BusyHandlerResult.break.debugDescription == "break (0)")
        #expect(Database.BusyHandlerResult(rawValue: 99).debugDescription == "unknown (99)")
    }

    @Test("setBusyHandler registers and clears handler")
    func setBusyHandlerRegistersAndClearsHandler() {
        #expect(database.setBusyHandler(busyHandler) == .ok)
        database.setTimerBusyHandler(milliseconds: 1)
        #expect(database.setBusyHandler(userData: nil, nil) == .ok)
    }
}

private func busyHandler(_ userData: UnsafeMutableRawPointer?, _ attempt: Int32) -> Int32 {
    Database.BusyHandlerResult.break.rawValue
}
