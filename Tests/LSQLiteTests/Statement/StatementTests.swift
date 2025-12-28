import LSQLite
import Testing

@Suite("Statement")
struct StatementRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = OpaquePointer(bitPattern: 0x2)!
        let statement = Statement(rawValue: rawValue)
        #expect(statement.rawValue == rawValue)
    }
}
