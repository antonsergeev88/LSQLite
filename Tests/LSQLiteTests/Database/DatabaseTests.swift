import LSQLite
import Testing

@Suite("Database")
struct DatabaseRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = OpaquePointer(bitPattern: 0x1)!
        let database = Database(rawValue: rawValue)
        #expect(database.rawValue == rawValue)
    }
}
