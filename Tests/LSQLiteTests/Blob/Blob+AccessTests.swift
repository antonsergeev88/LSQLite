import LSQLite
import Testing

@Suite("Blob+Access")
final class BlobAccessTests {
    private let connection: Connection
    private let rowID: RowID
    private let missingRowID: RowID

    init() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        self.connection = connection

        try #require(connection.exec("CREATE TABLE blobs(data BLOB NOT NULL)") == .ok)
        try #require(connection.exec("INSERT INTO blobs(data) VALUES (zeroblob(4))") == .ok)
        rowID = connection.lastInsertedRowID()
        missingRowID = RowID(rawValue: rowID.rawValue + 1)
    }

    deinit {
        _ = connection.close()
    }

    @Test("read/write and byteCount for open blob")
    func readWriteAndByteCount() throws {
        var blob: Blob?
        let openResult = connection.openBlob(&blob, databaseName: "main", tableName: "blobs", columnName: "data", rowID: rowID, flags: .readwrite)
        #expect(openResult == .ok)
        let openedBlob = try #require(blob)
        defer { _ = openedBlob.close() }

        #expect(openedBlob.byteCount == 4)

        let writeResult = try writeBytes([1, 2, 3, 4], to: openedBlob, offset: 0)
        #expect(writeResult == .ok)

        let (finalReadResult, finalBytes) = try readBytes(from: openedBlob, count: 4, offset: 0)
        #expect(finalReadResult == .ok)
        #expect(finalBytes == [1, 2, 3, 4])
    }

    @Test("read returns error when out of range")
    func readOutOfRangeReturnsError() throws {
        var blob: Blob?
        let openResult = connection.openBlob(&blob, databaseName: "main", tableName: "blobs", columnName: "data", rowID: rowID, flags: .readonly)
        #expect(openResult == .ok)
        let openedBlob = try #require(blob)
        defer { _ = openedBlob.close() }

        let (readResult, _) = try readBytes(from: openedBlob, count: 5, offset: 0)
        #expect(readResult == .error)
    }

    @Test("write on readonly blob returns readonly")
    func writeOnReadonlyBlobReturnsReadonly() throws {
        var blob: Blob?
        let openResult = connection.openBlob(&blob, databaseName: "main", tableName: "blobs", columnName: "data", rowID: rowID, flags: .readonly)
        #expect(openResult == .ok)
        let openedBlob = try #require(blob)
        defer { _ = openedBlob.close() }

        let writeResult = try writeBytes([0xFF], to: openedBlob, offset: 0)
        #expect(writeResult == .readonly)
    }

    @Test("read/write on aborted blob returns abort")
    func readWriteOnAbortedBlobReturnsAbort() throws {
        var blob: Blob?
        let openResult = connection.openBlob(&blob, databaseName: "main", tableName: "blobs", columnName: "data", rowID: rowID, flags: .readwrite)
        #expect(openResult == .ok)
        let openedBlob = try #require(blob)
        defer { _ = openedBlob.close() }

        let reopenResult = openedBlob.reopen(at: missingRowID)
        #expect(reopenResult == .error)
        #expect(openedBlob.byteCount == 0)

        let (readResult, _) = try readBytes(from: openedBlob, count: 1, offset: 0)
        #expect(readResult == .abort)

        let writeResult = try writeBytes([0xFF], to: openedBlob, offset: 0)
        #expect(writeResult == .abort)
    }
}

private func readBytes(from blob: Blob, count: Int32, offset: Int32) throws -> (ResultCode, [UInt8]) {
    var buffer = [UInt8](repeating: 0, count: Int(count))
    let result = try buffer.withUnsafeMutableBytes { bytes -> ResultCode in
        let baseAddress = try #require(bytes.baseAddress)
        return blob.read(into: baseAddress, length: count, offset: offset)
    }
    return (result, buffer)
}

private func writeBytes(_ bytes: [UInt8], to blob: Blob, offset: Int32) throws -> ResultCode {
    try bytes.withUnsafeBytes { buffer -> ResultCode in
        let baseAddress = try #require(buffer.baseAddress)
        return blob.write(baseAddress, length: Int32(buffer.count), offset: offset)
    }
}
