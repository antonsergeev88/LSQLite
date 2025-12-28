import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Database+Collation")
final class DatabaseCollationFlagRawValueTests {
    private let database: Database

    init() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        self.database = try #require(database)
    }

    deinit {
        _ = database.close()
    }

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

    @Test("CollationFlag descriptions map values")
    func collationFlagDescriptions() {
        #expect(Database.CollationFlag.utf8.description == "utf8")
        #expect(Database.CollationFlag.utf16le.description == "utf16le")
        #expect(Database.CollationFlag.utf16be.description == "utf16be")
        #expect(Database.CollationFlag.utf16.description == "utf16")
        #expect(Database.CollationFlag.utf16Aligned.description == "utf16Aligned")
        #expect(Database.CollationFlag(rawValue: -2).description == "unknown")
        #expect(Database.CollationFlag.utf8.debugDescription == "SQLITE_UTF8")
        #expect(Database.CollationFlag(rawValue: -2).debugDescription == "-2")
    }

    @Test("createCollation registers a comparator")
    func createCollationRegistersComparator() {
        #expect(database.createCollation(name: "always_equal", flag: .utf8, compareHandler: alwaysEqualCollation) == .ok)
    }

    @Test("collationNeeded registers and invokes handler")
    func collationNeededRegistersAndInvokesHandler() throws {
        var probe = CollationNeededProbe()
        #expect(database.collationNeeded(userData: &probe, neededHandler: collationNeededHandler) == .ok)
        try #require(database.exec("SELECT 'a' = 'b' COLLATE needs_help") == .ok)
        #expect(probe.called)
        #expect(database.collationNeeded(userData: nil, neededHandler: nil) == .ok)
    }
}

private struct CollationNeededProbe {
    var called = false
}

private func alwaysEqualCollation(_ userData: UnsafeMutableRawPointer?, _ lhsLength: Int32, _ lhs: UnsafeRawPointer?, _ rhsLength: Int32, _ rhs: UnsafeRawPointer?) -> Int32 {
    0
}

private func collationNeededHandler(_ userData: UnsafeMutableRawPointer?, _ database: OpaquePointer?, _ collationFlag: Int32, _ name: UnsafePointer<Int8>?) {
    guard let userData else {
        return
    }
    let probe = userData.assumingMemoryBound(to: CollationNeededProbe.self)
    probe.pointee.called = true
    guard let database, let name else {
        return
    }
    let connection = Database(rawValue: database)
    _ = connection.createCollation(name: String(cString: name), flag: Database.CollationFlag(rawValue: collationFlag), compareHandler: alwaysEqualCollation)
}
