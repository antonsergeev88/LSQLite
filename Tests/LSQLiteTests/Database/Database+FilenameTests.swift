import Foundation
import LSQLite
import Testing

@Suite("Database+Filename")
struct DatabaseFilenameTests {
    @Test("filename returns empty string for in-memory database")
    func filenameReturnsEmptyStringForInMemoryDatabase() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)
        #expect(openDatabase.filename(forDatabaseNamed: "main") == "")
        #expect(openDatabase.filename(forDatabaseNamed: "missing") == nil)
        _ = openDatabase.close()
    }

    @Test("filename returns a path for file database")
    func filenameReturnsPathForFileDatabase() throws {
        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent("lsqlite-filename.sqlite")
        defer {
            try? FileManager.default.removeItem(at: fileURL)
        }
        var database: Database?
        try #require(Database.open(&database, at: .init(rawValue: fileURL.path), withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)
        let filename = openDatabase.filename(forDatabaseNamed: "main")
        #expect(filename != nil)
        #expect(filename?.isEmpty == false)
        _ = openDatabase.close()
    }
}
