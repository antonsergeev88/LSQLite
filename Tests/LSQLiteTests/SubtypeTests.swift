import LSQLite
import Testing

@Suite("Subtype")
struct SubtypeRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = UInt32(255)
        let subtype = Subtype(rawValue: rawValue)
        #expect(subtype.rawValue == rawValue)
    }
}
