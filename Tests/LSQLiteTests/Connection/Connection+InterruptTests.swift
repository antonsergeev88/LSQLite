import LSQLite
import Testing

@Suite("Connection+Interrupt")
struct ConnectionInterruptTests {
    @Test("interrupt can be called on open connection")
    func interruptCanBeCalledOnOpenConnection() throws {
        let connection: Connection = try {
            var connection: Connection?
            try #require(Connection.open(&connection, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
            return try #require(connection)
        }()
        connection.interrupt()
        _ = connection.close()
    }
}
