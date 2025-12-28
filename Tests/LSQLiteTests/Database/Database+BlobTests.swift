import LSQLite
import Testing

@Suite("Database+Blob")
struct DatabaseOpenBlobFlagRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(2)
        let openBlobFlag = Database.OpenBlobFlag(rawValue: rawValue)
        #expect(openBlobFlag.rawValue == rawValue)
    }

    @Test("OpenBlobFlag descriptions map values")
    func openBlobFlagDescriptions() {
        #expect(Database.OpenBlobFlag.readonly.description == "readonly")
        #expect(Database.OpenBlobFlag.readwrite.description == "readwrite")
        #expect(Database.OpenBlobFlag(rawValue: 5).description == "5")
        #expect(Database.OpenBlobFlag.readonly.debugDescription == "readonly (0)")
    }

    @Test("openBlob returns a blob handle")
    func openBlobReturnsBlobHandle() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)
        try #require(openDatabase.exec("CREATE TABLE blobs(data BLOB NOT NULL)") == .ok)
        try #require(openDatabase.exec("INSERT INTO blobs(data) VALUES (zeroblob(2))") == .ok)
        let rowID = openDatabase.lastInsertedRowID()

        var blob: Blob?
        #expect(openDatabase.openBlob(&blob, databaseName: "main", tableName: "blobs", columnName: "data", rowID: rowID, flags: .readonly) == .ok)
        let openedBlob = try #require(blob)
        #expect(openedBlob.close() == .ok)
        _ = openDatabase.close()
    }
}
