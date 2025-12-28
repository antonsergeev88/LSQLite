import LSQLite
import Testing

@Suite("Database+Exec")
struct DatabaseExecCallbackResultRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(4)
        let callbackResult = Database.ExecCallbackResult(rawValue: rawValue)
        #expect(callbackResult.rawValue == rawValue)
    }
}
