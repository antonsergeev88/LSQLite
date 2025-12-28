import LSQLite
import Testing

@Suite("Database+Interrupt")
struct DatabaseInterruptTests {
    @Test("interrupt can be called on open database")
    func interruptCanBeCalledOnOpenDatabase() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)
        openDatabase.interrupt()
        _ = openDatabase.close()
    }
}
