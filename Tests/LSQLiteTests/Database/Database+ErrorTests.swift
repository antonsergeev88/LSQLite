import LSQLite
import Testing

@Suite("Database+Error")
struct DatabaseExtendedResultCodeStatusRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(42)
        let status = Database.ExtendedResultCodeStatus(rawValue: rawValue)
        #expect(status.rawValue == rawValue)
    }
}
