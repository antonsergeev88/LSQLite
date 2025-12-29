import LSQLite
import Testing

@Suite("Connection+Error")
final class ConnectionExtendedResultCodeStatusRawValueTests {
    private let connection: Connection

    init() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        self.connection = connection
        try #require(connection.exec("CREATE TABLE items(id INTEGER)") == .ok)
    }

    deinit {
        _ = connection.close()
    }

    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(42)
        let status = Connection.ExtendedResultCodeStatus(rawValue: rawValue)
        #expect(status.rawValue == rawValue)
    }

    @Test("ExtendedResultCodeStatus descriptions map values")
    func extendedResultCodeStatusDescriptions() {
        #expect(Connection.ExtendedResultCodeStatus.off.description == "off")
        #expect(Connection.ExtendedResultCodeStatus.on.description == "on")
        #expect(Connection.ExtendedResultCodeStatus(rawValue: 3).description == "unknown")
        #expect(Connection.ExtendedResultCodeStatus.on.debugDescription == "on (1)")
        #expect(Connection.ExtendedResultCodeStatus(rawValue: 3).debugDescription == "unknown (3)")
    }

    @Test("last error fields update after a failure")
    func lastErrorFieldsUpdateAfterFailure() throws {
        #expect(connection.exec("INSERT INTO missing_table VALUES (1)") == .error)
        #expect(connection.lastErrorCode == .error)
        #expect(connection.lastExtendedErrorCode == .error)
        #expect(!connection.lastErrorMessage.isEmpty)
    }

    @Test("setExtendedResultCodes toggles status")
    func setExtendedResultCodesTogglesStatus() {
        #expect(connection.setExtendedResultCodes(.on) == .ok)
        #expect(connection.setExtendedResultCodes(.off) == .ok)
    }
}
