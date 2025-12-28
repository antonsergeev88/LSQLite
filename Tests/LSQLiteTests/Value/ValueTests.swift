import LSQLite
import Testing

@Suite("Value")
struct ValueRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = OpaquePointer(bitPattern: 0x4)!
        let value = Value(rawValue: rawValue)
        #expect(value.rawValue == rawValue)
    }
}
