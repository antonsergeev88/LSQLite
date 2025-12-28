import LSQLite
import Testing

@Suite("Value+Introspect")
struct ValueIntrospectTests {
    @Test("value introspection reports metadata")
    func valueIntrospectionReportsMetadata() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)

        var probe = ValueIntrospectProbe()
        #expect(openDatabase.createFunction(name: "value_introspect", argumentCount: 1, textEncoding: .utf8, userData: &probe, funcHandler: valueIntrospectHandler) == .ok)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT value_introspect(?1)", for: openDatabase) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.bindText("123", at: 1) == .ok)
        #expect(prepared.step() == .row)
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)

        #expect(probe.byteCount == 3)
        #expect(probe.typeRawValue == Datatype.text.rawValue)
        #expect(probe.numericTypeRawValue == Datatype.integer.rawValue)
        if #available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *) {
            #expect(probe.isFromBind)
        }
        _ = openDatabase.close()
    }
}

private struct ValueIntrospectProbe {
    var byteCount: Int32 = 0
    var typeRawValue: Int32 = 0
    var numericTypeRawValue: Int32 = 0
    var noChange: Bool = false
    var isFromBind: Bool = false
    var subtypeRawValue: UInt32 = 0
}

private func valueIntrospectHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context, let values else { return }
    let wrapper = Context(rawValue: context)
    if let userData = wrapper.userData {
        let probe = userData.assumingMemoryBound(to: ValueIntrospectProbe.self)
        let value = Value(rawValue: values[0]!)
        probe.pointee.byteCount = value.byteCount()
        probe.pointee.typeRawValue = value.type.rawValue
        probe.pointee.numericTypeRawValue = value.convertToNumericType().rawValue
        if #available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *) {
            probe.pointee.noChange = value.noChange
        }
        if #available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *) {
            probe.pointee.isFromBind = value.isFromBind
        }
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) {
            probe.pointee.subtypeRawValue = value.subtype.rawValue
        }
    }
    wrapper.resultInt(1)
}
