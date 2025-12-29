import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Connection+Function")
final class ConnectionFunctionTests {
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

    @Test("TextEncoding init(rawValue:) preserves rawValue")
    func textEncodingRawValueRoundTrip() {
        let rawValue = Int32(10)
        let encoding = Connection.TextEncoding(rawValue: rawValue)
        #expect(encoding.rawValue == rawValue)
    }

    @Test("FunctionFlag init(rawValue:) preserves rawValue")
    func functionFlagRawValueRoundTrip() {
        let rawValue = Int32(11)
        let flag = Connection.FunctionFlag(rawValue: rawValue)
        #expect(flag.rawValue == rawValue)
    }

    @Test("FunctionFlag init(rawValue:) preserves combined rawValue")
    func functionFlagCombinedRawValueRoundTrip() {
        let rawValue = Connection.FunctionFlag.deterministic.rawValue | Connection.FunctionFlag.directOnly.rawValue
        let flag = Connection.FunctionFlag(rawValue: rawValue)
        #expect(flag.rawValue == rawValue)
    }

    @Test("TextEncoding constants match SQLite")
    func textEncodingConstantsMatchSQLite() {
        #expect(Connection.TextEncoding.utf8.rawValue == SQLITE_UTF8)
        #expect(Connection.TextEncoding.utf16le.rawValue == SQLITE_UTF16LE)
        #expect(Connection.TextEncoding.utf16be.rawValue == SQLITE_UTF16BE)
        #expect(Connection.TextEncoding.utf16.rawValue == SQLITE_UTF16)
        #expect(Connection.TextEncoding.any.rawValue == SQLITE_ANY)
    }

    @Test("FunctionFlag constants match SQLite")
    func functionFlagConstantsMatchSQLite() {
        #expect(Connection.FunctionFlag.deterministic.rawValue == SQLITE_DETERMINISTIC)
        #expect(Connection.FunctionFlag.directOnly.rawValue == SQLITE_DIRECTONLY)
        #expect(Connection.FunctionFlag.subtype.rawValue == SQLITE_SUBTYPE)
        #expect(Connection.FunctionFlag.innocuous.rawValue == SQLITE_INNOCUOUS)
        #expect(Connection.FunctionFlag.resultSubtype.rawValue == SQLITE_RESULT_SUBTYPE)
    }

    @Test("TextEncoding descriptions map values")
    func textEncodingDescriptions() {
        #expect(Connection.TextEncoding.utf8.description == "utf8")
        #expect(Connection.TextEncoding.utf16le.description == "utf16le")
        #expect(Connection.TextEncoding.utf16be.description == "utf16be")
        #expect(Connection.TextEncoding.utf16.description == "utf16")
        #expect(Connection.TextEncoding.any.description == "any")
        #expect(Connection.TextEncoding(rawValue: -1).description == "unknown")
        #expect(Connection.TextEncoding.utf8.debugDescription == "SQLITE_UTF8")
    }

    @Test("FunctionFlag descriptions map values")
    func functionFlagDescriptions() {
        #expect(Connection.FunctionFlag([]).description == "[]")
        #expect(Connection.FunctionFlag.deterministic.description.contains(".deterministic"))
        let knownMask = UInt32(bitPattern: Connection.FunctionFlag.deterministic.rawValue)
            | UInt32(bitPattern: Connection.FunctionFlag.directOnly.rawValue)
            | UInt32(bitPattern: Connection.FunctionFlag.subtype.rawValue)
            | UInt32(bitPattern: Connection.FunctionFlag.innocuous.rawValue)
            | UInt32(bitPattern: Connection.FunctionFlag.resultSubtype.rawValue)
        let unknownOnlyRaw = Int32(bitPattern: ~knownMask)
        #expect(Connection.FunctionFlag(rawValue: unknownOnlyRaw).description == "unknown")
        let mixed = Connection.FunctionFlag(rawValue: Connection.FunctionFlag.deterministic.rawValue | unknownOnlyRaw)
        #expect(mixed.description.contains("unknown"))
        #expect(Connection.FunctionFlag.deterministic.debugDescription.contains("SQLITE_DETERMINISTIC"))
        #expect(mixed.debugDescription.contains("0x"))
    }

    @Test("createFunction registers scalar function")
    func createFunctionRegistersScalarFunction() throws {
        #expect(connection.createFunction(name: "constant_seven", argumentCount: 0, textEncoding: .utf8, flags: [.deterministic], funcHandler: constantFunction) == .ok)
        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT constant_seven()", for: connection) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.step() == .row)
        #expect(prepared.columnInt(at: 0) == 7)
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)
    }

    @Test("createWindowFunction registers window function")
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    func createWindowFunctionRegistersWindowFunction() {
        #expect(connection.createWindowFunction(name: "window_zero", argumentCount: 0, textEncoding: .utf8, flags: [], stepHandler: windowStep, finalHandler: windowFinal, valueHandler: nil, inverseHandler: nil) == .ok)
    }
}

private func constantFunction(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else {
        return
    }
    let contextWrapper = Context(rawValue: context)
    contextWrapper.resultInt(7)
}

private func windowStep(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
}

private func windowFinal(_ context: OpaquePointer?) {
    guard let context else {
        return
    }
    Context(rawValue: context).resultInt(0)
}
