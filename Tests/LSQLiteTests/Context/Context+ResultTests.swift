import LSQLite
import Testing

@Suite("Context+Result")
final class ContextResultTests {
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

    @Test("resultInt, resultInt64, and resultDouble set values")
    func resultScalarValues() throws {
        #expect(connection.createFunction(name: "ctx_int", argumentCount: 0, textEncoding: .utf8, funcHandler: resultIntHandler) == .ok)
        #expect(connection.createFunction(name: "ctx_int64", argumentCount: 0, textEncoding: .utf8, funcHandler: resultInt64Handler) == .ok)
        #expect(connection.createFunction(name: "ctx_double", argumentCount: 0, textEncoding: .utf8, funcHandler: resultDoubleHandler) == .ok)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT ctx_int()", for: connection) == .ok)
        let intStatement = try #require(statement)
        #expect(intStatement.step() == .row)
        #expect(intStatement.columnInt(at: 0) == 7)
        #expect(intStatement.step() == .done)
        #expect(intStatement.finalize() == .ok)

        var int64Statement: Statement?
        try #require(Statement.prepare(&int64Statement, sql: "SELECT ctx_int64()", for: connection) == .ok)
        let preparedInt64 = try #require(int64Statement)
        #expect(preparedInt64.step() == .row)
        #expect(preparedInt64.columnInt64(at: 0) == 9_000_000_000)
        #expect(preparedInt64.step() == .done)
        #expect(preparedInt64.finalize() == .ok)

        var doubleStatement: Statement?
        try #require(Statement.prepare(&doubleStatement, sql: "SELECT ctx_double()", for: connection) == .ok)
        let preparedDouble = try #require(doubleStatement)
        #expect(preparedDouble.step() == .row)
        #expect(preparedDouble.columnDouble(at: 0) == 3.25)
        #expect(preparedDouble.step() == .done)
        #expect(preparedDouble.finalize() == .ok)
    }

    @Test("resultText, resultNull, and resultValue set values")
    func resultTextNullAndValue() throws {
        #expect(connection.createFunction(name: "ctx_text", argumentCount: 0, textEncoding: .utf8, funcHandler: resultTextHandler) == .ok)
        #expect(connection.createFunction(name: "ctx_null", argumentCount: 0, textEncoding: .utf8, funcHandler: resultNullHandler) == .ok)
        #expect(connection.createFunction(name: "ctx_value", argumentCount: 1, textEncoding: .utf8, funcHandler: resultValueHandler) == .ok)

        var textStatement: Statement?
        try #require(Statement.prepare(&textStatement, sql: "SELECT ctx_text()", for: connection) == .ok)
        let preparedText = try #require(textStatement)
        #expect(preparedText.step() == .row)
        #expect(preparedText.columnText(at: 0) == "hello")
        #expect(preparedText.step() == .done)
        #expect(preparedText.finalize() == .ok)

        var nullStatement: Statement?
        try #require(Statement.prepare(&nullStatement, sql: "SELECT ctx_null()", for: connection) == .ok)
        let preparedNull = try #require(nullStatement)
        #expect(preparedNull.step() == .row)
        #expect(preparedNull.columnType(at: 0) == .null)
        #expect(preparedNull.step() == .done)
        #expect(preparedNull.finalize() == .ok)

        var valueStatement: Statement?
        try #require(Statement.prepare(&valueStatement, sql: "SELECT ctx_value(42)", for: connection) == .ok)
        let preparedValue = try #require(valueStatement)
        #expect(preparedValue.step() == .row)
        #expect(preparedValue.columnInt(at: 0) == 42)
        #expect(preparedValue.step() == .done)
        #expect(preparedValue.finalize() == .ok)
    }

    @Test("resultBlob variants set blob values")
    func resultBlobVariants() throws {
        #expect(connection.createFunction(name: "ctx_blob", argumentCount: 0, textEncoding: .utf8, funcHandler: resultBlobHandler) == .ok)
        #expect(connection.createFunction(name: "ctx_transient_blob", argumentCount: 0, textEncoding: .utf8, funcHandler: resultTransientBlobHandler) == .ok)
        #expect(connection.createFunction(name: "ctx_static_blob", argumentCount: 0, textEncoding: .utf8, funcHandler: resultStaticBlobHandler) == .ok)
        #expect(connection.createFunction(name: "ctx_zero_blob", argumentCount: 0, textEncoding: .utf8, funcHandler: resultZeroBlobHandler) == .ok)

        var blobStatement: Statement?
        try #require(Statement.prepare(&blobStatement, sql: "SELECT ctx_blob()", for: connection) == .ok)
        let preparedBlob = try #require(blobStatement)
        #expect(preparedBlob.step() == .row)
        #expect(preparedBlob.columnBytes(at: 0) == 2)
        #expect(preparedBlob.step() == .done)
        #expect(preparedBlob.finalize() == .ok)

        var transientStatement: Statement?
        try #require(Statement.prepare(&transientStatement, sql: "SELECT ctx_transient_blob()", for: connection) == .ok)
        let preparedTransient = try #require(transientStatement)
        #expect(preparedTransient.step() == .row)
        #expect(preparedTransient.columnBytes(at: 0) == 3)
        #expect(preparedTransient.step() == .done)
        #expect(preparedTransient.finalize() == .ok)

        var staticStatement: Statement?
        try #require(Statement.prepare(&staticStatement, sql: "SELECT ctx_static_blob()", for: connection) == .ok)
        let preparedStatic = try #require(staticStatement)
        #expect(preparedStatic.step() == .row)
        #expect(preparedStatic.columnBytes(at: 0) == 2)
        #expect(preparedStatic.step() == .done)
        #expect(preparedStatic.finalize() == .ok)

        var zeroStatement: Statement?
        try #require(Statement.prepare(&zeroStatement, sql: "SELECT ctx_zero_blob()", for: connection) == .ok)
        let preparedZero = try #require(zeroStatement)
        #expect(preparedZero.step() == .row)
        #expect(preparedZero.columnBytes(at: 0) == 4)
        #expect(preparedZero.step() == .done)
        #expect(preparedZero.finalize() == .ok)
    }

    @Test("error result helpers produce expected codes")
    func errorResultHelpers() throws {
        #expect(connection.createFunction(name: "ctx_error", argumentCount: 0, textEncoding: .utf8, funcHandler: resultErrorHandler) == .ok)
        #expect(connection.createFunction(name: "ctx_error_code", argumentCount: 0, textEncoding: .utf8, funcHandler: resultErrorCodeHandler) == .ok)
        #expect(connection.createFunction(name: "ctx_toobig", argumentCount: 0, textEncoding: .utf8, funcHandler: resultTooBigHandler) == .ok)
        #expect(connection.createFunction(name: "ctx_nomem", argumentCount: 0, textEncoding: .utf8, funcHandler: resultNoMemoryHandler) == .ok)

        var errorStatement: Statement?
        try #require(Statement.prepare(&errorStatement, sql: "SELECT ctx_error()", for: connection) == .ok)
        let preparedError = try #require(errorStatement)
        let errorResult = preparedError.step()
        #expect(errorResult != .row && errorResult != .done)
        _ = preparedError.finalize()

        var errorCodeStatement: Statement?
        try #require(Statement.prepare(&errorCodeStatement, sql: "SELECT ctx_error_code()", for: connection) == .ok)
        let preparedErrorCode = try #require(errorCodeStatement)
        let errorCodeResult = preparedErrorCode.step()
        #expect(errorCodeResult != .row && errorCodeResult != .done)
        _ = preparedErrorCode.finalize()

        var tooBigStatement: Statement?
        try #require(Statement.prepare(&tooBigStatement, sql: "SELECT ctx_toobig()", for: connection) == .ok)
        let preparedTooBig = try #require(tooBigStatement)
        let tooBigResult = preparedTooBig.step()
        #expect(tooBigResult != .row && tooBigResult != .done)
        _ = preparedTooBig.finalize()

        var noMemoryStatement: Statement?
        try #require(Statement.prepare(&noMemoryStatement, sql: "SELECT ctx_nomem()", for: connection) == .ok)
        let preparedNoMem = try #require(noMemoryStatement)
        let noMemoryResult = preparedNoMem.step()
        #expect(noMemoryResult != .row && noMemoryResult != .done)
        _ = preparedNoMem.finalize()
    }

    @Test("resultSubtype assigns subtype when available")
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    func resultSubtypeAssignsSubtype() throws {
        #expect(connection.createFunction(name: "ctx_subtype", argumentCount: 0, textEncoding: .utf8, flags: [.resultSubtype], funcHandler: resultSubtypeHandler) == .ok)
        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT ctx_subtype()", for: connection) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.step() == .row)
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)
    }
}

private func resultIntHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else { return }
    Context(rawValue: context).resultInt(7)
}

private func resultInt64Handler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else { return }
    Context(rawValue: context).resultInt64(9_000_000_000)
}

private func resultDoubleHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else { return }
    Context(rawValue: context).resultDouble(3.25)
}

private func resultTextHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else { return }
    Context(rawValue: context).resultText("hello")
}

private func resultNullHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else { return }
    Context(rawValue: context).resultNull()
}

private func resultValueHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context, let values else { return }
    let wrapper = Context(rawValue: context)
    let value = Value(rawValue: values[0]!)
    wrapper.resultValue(value)
}

private func resultBlobHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else { return }
    let wrapper = Context(rawValue: context)
    let pointer = UnsafeMutableRawPointer.allocate(byteCount: 2, alignment: MemoryLayout<UInt8>.alignment)
    pointer.storeBytes(of: UInt8(0x01), as: UInt8.self)
    pointer.advanced(by: 1).storeBytes(of: UInt8(0x02), as: UInt8.self)
    wrapper.resultBlob(pointer, length: 2, destructor: resultBlobDestructor)
}

private func resultTransientBlobHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else { return }
    let wrapper = Context(rawValue: context)
    let bytes: [UInt8] = [0x01, 0x02, 0x03]
    bytes.withUnsafeBytes { buffer in
        wrapper.resultTransientBlob(buffer.baseAddress!, length: Int32(buffer.count))
    }
}

private let staticBlobBytes: [UInt8] = [0x0A, 0x0B]

private func resultStaticBlobHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else { return }
    let wrapper = Context(rawValue: context)
    staticBlobBytes.withUnsafeBytes { buffer in
        wrapper.resultStaticBlob(buffer.baseAddress!, length: Int32(buffer.count))
    }
}

private func resultZeroBlobHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else { return }
    Context(rawValue: context).resultZeroBlob(length: 4)
}

private func resultErrorHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else { return }
    Context(rawValue: context).resultError("failed", length: -1)
}

private func resultErrorCodeHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else { return }
    Context(rawValue: context).resultErrorCode(.constraint)
}

private func resultTooBigHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else { return }
    Context(rawValue: context).resultTooBigError()
}

private func resultNoMemoryHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else { return }
    Context(rawValue: context).resultNoMemoryError()
}

@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
private func resultSubtypeHandler(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else { return }
    let wrapper = Context(rawValue: context)
    wrapper.resultInt(1)
    wrapper.resultSubtype(Subtype(rawValue: 7))
}

private func resultBlobDestructor(_ blob: UnsafeMutableRawPointer?) {
    blob?.deallocate()
}
