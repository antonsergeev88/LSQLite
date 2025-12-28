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

    @Test("description maps known values")
    func descriptionMapsKnownValues() {
        #expect(Datatype.integer.description == "integer")
        #expect(Datatype.float.description == "float")
        #expect(Datatype.blob.description == "blob")
        #expect(Datatype.null.description == "null")
        #expect(Datatype.text.description == "text")
    }

    @Test("debugDescription maps known values")
    func debugDescriptionMapsKnownValues() {
        #expect(Datatype.integer.debugDescription == "SQLITE_INTEGER")
        #expect(Datatype.float.debugDescription == "SQLITE_FLOAT")
        #expect(Datatype.blob.debugDescription == "SQLITE_BLOB")
        #expect(Datatype.null.debugDescription == "SQLITE_NULL")
        #expect(Datatype.text.debugDescription == "SQLITE_TEXT")
    }

    @Test("unknown values use fallback strings")
    func unknownValuesUseFallbackStrings() {
        let unknown = Datatype(rawValue: 1234)
        #expect(unknown.description == "unknown")
        #expect(unknown.debugDescription == "1234")
    }
}
