import LSQLite
import Testing

@Suite("Database+ProgressHandler")
struct DatabaseProgressHandlerResultRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(8)
        let result = Database.ProgressHandlerResult(rawValue: rawValue)
        #expect(result.rawValue == rawValue)
    }
}
