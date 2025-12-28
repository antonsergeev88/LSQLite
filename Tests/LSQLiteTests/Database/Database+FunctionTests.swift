import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("Database+Function")
final class DatabaseFunctionTests {
    private let database: Database

    init() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        self.database = try #require(database)
    }

    deinit {
        _ = database.close()
    }

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

    @Test("TextEncoding descriptions map values")
    func textEncodingDescriptions() {
        #expect(Database.TextEncoding.utf8.description == "utf8")
        #expect(Database.TextEncoding.utf16le.description == "utf16le")
        #expect(Database.TextEncoding.utf16be.description == "utf16be")
        #expect(Database.TextEncoding.utf16.description == "utf16")
        #expect(Database.TextEncoding.any.description == "any")
        #expect(Database.TextEncoding(rawValue: -1).description == "unknown")
        #expect(Database.TextEncoding.utf8.debugDescription == "SQLITE_UTF8")
    }

    @Test("FunctionFlag descriptions map values")
    func functionFlagDescriptions() {
        #expect(Database.FunctionFlag([]).description == "[]")
        #expect(Database.FunctionFlag.deterministic.description.contains(".deterministic"))
        let knownMask = UInt32(bitPattern: Database.FunctionFlag.deterministic.rawValue)
            | UInt32(bitPattern: Database.FunctionFlag.directOnly.rawValue)
            | UInt32(bitPattern: Database.FunctionFlag.subtype.rawValue)
            | UInt32(bitPattern: Database.FunctionFlag.innocuous.rawValue)
            | UInt32(bitPattern: Database.FunctionFlag.resultSubtype.rawValue)
        let unknownOnlyRaw = Int32(bitPattern: ~knownMask)
        #expect(Database.FunctionFlag(rawValue: unknownOnlyRaw).description == "unknown")
        let mixed = Database.FunctionFlag(rawValue: Database.FunctionFlag.deterministic.rawValue | unknownOnlyRaw)
        #expect(mixed.description.contains("unknown"))
        #expect(Database.FunctionFlag.deterministic.debugDescription.contains("SQLITE_DETERMINISTIC"))
        #expect(mixed.debugDescription.contains("0x"))
    }

    @Test("createFunction registers scalar function")
    func createFunctionRegistersScalarFunction() throws {
        #expect(database.createFunction(name: "constant_seven", argumentCount: 0, textEncoding: .utf8, flags: [.deterministic], funcHandler: constantFunction) == .ok)
        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT constant_seven()", for: database) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.step() == .row)
        #expect(prepared.columnInt(at: 0) == 7)
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)
    }

    @Test("createWindowFunction registers window function")
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    func createWindowFunctionRegistersWindowFunction() {
        #expect(database.createWindowFunction(name: "window_zero", argumentCount: 0, textEncoding: .utf8, flags: [], stepHandler: windowStep, finalHandler: windowFinal, valueHandler: nil, inverseHandler: nil) == .ok)
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
