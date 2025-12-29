import Foundation
import LSQLite
import Testing

@Suite("Connection+Filename")
struct ConnectionFilenameTests {
    @Test("filename returns empty string for in-memory connection")
    func filenameReturnsEmptyStringForInMemoryConnection() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        #expect(connection.filename(forDatabaseNamed: "main") == "")
        #expect(connection.filename(forDatabaseNamed: "missing") == nil)
        _ = connection.close()
    }

    @Test("filename returns a path for file connection")
    func filenameReturnsPathForFileConnection() throws {
        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent("lsqlite-filename.sqlite")
        defer {
            try? FileManager.default.removeItem(at: fileURL)
        }
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .init(rawValue: fileURL.path), withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        let filename = connection.filename(forDatabaseNamed: "main")
        #expect(filename != nil)
        #expect(filename?.isEmpty == false)
        _ = connection.close()
    }
}
