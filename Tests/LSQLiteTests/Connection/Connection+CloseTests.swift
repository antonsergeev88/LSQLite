import LSQLite
import Testing

@Suite("Connection+Close")
struct ConnectionCloseTests {
    @Test("close returns ok for open connection")
    func closeReturnsOk() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        #expect(connection.close() == .ok)
    }

    @Test("closeV2 returns ok for open connection")
    @available(iOS 8.2, macOS 10.10, tvOS 8.2, watchOS 2.0, *)
    func closeV2ReturnsOk() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        #expect(connection.closeV2() == .ok)
    }
}
