import LSQLite
import Testing

@Suite("Database+Blob")
struct DatabaseOpenBlobFlagRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(2)
        let openBlobFlag = Database.OpenBlobFlag(rawValue: rawValue)
        #expect(openBlobFlag.rawValue == rawValue)
    }
}
