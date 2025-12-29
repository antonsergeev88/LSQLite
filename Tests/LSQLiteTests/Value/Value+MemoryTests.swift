import LSQLite
import Testing

@Suite("Value+Memory")
struct ValueMemoryTests {
    @Test("createCopy and free round-trip values")
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    func createCopyAndFreeRoundTripValues() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()

        var probe = ValueMemoryProbe()
        #expect(connection.createFunction(name: "value_copy", argumentCount: 1, textEncoding: .utf8, userData: &probe, funcHandler: valueCopyHandler) == .ok)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT value_copy(?1)", for: connection) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.bindInt(99, at: 1) == .ok)
        #expect(prepared.step() == .row)
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)

        #expect(probe.copied)
        _ = connection.close()
    }
}

private struct ValueMemoryProbe {
    var copied = false
}

@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
private func valueCopyHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context, let values else { return }
    let wrapper = Context(rawValue: context)
    if let userData = wrapper.userData {
        let probe = userData.assumingMemoryBound(to: ValueMemoryProbe.self)
        let value = Value(rawValue: values[0]!)
        let copy = value.createCopy()
        if let copy {
            probe.pointee.copied = true
            copy.free()
        }
    }
    wrapper.resultInt(1)
}
