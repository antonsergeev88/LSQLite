import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Connection+Collation")
final class ConnectionCollationFlagRawValueTests {
    private let connection: Connection

    init() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        self.connection = connection
    }

    deinit {
        _ = connection.close()
    }

    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(3)
        let collationFlag = Connection.CollationFlag(rawValue: rawValue)
        #expect(collationFlag.rawValue == rawValue)
    }

    @Test("CollationFlag constants match SQLite")
    func collationFlagConstantsMatchSQLite() {
        #expect(Connection.CollationFlag.utf8.rawValue == SQLITE_UTF8)
        #expect(Connection.CollationFlag.utf16le.rawValue == SQLITE_UTF16LE)
        #expect(Connection.CollationFlag.utf16be.rawValue == SQLITE_UTF16BE)
        #expect(Connection.CollationFlag.utf16.rawValue == SQLITE_UTF16)
        #expect(Connection.CollationFlag.utf16Aligned.rawValue == SQLITE_UTF16_ALIGNED)
    }

    @Test("CollationFlag descriptions map values")
    func collationFlagDescriptions() {
        #expect(Connection.CollationFlag.utf8.description == "utf8")
        #expect(Connection.CollationFlag.utf16le.description == "utf16le")
        #expect(Connection.CollationFlag.utf16be.description == "utf16be")
        #expect(Connection.CollationFlag.utf16.description == "utf16")
        #expect(Connection.CollationFlag.utf16Aligned.description == "utf16Aligned")
        #expect(Connection.CollationFlag(rawValue: -2).description == "unknown")
        #expect(Connection.CollationFlag.utf8.debugDescription == "SQLITE_UTF8")
        #expect(Connection.CollationFlag(rawValue: -2).debugDescription == "-2")
    }

    @Test("createCollation registers a comparator")
    func createCollationRegistersComparator() {
        #expect(connection.createCollation(name: "always_equal", flag: .utf8, compareHandler: alwaysEqualCollation) == .ok)
    }

    @Test("collationNeeded registers and invokes handler")
    func collationNeededRegistersAndInvokesHandler() throws {
        var probe = CollationNeededProbe()
        #expect(connection.collationNeeded(userData: &probe, neededHandler: collationNeededHandler) == .ok)
        try #require(connection.exec("SELECT 'a' = 'b' COLLATE needs_help") == .ok)
        #expect(probe.called)
        #expect(connection.collationNeeded(userData: nil, neededHandler: nil) == .ok)
    }
}

private struct CollationNeededProbe {
    var called = false
}

private func alwaysEqualCollation(_ userData: UnsafeMutableRawPointer?, _ lhsLength: Int32, _ lhs: UnsafeRawPointer?, _ rhsLength: Int32, _ rhs: UnsafeRawPointer?) -> Int32 {
    0
}

private func collationNeededHandler(_ userData: UnsafeMutableRawPointer?, _ db: OpaquePointer?, _ collationFlag: Int32, _ name: UnsafePointer<Int8>?) {
    guard let userData else {
        return
    }
    let probe = userData.assumingMemoryBound(to: CollationNeededProbe.self)
    probe.pointee.called = true
    guard let db, let name else {
        return
    }
    let connection = Connection(rawValue: db)
    _ = connection.createCollation(name: String(cString: name), flag: Connection.CollationFlag(rawValue: collationFlag), compareHandler: alwaysEqualCollation)
}
