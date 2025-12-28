import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Database+Function")
struct DatabaseFunctionTests {
    @Test("TextEncoding init(rawValue:) preserves rawValue")
    func textEncodingRawValueRoundTrip() {
        let rawValue = Int32(10)
        let encoding = Database.TextEncoding(rawValue: rawValue)
        #expect(encoding.rawValue == rawValue)
    }

    @Test("FunctionFlag init(rawValue:) preserves rawValue")
    func functionFlagRawValueRoundTrip() {
        let rawValue = Int32(11)
        let flag = Database.FunctionFlag(rawValue: rawValue)
        #expect(flag.rawValue == rawValue)
    }

    @Test("FunctionFlag init(rawValue:) preserves combined rawValue")
    func functionFlagCombinedRawValueRoundTrip() {
        let rawValue = Database.FunctionFlag.deterministic.rawValue | Database.FunctionFlag.directOnly.rawValue
        let flag = Database.FunctionFlag(rawValue: rawValue)
        #expect(flag.rawValue == rawValue)
    }

    @Test("TextEncoding constants match SQLite")
    func textEncodingConstantsMatchSQLite() {
        #expect(Database.TextEncoding.utf8.rawValue == SQLITE_UTF8)
        #expect(Database.TextEncoding.utf16le.rawValue == SQLITE_UTF16LE)
        #expect(Database.TextEncoding.utf16be.rawValue == SQLITE_UTF16BE)
        #expect(Database.TextEncoding.utf16.rawValue == SQLITE_UTF16)
        #expect(Database.TextEncoding.any.rawValue == SQLITE_ANY)
    }

    @Test("FunctionFlag constants match SQLite")
    func functionFlagConstantsMatchSQLite() {
        #expect(Database.FunctionFlag.deterministic.rawValue == SQLITE_DETERMINISTIC)
        #expect(Database.FunctionFlag.directOnly.rawValue == SQLITE_DIRECTONLY)
        #expect(Database.FunctionFlag.subtype.rawValue == SQLITE_SUBTYPE)
        #expect(Database.FunctionFlag.innocuous.rawValue == SQLITE_INNOCUOUS)
        #expect(Database.FunctionFlag.resultSubtype.rawValue == SQLITE_RESULT_SUBTYPE)
    }
}
