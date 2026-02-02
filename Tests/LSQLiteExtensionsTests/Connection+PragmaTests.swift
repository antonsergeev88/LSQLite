import LSQLite
import LSQLiteExtensions
import Testing

@Suite("Connection+Pragma")
final class ConnectionPragmaTests {
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

    @Test("user version round-trips")
    func userVersionRoundTrips() throws {
        #expect(connection.setUserVersion(42) == .done)
        let result = connection.userVersion()
        #expect(result.0 == .done)
        let value = try #require(result.1)
        #expect(value == 42)
    }

    @Test("application id round-trips")
    func applicationIdRoundTrips() throws {
        #expect(connection.setApplicationId(1337) == .done)
        let result = connection.applicationId()
        #expect(result.0 == .done)
        let value = try #require(result.1)
        #expect(value == 1337)
    }

    @Test("foreign keys toggles")
    func foreignKeysToggles() throws {
        #expect(connection.setForeignKeysEnabled(true) == .done)
        let enabled = connection.foreignKeysEnabled()
        #expect(enabled.0 == .done)
        let enabledValue = try #require(enabled.1)
        #expect(enabledValue)

        #expect(connection.setForeignKeysEnabled(false) == .done)
        let disabled = connection.foreignKeysEnabled()
        #expect(disabled.0 == .done)
        let disabledValue = try #require(disabled.1)
        #expect(!disabledValue)
    }

    @Test("journal mode reads and sets")
    func journalModeReadsAndSets() throws {
        let read = connection.journalMode()
        #expect(read.0 == .done)
        _ = try #require(read.1)

        let set = connection.setJournalMode(.memory)
        #expect(set.0 == .done)
        let mode = try #require(set.1)
        #expect(mode.rawValue == Connection.JournalMode.memory.rawValue)
    }

    @Test("synchronous mode round-trips")
    func synchronousModeRoundTrips() throws {
        #expect(connection.setSynchronousMode(.normal) == .done)
        let read = connection.synchronousMode()
        #expect(read.0 == .done)
        let mode = try #require(read.1)
        #expect(mode.rawValue == Connection.SynchronousMode.normal.rawValue)
    }

    @Test("busy timeout round-trips")
    func busyTimeoutRoundTrips() throws {
        #expect(connection.setBusyTimeout(250) == .done)
        let read = connection.busyTimeout()
        #expect(read.0 == .done)
        let value = try #require(read.1)
        #expect(value == 250)
    }

    @Test("temp store round-trips")
    func tempStoreRoundTrips() throws {
        #expect(connection.setTempStore(.memory) == .done)
        let read = connection.tempStore()
        #expect(read.0 == .done)
        let mode = try #require(read.1)
        #expect(mode.rawValue == Connection.TempStore.memory.rawValue)
    }

    @Test("cache size round-trips")
    func cacheSizeRoundTrips() throws {
        #expect(connection.setCacheSize(128) == .done)
        let read = connection.cacheSize()
        #expect(read.0 == .done)
        let value = try #require(read.1)
        #expect(value == 128)
    }

    @Test("mmap size round-trips")
    func mmapSizeRoundTrips() throws {
        #expect(connection.setMmapSize(0) == .done)
        let read = connection.mmapSize()
        #expect(read.0 == .done)
        if let value = read.1 {
            #expect(value == 0)
        }
    }

    @Test("locking mode reads and sets")
    func lockingModeReadsAndSets() throws {
        let read = connection.lockingMode()
        #expect(read.0 == .done)
        _ = try #require(read.1)

        let set = connection.setLockingMode(.normal)
        #expect(set.0 == .done)
        _ = try #require(set.1)
    }

    @Test("auto vacuum reads")
    func autoVacuumReads() throws {
        let read = connection.autoVacuum()
        #expect(read.0 == .done)
        _ = try #require(read.1)
    }

    @Test("incremental vacuum completes")
    func incrementalVacuumCompletes() throws {
        #expect(connection.incrementalVacuum() == .done)
    }

    @Test("integrity check reports ok")
    func integrityCheckReportsOk() throws {
        let result = connection.integrityCheck()
        #expect(result.0 == .done)
        let message = try #require(result.1.first)
        #expect(message == "ok")
    }

    @Test("quick check reports ok")
    func quickCheckReportsOk() throws {
        let result = connection.quickCheck()
        #expect(result.0 == .done)
        let message = try #require(result.1.first)
        #expect(message == "ok")
    }

    @Test("compile options returns values")
    func compileOptionsReturnsValues() throws {
        let result = connection.compileOptions()
        #expect(result.0 == .done)
        #expect(!result.1.isEmpty)
    }

    @Test("page size reads")
    func pageSizeReads() throws {
        let result = connection.pageSize()
        #expect(result.0 == .done)
        _ = try #require(result.1)
    }

    @Test("schema pragmas return metadata")
    func schemaPragmasReturnMetadata() throws {
        #expect(connection.exec("CREATE TABLE parent(id INTEGER PRIMARY KEY);") == .ok)
        #expect(connection.exec("CREATE TABLE child(id INTEGER PRIMARY KEY, parent_id INTEGER REFERENCES parent(id));") == .ok)
        #expect(connection.exec("CREATE INDEX child_parent_idx ON child(parent_id);") == .ok)

        let tableInfo = connection.tableInfo("child")
        #expect(tableInfo.0 == .done)
        let column = try #require(tableInfo.1.first { $0.name == "parent_id" })
        #expect(column.name == "parent_id")

        let indexList = connection.indexList("child")
        #expect(indexList.0 == .done)
        let indexEntry = try #require(indexList.1.first { $0.name == "child_parent_idx" })
        #expect(indexEntry.isUnique == 0)

        let indexInfo = connection.indexInfo("child_parent_idx")
        #expect(indexInfo.0 == .done)
        let indexColumn = try #require(indexInfo.1.first { $0.name == "parent_id" })
        #expect(indexColumn.name == "parent_id")

        let foreignKeys = connection.foreignKeyList("child")
        #expect(foreignKeys.0 == .done)
        let foreignKey = try #require(foreignKeys.1.first)
        #expect(foreignKey.tableName == "parent")
        #expect(foreignKey.fromColumn == "parent_id")
        #expect(foreignKey.toColumn == "id")
    }
}
