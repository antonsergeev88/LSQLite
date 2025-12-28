import LSQLite
import Testing

@Suite("Database+Readonly")
struct DatabaseReadWriteAccessStateRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(-7)
        let state = Database.ReadWriteAccessState(rawValue: rawValue)
        #expect(state.rawValue == rawValue)
    }
}
