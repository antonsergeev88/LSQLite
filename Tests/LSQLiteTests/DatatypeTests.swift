import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Datatype")
struct DatatypeRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(37)
        let datatype = Datatype(rawValue: rawValue)
        #expect(datatype.rawValue == rawValue)
    }

    @Test("static constants match SQLite")
    func staticConstantsMatchSQLite() {
        #expect(Datatype.integer.rawValue == SQLITE_INTEGER)
        #expect(Datatype.float.rawValue == SQLITE_FLOAT)
        #expect(Datatype.blob.rawValue == SQLITE_BLOB)
        #expect(Datatype.null.rawValue == SQLITE_NULL)
        #expect(Datatype.text.rawValue == SQLITE_TEXT)
    }
}
