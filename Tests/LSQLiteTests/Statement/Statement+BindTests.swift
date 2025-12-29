import LSQLite
import Testing

@Suite("Statement+Bind")
final class StatementBindTests {
    private let connection: Connection

    init() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        self.connection = connection
        try #require(connection.exec("""
            CREATE TABLE bindings(
                int_value INTEGER,
                double_value REAL,
                text_value TEXT,
                blob_value BLOB,
                zero_blob BLOB,
                null_value TEXT,
                int64_value INTEGER
            )
            """) == .ok)
    }

    deinit {
        _ = connection.close()
    }

    @Test("binding metadata is available")
    func bindingMetadataIsAvailable() throws {
        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT ?1, :name, ?3", for: connection) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.bindingCount == 3)
        let firstName = prepared.bindingName(at: 1)
        #expect(firstName == nil || firstName == "?1")
        let secondName = prepared.bindingName(at: 2)
        #expect(secondName?.contains("name") == true)
        let indexWithPrefix = prepared.bindingIndex(with: ":name")
        let indexWithoutPrefix = prepared.bindingIndex(with: "name")
        #expect(indexWithPrefix == 2 || indexWithoutPrefix == 2)
        #expect(prepared.finalize() == .ok)
    }

    @Test("binds scalar and blob values")
    func bindsScalarAndBlobValues() throws {
        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "INSERT INTO bindings(int_value, double_value, text_value, blob_value, zero_blob, null_value, int64_value) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7)", for: connection) == .ok)
        let prepared = try #require(statement)

        #expect(prepared.bindInt(12, at: 1) == .ok)
        #expect(prepared.bindDouble(12.5, at: 2) == .ok)
        #expect(prepared.bindText("hello", at: 3) == .ok)

        let blobBytes: [UInt8] = [0x01, 0x02, 0x03]
        let transientResult = blobBytes.withUnsafeBytes { buffer -> ResultCode in
            let baseAddress = buffer.baseAddress!
            return prepared.bindTransientBlob(baseAddress, length: Int32(buffer.count), at: 4)
        }
        #expect(transientResult == .ok)

        #expect(prepared.bindZeroBlob(length: 4, at: 5) == .ok)
        #expect(prepared.bindNull(at: 6) == .ok)
        #expect(prepared.bindInt64(9_000_000_000, at: 7) == .ok)
        #expect(prepared.clearBindings() == .ok)

        #expect(prepared.bindInt(1, at: 1) == .ok)
        #expect(prepared.bindDouble(2.5, at: 2) == .ok)
        #expect(prepared.bindText("again", at: 3) == .ok)
        let staticBytes: [UInt8] = [0xAA, 0xBB]
        let staticResult = staticBytes.withUnsafeBytes { buffer -> ResultCode in
            let baseAddress = buffer.baseAddress!
            return prepared.bindStaticBlob(baseAddress, length: Int32(buffer.count), at: 4)
        }
        #expect(staticResult == .ok)
        #expect(prepared.bindZeroBlob(length: 2, at: 5) == .ok)
        #expect(prepared.bindNull(at: 6) == .ok)
        #expect(prepared.bindInt64(2, at: 7) == .ok)

        #expect(prepared.step() == .done)
        #expect(prepared.reset() == .ok)
        #expect(prepared.finalize() == .ok)
    }

    @Test("bindBlob uses destructor")
    func bindBlobUsesDestructor() throws {
        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "INSERT INTO bindings(blob_value) VALUES (?1)", for: connection) == .ok)
        let prepared = try #require(statement)

        let pointer = UnsafeMutableRawPointer.allocate(byteCount: 2, alignment: MemoryLayout<UInt8>.alignment)
        pointer.storeBytes(of: UInt8(0xCC), as: UInt8.self)
        pointer.advanced(by: 1).storeBytes(of: UInt8(0xDD), as: UInt8.self)
        #expect(prepared.bindBlob(pointer, length: 2, at: 1, destructor: blobDestructor) == .ok)
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)
    }
}

private func blobDestructor(_ blob: UnsafeMutableRawPointer?) {
    blob?.deallocate()
}
