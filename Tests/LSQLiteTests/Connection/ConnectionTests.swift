import LSQLite
import Testing

@Suite("Connection")
struct ConnectionRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = OpaquePointer(bitPattern: 0x1)!
        let connection = Connection(rawValue: rawValue)
        #expect(connection.rawValue == rawValue)
    }
}
