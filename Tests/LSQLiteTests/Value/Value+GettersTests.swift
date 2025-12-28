import LSQLite
import Testing

@Suite("Value+Getters")
struct ValueGettersTests {
    @Test("value getters expose underlying data")
    func valueGettersExposeUnderlyingData() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)

        let probe = ValueGetterProbe()
        let userData = Unmanaged.passUnretained(probe).toOpaque()
        #expect(openDatabase.createFunction(name: "value_getters", argumentCount: 5, textEncoding: .utf8, userData: userData, funcHandler: valueGetterHandler) == .ok)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT value_getters(?1, ?2, ?3, ?4, ?5)", for: openDatabase) == .ok)
        let prepared = try #require(statement)

        let blobBytes: [UInt8] = [0x01, 0x02, 0x03]
        let blobResult = blobBytes.withUnsafeBytes { buffer -> ResultCode in
            prepared.bindTransientBlob(buffer.baseAddress!, length: Int32(buffer.count), at: 1)
        }
        #expect(blobResult == .ok)
        #expect(prepared.bindDouble(1.5, at: 2) == .ok)
        #expect(prepared.bindInt(7, at: 3) == .ok)
        #expect(prepared.bindInt64(9_000_000_000, at: 4) == .ok)
        #expect(prepared.bindText("text", at: 5) == .ok)

        #expect(prepared.step() == .row)
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)

        #expect(!probe.blobIsNil)
        #expect(probe.doubleValue == 1.5)
        #expect(probe.intValue == 7)
        #expect(probe.int64Value == 9_000_000_000)
        #expect(probe.textValue == "text")
        _ = openDatabase.close()
    }

    @Test("text getter returns nil for NULL values")
    func textGetterReturnsNilForNullValues() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)

        let probe = ValueGetterProbe()
        let userData = Unmanaged.passUnretained(probe).toOpaque()
        #expect(openDatabase.createFunction(name: "value_getters", argumentCount: 5, textEncoding: .utf8, userData: userData, funcHandler: valueGetterHandler) == .ok)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT value_getters(?1, ?2, ?3, ?4, ?5)", for: openDatabase) == .ok)
        let prepared = try #require(statement)

        #expect(prepared.bindInt(1, at: 1) == .ok)
        #expect(prepared.bindInt(2, at: 2) == .ok)
        #expect(prepared.bindInt(3, at: 3) == .ok)
        #expect(prepared.bindInt(4, at: 4) == .ok)
        #expect(prepared.bindNull(at: 5) == .ok)

        #expect(prepared.step() == .row)
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)

        #expect(probe.textValue == nil)
        _ = openDatabase.close()
    }
}

private final class ValueGetterProbe {
    var blobIsNil = true
    var doubleValue: Double = 0
    var intValue: Int32 = 0
    var int64Value: Int64 = 0
    var textValue: String?
}

private func valueGetterHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context, let values else { return }
    let wrapper = Context(rawValue: context)
    if let userData = wrapper.userData {
        let probe = Unmanaged<ValueGetterProbe>.fromOpaque(userData).takeUnretainedValue()
        let blobValue = Value(rawValue: values[0]!)
        let doubleValue = Value(rawValue: values[1]!)
        let intValue = Value(rawValue: values[2]!)
        let int64Value = Value(rawValue: values[3]!)
        let textValue = Value(rawValue: values[4]!)

        probe.blobIsNil = (blobValue.blob == nil)
        probe.doubleValue = doubleValue.double
        probe.intValue = intValue.int
        probe.int64Value = int64Value.int64
        probe.textValue = textValue.text
    }
    wrapper.resultInt(1)
}
