import LSQLite
import Testing

@Suite("Blob")
struct BlobRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = OpaquePointer(bitPattern: 0x3)!
        let blob = Blob(rawValue: rawValue)
        #expect(blob.rawValue == rawValue)
    }
}
