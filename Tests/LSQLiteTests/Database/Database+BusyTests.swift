import LSQLite
import Testing

@Suite("Database+Busy")
struct DatabaseBusyHandlerResultRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(17)
        let busyHandlerResult = Database.BusyHandlerResult(rawValue: rawValue)
        #expect(busyHandlerResult.rawValue == rawValue)
    }
}
