import LSQLite
import LSQLiteExtensions
import Testing

@Suite("Connection+WAL")
final class ConnectionWALTests {
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

    @Test("auto checkpoint reads value")
    func autoCheckpointReadsValue() throws {
        #expect(connection.autoWALCheckpoint(pageInWALFileCount: 1) == .ok)
        let read = connection.autoWALCheckpoint()
        #expect(read.0 == .done)
        let value = try #require(read.1)
        #expect(value == 1)
    }

    @Test("checkpoint returns frame counts")
    func checkpointReturnsFrameCounts() throws {
        let result = connection.walCheckpoint()
        #expect(result.0 == .ok)
        let info = result.1
        #expect(info.frameCount >= -1)
        #expect(info.checkpointedFrameCount >= -1)
    }
}
