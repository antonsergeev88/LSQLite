import LSQLite
import Testing

@Suite("Database+Close")
struct DatabaseCloseTests {
    @Test("close returns ok for open database")
    func closeReturnsOk() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)
        #expect(openDatabase.close() == .ok)
    }

    @Test("closeV2 returns ok for open database")
    @available(iOS 8.2, macOS 10.10, tvOS 8.2, watchOS 2.0, *)
    func closeV2ReturnsOk() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)
        #expect(openDatabase.closeV2() == .ok)
    }
}
