import LSQLite
import Testing

@Suite("Connection+Blob")
struct ConnectionOpenBlobFlagRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(2)
        let openBlobFlag = Connection.OpenBlobFlag(rawValue: rawValue)
        #expect(openBlobFlag.rawValue == rawValue)
    }

    @Test("OpenBlobFlag descriptions map values")
    func openBlobFlagDescriptions() {
        #expect(Connection.OpenBlobFlag.readonly.description == "readonly")
        #expect(Connection.OpenBlobFlag.readwrite.description == "readwrite")
        #expect(Connection.OpenBlobFlag(rawValue: 5).description == "5")
        #expect(Connection.OpenBlobFlag.readonly.debugDescription == "readonly (0)")
    }

    @Test("openBlob returns a blob handle")
    func openBlobReturnsBlobHandle() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        try #require(connection.exec("CREATE TABLE blobs(data BLOB NOT NULL)") == .ok)
        try #require(connection.exec("INSERT INTO blobs(data) VALUES (zeroblob(2))") == .ok)
        let rowID = connection.lastInsertedRowID()

        var blob: Blob?
        #expect(connection.openBlob(&blob, databaseName: "main", tableName: "blobs", columnName: "data", rowID: rowID, flags: .readonly) == .ok)
        let openedBlob = try #require(blob)
        #expect(openedBlob.close() == .ok)
        _ = connection.close()
    }
}
