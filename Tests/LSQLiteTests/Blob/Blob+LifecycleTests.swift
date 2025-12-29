import LSQLite
import Testing

@Suite("Blob+Lifecycle")
final class BlobLifecycleTests {
    private let connection: Connection
    private let firstRowID: RowID
    private let secondRowID: RowID
    private let missingRowID: RowID
    private var didCloseConnection = false

    init() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        self.connection = connection

        try #require(connection.exec("CREATE TABLE blobs(data BLOB NOT NULL)") == .ok)
        try #require(connection.exec("INSERT INTO blobs(data) VALUES (x'010203')") == .ok)
        firstRowID = connection.lastInsertedRowID()

        try #require(connection.exec("INSERT INTO blobs(data) VALUES (x'0A0B0C')") == .ok)
        secondRowID = connection.lastInsertedRowID()
        missingRowID = RowID(rawValue: secondRowID.rawValue + 1)
    }

    deinit {
        guard !didCloseConnection else { return }
        _ = connection.close()
    }

    @Test("reopen moves handle to another row")
    func reopenMovesHandleToAnotherRow() throws {
        var blob: Blob?
        let openResult = connection.openBlob(&blob, databaseName: "main", tableName: "blobs", columnName: "data", rowID: firstRowID, flags: .readonly)
        #expect(openResult == .ok)
        let openedBlob = try #require(blob)
        defer { _ = openedBlob.close() }

        let (firstReadResult, firstBytes) = try readBytes(from: openedBlob, count: 3, offset: 0)
        #expect(firstReadResult == .ok)
        #expect(firstBytes == [0x01, 0x02, 0x03])

        let reopenResult = openedBlob.reopen(at: secondRowID)
        #expect(reopenResult == .ok)

        let (secondReadResult, secondBytes) = try readBytes(from: openedBlob, count: 3, offset: 0)
        #expect(secondReadResult == .ok)
        #expect(secondBytes == [0x0A, 0x0B, 0x0C])
    }

    @Test("reopen to missing row aborts handle")
    func reopenMissingRowAbortsHandle() throws {
        var blob: Blob?
        let openResult = connection.openBlob(&blob, databaseName: "main", tableName: "blobs", columnName: "data", rowID: secondRowID, flags: .readwrite)
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

        let reopenAgainResult = openedBlob.reopen(at: secondRowID)
        #expect(reopenAgainResult == .abort)
    }

    @Test("connection close fails while blob is open")
    func connectionCloseFailsWhileBlobIsOpen() throws {
        var blob: Blob?
        let openResult = connection.openBlob(&blob, databaseName: "main", tableName: "blobs", columnName: "data", rowID: firstRowID, flags: .readonly)
        #expect(openResult == .ok)
        let openedBlob = try #require(blob)

        let closeWhileOpen = connection.close()
        #expect(closeWhileOpen == .busy)

        _ = openedBlob.close()
        let closeAfterBlob = connection.close()
        #expect(closeAfterBlob == .ok)
        didCloseConnection = closeAfterBlob == .ok
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
