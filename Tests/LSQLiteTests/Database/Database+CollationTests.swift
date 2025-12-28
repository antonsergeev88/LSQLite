import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Database+Collation")
struct DatabaseCollationFlagRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(3)
        let collationFlag = Database.CollationFlag(rawValue: rawValue)
        #expect(collationFlag.rawValue == rawValue)
    }

    @Test("CollationFlag constants match SQLite")
    func collationFlagConstantsMatchSQLite() {
        #expect(Database.CollationFlag.utf8.rawValue == SQLITE_UTF8)
        #expect(Database.CollationFlag.utf16le.rawValue == SQLITE_UTF16LE)
        #expect(Database.CollationFlag.utf16be.rawValue == SQLITE_UTF16BE)
        #expect(Database.CollationFlag.utf16.rawValue == SQLITE_UTF16)
        #expect(Database.CollationFlag.utf16Aligned.rawValue == SQLITE_UTF16_ALIGNED)
    }
}
