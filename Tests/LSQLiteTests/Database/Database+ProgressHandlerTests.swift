import LSQLite
import Testing

@Suite("Database+ProgressHandler")
final class DatabaseProgressHandlerResultRawValueTests {
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
        let rawValue = Int32(8)
        let result = Database.ProgressHandlerResult(rawValue: rawValue)
        #expect(result.rawValue == rawValue)
    }

    @Test("ProgressHandlerResult descriptions map values")
    func progressHandlerResultDescriptions() {
        #expect(Database.ProgressHandlerResult.continue.description == "continue")
        #expect(Database.ProgressHandlerResult.interrupt.description == "interrupt")
        #expect(Database.ProgressHandlerResult(rawValue: 2).description == "unknown")
        #expect(Database.ProgressHandlerResult.continue.debugDescription == "continue (0)")
        #expect(Database.ProgressHandlerResult(rawValue: 2).debugDescription == "unknown (2)")
    }

    @Test("setProgressHandler registers handler")
    func setProgressHandlerRegistersHandler() {
        database.setProgressHandler(instructionCount: 10, handler: progressHandler)
        database.setProgressHandler(instructionCount: 0, handler: nil)
    }
}

private func progressHandler(_ userData: UnsafeMutableRawPointer?) -> Int32 {
    Database.ProgressHandlerResult.continue.rawValue
}
