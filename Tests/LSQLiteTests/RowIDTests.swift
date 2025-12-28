import LSQLite
import Testing

@Suite("RowID")
struct RowIDRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int64(9_876_543_210)
        let rowID = RowID(rawValue: rawValue)
        #expect(rowID.rawValue == rawValue)
    }

    @Test("description reflects rawValue")
    func descriptionReflectsRawValue() {
        let rawValue = Int64(42)
        let rowID = RowID(rawValue: rawValue)
        #expect(rowID.description == "42")
    }
}
