import LSQLite
import Testing

@Suite("Context")
struct ContextRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = OpaquePointer(bitPattern: 0x5)!
        let context = Context(rawValue: rawValue)
        #expect(context.rawValue == rawValue)
    }
}
