import LSQLite
import Testing

@Suite("Connection+Readonly")
final class ConnectionReadWriteAccessStateRawValueTests {
    private let connection: Connection

    init() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        self.connection = connection
    }

    deinit {
        _ = connection.close()
    }

    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(-7)
        let state = Connection.ReadWriteAccessState(rawValue: rawValue)
        #expect(state.rawValue == rawValue)
    }

    @Test("ReadWriteAccessState descriptions map values")
    func readWriteAccessStateDescriptions() {
        #expect(Connection.ReadWriteAccessState.noDatabase.description == "no database")
        #expect(Connection.ReadWriteAccessState.readwrite.description == "readwrite")
        #expect(Connection.ReadWriteAccessState.readonly.description == "readonly")
        #expect(Connection.ReadWriteAccessState(rawValue: 9).description == "unknown")
        #expect(Connection.ReadWriteAccessState.readwrite.debugDescription == "readwrite (0)")
        #expect(Connection.ReadWriteAccessState(rawValue: 9).debugDescription == "unknown (9)")
    }

    @Test("readWriteAccessState returns status for named connection")
    func readWriteAccessStateReturnsStatusForNamedDatabase() {
        #expect(connection.readWriteAccessState(forDatabaseNamed: "main") == .readwrite)
        #expect(connection.readWriteAccessState(forDatabaseNamed: "missing") == .noDatabase)
    }
}
