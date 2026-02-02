import LSQLite
import LSQLiteExtensions
import Testing

@Suite("Connection+Schema")
final class ConnectionSchemaTests {
    private let connection: Connection

    init() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        self.connection = connection
        try #require(connection.exec("CREATE TABLE people(id INTEGER PRIMARY KEY, name TEXT);") == .ok)
        try #require(connection.exec("CREATE VIEW people_view AS SELECT name FROM people;") == .ok)
        try #require(connection.exec("CREATE INDEX people_name_index ON people(name);") == .ok)
        try #require(connection.exec("CREATE TRIGGER people_insert AFTER INSERT ON people BEGIN SELECT 1; END;") == .ok)
    }

    deinit {
        _ = connection.close()
    }

    @Test("tables are discoverable")
    func tablesAreDiscoverable() {
        let result = connection.tables()
        #expect(result.0 == .done)
        #expect(result.1.contains(where: { $0.name == "people" }))
    }

    @Test("views are discoverable")
    func viewsAreDiscoverable() {
        let result = connection.views()
        #expect(result.0 == .done)
        #expect(result.1.contains(where: { $0.name == "people_view" }))
    }

    @Test("indexes are discoverable")
    func indexesAreDiscoverable() {
        let result = connection.indexes()
        #expect(result.0 == .done)
        #expect(result.1.contains(where: { $0.name == "people_name_index" }))
    }

    @Test("triggers are discoverable")
    func triggersAreDiscoverable() {
        let result = connection.triggers()
        #expect(result.0 == .done)
        #expect(result.1.contains(where: { $0.name == "people_insert" }))
    }
}
