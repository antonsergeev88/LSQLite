import LSQLite

extension Connection {
    /// Modes that control the rollback journal behavior.
    ///
    /// Related SQLite: `PRAGMA journal_mode`
    @frozen public struct JournalMode: Hashable, RawRepresentable {
        public let rawValue: String

        @inlinable public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Use rollback journaling with delete-on-commit behavior.
        ///
        /// Related SQLite: `PRAGMA journal_mode`
        public static let delete = Self(rawValue: "delete")

        /// Use rollback journaling and truncate the journal at commit.
        ///
        /// Related SQLite: `PRAGMA journal_mode`
        public static let truncate = Self(rawValue: "truncate")

        /// Use rollback journaling with persistent journal files.
        ///
        /// Related SQLite: `PRAGMA journal_mode`
        public static let persist = Self(rawValue: "persist")

        /// Use in-memory rollback journaling.
        ///
        /// Related SQLite: `PRAGMA journal_mode`
        public static let memory = Self(rawValue: "memory")

        /// Use write-ahead logging.
        ///
        /// Related SQLite: `PRAGMA journal_mode`
        public static let wal = Self(rawValue: "wal")

        /// Disable rollback journaling.
        ///
        /// Related SQLite: `PRAGMA journal_mode`
        public static let off = Self(rawValue: "off")
    }

    /// Synchronization settings for commits and checkpoints.
    ///
    /// Related SQLite: `PRAGMA synchronous`
    @frozen public struct SynchronousMode: Hashable, RawRepresentable {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        /// No synchronization beyond OS defaults.
        ///
        /// Related SQLite: `PRAGMA synchronous`
        public static let off = Self(rawValue: 0)

        /// Full synchronization for device buffers.
        ///
        /// Related SQLite: `PRAGMA synchronous`
        public static let normal = Self(rawValue: 1)

        /// Full synchronization for device and filesystem buffers.
        ///
        /// Related SQLite: `PRAGMA synchronous`
        public static let full = Self(rawValue: 2)

        /// Extra synchronization between device and filesystem buffers.
        ///
        /// Related SQLite: `PRAGMA synchronous`
        public static let extra = Self(rawValue: 3)
    }

    /// Temporary storage modes.
    ///
    /// Related SQLite: `PRAGMA temp_store`
    @frozen public struct TempStore: Hashable, RawRepresentable {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        /// Use the default storage mode.
        ///
        /// Related SQLite: `PRAGMA temp_store`
        public static let `default` = Self(rawValue: 0)

        /// Store temporary tables and indices in files.
        ///
        /// Related SQLite: `PRAGMA temp_store`
        public static let file = Self(rawValue: 1)

        /// Store temporary tables and indices in memory.
        ///
        /// Related SQLite: `PRAGMA temp_store`
        public static let memory = Self(rawValue: 2)
    }

    /// Locking modes for the database connection.
    ///
    /// Related SQLite: `PRAGMA locking_mode`
    @frozen public struct LockingMode: Hashable, RawRepresentable {
        public let rawValue: String

        @inlinable public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Allow shared read/write access.
        ///
        /// Related SQLite: `PRAGMA locking_mode`
        public static let normal = Self(rawValue: "normal")

        /// Keep the database file locked for the lifetime of the connection.
        ///
        /// Related SQLite: `PRAGMA locking_mode`
        public static let exclusive = Self(rawValue: "exclusive")
    }

    /// Automatic vacuum configuration.
    ///
    /// Related SQLite: `PRAGMA auto_vacuum`
    @frozen public struct AutoVacuumMode: Hashable, RawRepresentable {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        /// No automatic vacuuming.
        ///
        /// Related SQLite: `PRAGMA auto_vacuum`
        public static let none = Self(rawValue: 0)

        /// Full auto-vacuum mode.
        ///
        /// Related SQLite: `PRAGMA auto_vacuum`
        public static let full = Self(rawValue: 1)

        /// Incremental auto-vacuum mode.
        ///
        /// Related SQLite: `PRAGMA auto_vacuum`
        public static let incremental = Self(rawValue: 2)
    }

    /// Row describing a table column.
    ///
    /// Related SQLite: `PRAGMA table_info`
    @frozen public struct TableInfo: Hashable, Decodable {
        public let columnId: Int
        public let name: String
        public let declaredType: String
        public let notNull: Int
        public let defaultValue: String?
        public let primaryKey: Int

        private enum CodingKeys: String, CodingKey {
            case columnId = "cid"
            case name
            case declaredType = "type"
            case notNull = "notnull"
            case defaultValue = "dflt_value"
            case primaryKey = "pk"
        }
    }

    /// Row describing an index on a table.
    ///
    /// Related SQLite: `PRAGMA index_list`
    @frozen public struct IndexListEntry: Hashable, Decodable {
        public let sequence: Int
        public let name: String
        public let isUnique: Int
        public let origin: String
        public let isPartial: Int

        private enum CodingKeys: String, CodingKey {
            case sequence = "seq"
            case name
            case isUnique = "unique"
            case origin
            case isPartial = "partial"
        }
    }

    /// Row describing columns in an index.
    ///
    /// Related SQLite: `PRAGMA index_info`
    @frozen public struct IndexInfo: Hashable, Decodable {
        public let sequence: Int
        public let columnId: Int
        public let name: String?

        private enum CodingKeys: String, CodingKey {
            case sequence = "seqno"
            case columnId = "cid"
            case name
        }
    }

    /// Row describing a foreign key constraint.
    ///
    /// Related SQLite: `PRAGMA foreign_key_list`
    @frozen public struct ForeignKeyListEntry: Hashable, Decodable {
        public let id: Int
        public let sequence: Int
        public let tableName: String
        public let fromColumn: String
        public let toColumn: String
        public let onUpdate: String
        public let onDelete: String
        public let match: String

        private enum CodingKeys: String, CodingKey {
            case id
            case sequence = "seq"
            case tableName = "table"
            case fromColumn = "from"
            case toColumn = "to"
            case onUpdate = "on_update"
            case onDelete = "on_delete"
            case match
        }
    }

    /// Reads the current journal mode.
    /// - Parameter databaseName: Optional database name qualifier.
    /// - Returns: A result code and the current mode when available.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not text.
    ///
    /// Related SQLite: `PRAGMA journal_mode`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_text`, `sqlite3_column_type`, `sqlite3_finalize`
    public func journalMode(databaseName: String? = nil) -> (ResultCode, JournalMode?) {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).journal_mode"
        } else {
            sql = "PRAGMA journal_mode"
        }
        let result = pragmaText(sql)
        return (result.0, result.1.map { JournalMode(rawValue: $0.lowercased()) })
    }

    /// Sets the journal mode.
    /// - Parameters:
    ///   - mode: Mode to request.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: A result code and the resulting mode when available.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not text.
    ///
    /// Related SQLite: `PRAGMA journal_mode`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_text`, `sqlite3_column_type`, `sqlite3_finalize`
    public func setJournalMode(_ mode: JournalMode, databaseName: String? = nil) -> (ResultCode, JournalMode?) {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).journal_mode = \(mode.rawValue)"
        } else {
            sql = "PRAGMA journal_mode = \(mode.rawValue)"
        }
        let result = pragmaText(sql)
        return (result.0, result.1.map { JournalMode(rawValue: $0.lowercased()) })
    }

    /// Reads the current synchronization mode.
    /// - Parameter databaseName: Optional database name qualifier.
    /// - Returns: A result code and the current mode when available.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not an integer.
    ///
    /// Related SQLite: `PRAGMA synchronous`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_int`, `sqlite3_column_type`, `sqlite3_finalize`
    public func synchronousMode(databaseName: String? = nil) -> (ResultCode, SynchronousMode?) {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).synchronous"
        } else {
            sql = "PRAGMA synchronous"
        }
        let result = pragmaInt32(sql)
        return (result.0, result.1.map { SynchronousMode(rawValue: $0) })
    }

    /// Sets the synchronization mode.
    /// - Parameters:
    ///   - mode: Mode to store.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: Result code from stepping the statement.
    ///
    /// Returns `.misuse` when a row is produced.
    ///
    /// Related SQLite: `PRAGMA synchronous`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_finalize`
    public func setSynchronousMode(_ mode: SynchronousMode, databaseName: String? = nil) -> ResultCode {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).synchronous = \(mode.rawValue)"
        } else {
            sql = "PRAGMA synchronous = \(mode.rawValue)"
        }
        return pragmaNoRow(sql)
    }

    /// Reads whether foreign key enforcement is enabled.
    /// - Returns: A result code and the current enabled state when available.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not an integer.
    ///
    /// Related SQLite: `PRAGMA foreign_keys`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_int`, `sqlite3_column_type`, `sqlite3_finalize`
    public func foreignKeysEnabled() -> (ResultCode, Bool?) {
        let result = pragmaInt32("PRAGMA foreign_keys")
        return (result.0, result.1.map { $0 != 0 })
    }

    /// Enables or disables foreign key enforcement.
    /// - Parameter enabled: Whether to enable enforcement.
    /// - Returns: Result code from stepping the statement.
    ///
    /// Returns `.misuse` when a row is produced.
    ///
    /// Related SQLite: `PRAGMA foreign_keys`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_finalize`
    public func setForeignKeysEnabled(_ enabled: Bool) -> ResultCode {
        let value = enabled ? 1 : 0
        return pragmaNoRow("PRAGMA foreign_keys = \(value)")
    }

    /// Reads the busy timeout in milliseconds.
    /// - Returns: A result code and the current timeout when available.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not an integer.
    ///
    /// Related SQLite: `PRAGMA busy_timeout`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_int`, `sqlite3_column_type`, `sqlite3_finalize`
    public func busyTimeout() -> (ResultCode, Int32?) {
        pragmaInt32("PRAGMA busy_timeout")
    }

    /// Sets the busy timeout in milliseconds.
    /// - Parameter milliseconds: Timeout to store.
    /// - Returns: Result code from stepping the statement.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not an integer.
    ///
    /// Related SQLite: `PRAGMA busy_timeout`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_int`, `sqlite3_column_type`, `sqlite3_finalize`
    public func setBusyTimeout(_ milliseconds: Int32) -> ResultCode {
        pragmaInt32("PRAGMA busy_timeout = \(milliseconds)").0
    }

    /// Reads the temporary storage mode.
    /// - Returns: A result code and the current mode when available.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not an integer.
    ///
    /// Related SQLite: `PRAGMA temp_store`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_int`, `sqlite3_column_type`, `sqlite3_finalize`
    public func tempStore() -> (ResultCode, TempStore?) {
        let result = pragmaInt32("PRAGMA temp_store")
        return (result.0, result.1.map { TempStore(rawValue: $0) })
    }

    /// Sets the temporary storage mode.
    /// - Parameter mode: Mode to store.
    /// - Returns: Result code from stepping the statement.
    ///
    /// Returns `.misuse` when a row is produced.
    ///
    /// Related SQLite: `PRAGMA temp_store`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_finalize`
    public func setTempStore(_ mode: TempStore) -> ResultCode {
        pragmaNoRow("PRAGMA temp_store = \(mode.rawValue)")
    }

    /// Reads the cache size in pages.
    /// - Parameter databaseName: Optional database name qualifier.
    /// - Returns: A result code and the current cache size when available.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not an integer.
    ///
    /// Related SQLite: `PRAGMA cache_size`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_int`, `sqlite3_column_type`, `sqlite3_finalize`
    public func cacheSize(databaseName: String? = nil) -> (ResultCode, Int32?) {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).cache_size"
        } else {
            sql = "PRAGMA cache_size"
        }
        return pragmaInt32(sql)
    }

    /// Sets the cache size in pages.
    /// - Parameters:
    ///   - value: Cache size to store.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: Result code from stepping the statement.
    ///
    /// Returns `.misuse` when a row is produced.
    ///
    /// Related SQLite: `PRAGMA cache_size`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_finalize`
    public func setCacheSize(_ value: Int32, databaseName: String? = nil) -> ResultCode {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).cache_size = \(value)"
        } else {
            sql = "PRAGMA cache_size = \(value)"
        }
        return pragmaNoRow(sql)
    }

    /// Reads the maximum memory mapping size in bytes.
    /// - Parameter databaseName: Optional database name qualifier.
    /// - Returns: A result code and the current size when available.
    ///
    /// Returns `.misuse` when more than one row is produced or when the value is not an integer.
    /// Returns `.done` with a nil value when the pragma produces no rows.
    ///
    /// Related SQLite: `PRAGMA mmap_size`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_int64`, `sqlite3_column_type`, `sqlite3_finalize`
    public func mmapSize(databaseName: String? = nil) -> (ResultCode, Int64?) {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).mmap_size"
        } else {
            sql = "PRAGMA mmap_size"
        }
        return pragmaInt64(sql, allowNoRow: true)
    }

    /// Sets the maximum memory mapping size in bytes.
    /// - Parameters:
    ///   - value: Size to store.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: Result code from stepping the statement.
    ///
    /// Returns `.misuse` when a row is produced.
    ///
    /// Related SQLite: `PRAGMA mmap_size`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_finalize`
    public func setMmapSize(_ value: Int64, databaseName: String? = nil) -> ResultCode {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).mmap_size = \(value)"
        } else {
            sql = "PRAGMA mmap_size = \(value)"
        }
        return pragmaNoRow(sql)
    }

    /// Reads the locking mode for the database.
    /// - Parameter databaseName: Optional database name qualifier.
    /// - Returns: A result code and the current mode when available.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not text.
    ///
    /// Related SQLite: `PRAGMA locking_mode`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_text`, `sqlite3_column_type`, `sqlite3_finalize`
    public func lockingMode(databaseName: String? = nil) -> (ResultCode, LockingMode?) {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).locking_mode"
        } else {
            sql = "PRAGMA locking_mode"
        }
        let result = pragmaText(sql)
        return (result.0, result.1.map { LockingMode(rawValue: $0.lowercased()) })
    }

    /// Sets the locking mode for the database.
    /// - Parameters:
    ///   - mode: Mode to request.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: A result code and the resulting mode when available.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not text.
    ///
    /// Related SQLite: `PRAGMA locking_mode`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_text`, `sqlite3_column_type`, `sqlite3_finalize`
    public func setLockingMode(_ mode: LockingMode, databaseName: String? = nil) -> (ResultCode, LockingMode?) {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).locking_mode = \(mode.rawValue)"
        } else {
            sql = "PRAGMA locking_mode = \(mode.rawValue)"
        }
        let result = pragmaText(sql)
        return (result.0, result.1.map { LockingMode(rawValue: $0.lowercased()) })
    }

    /// Reads the user version value.
    /// - Parameter databaseName: Optional database name qualifier.
    /// - Returns: A result code and the current value when available.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not an integer.
    ///
    /// Related SQLite: `PRAGMA user_version`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_int`, `sqlite3_column_type`, `sqlite3_finalize`
    public func userVersion(databaseName: String? = nil) -> (ResultCode, Int32?) {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).user_version"
        } else {
            sql = "PRAGMA user_version"
        }
        return pragmaInt32(sql)
    }

    /// Sets the user version value.
    /// - Parameters:
    ///   - value: Value to store.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: Result code from stepping the statement.
    ///
    /// Returns `.misuse` when a row is produced.
    ///
    /// Related SQLite: `PRAGMA user_version`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_finalize`
    public func setUserVersion(_ value: Int32, databaseName: String? = nil) -> ResultCode {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).user_version = \(value)"
        } else {
            sql = "PRAGMA user_version = \(value)"
        }
        return pragmaNoRow(sql)
    }

    /// Reads the application identifier value.
    /// - Parameter databaseName: Optional database name qualifier.
    /// - Returns: A result code and the current value when available.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not an integer.
    ///
    /// Related SQLite: `PRAGMA application_id`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_int`, `sqlite3_column_type`, `sqlite3_finalize`
    public func applicationId(databaseName: String? = nil) -> (ResultCode, Int32?) {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).application_id"
        } else {
            sql = "PRAGMA application_id"
        }
        return pragmaInt32(sql)
    }

    /// Sets the application identifier value.
    /// - Parameters:
    ///   - value: Value to store.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: Result code from stepping the statement.
    ///
    /// Returns `.misuse` when a row is produced.
    ///
    /// Related SQLite: `PRAGMA application_id`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_finalize`
    public func setApplicationId(_ value: Int32, databaseName: String? = nil) -> ResultCode {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).application_id = \(value)"
        } else {
            sql = "PRAGMA application_id = \(value)"
        }
        return pragmaNoRow(sql)
    }

    /// Runs a full integrity check.
    /// - Parameters:
    ///   - maximumErrors: Optional maximum number of errors to report.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: A result code and reported messages.
    ///
    /// Related SQLite: `PRAGMA integrity_check`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_text`, `sqlite3_column_type`, `sqlite3_finalize`
    public func integrityCheck(maximumErrors: Int32? = nil, databaseName: String? = nil) -> (ResultCode, [String]) {
        let sql: String
        if let databaseName {
            if let maximumErrors {
                sql = "PRAGMA \(quotedIdentifier(databaseName)).integrity_check(\(maximumErrors))"
            } else {
                sql = "PRAGMA \(quotedIdentifier(databaseName)).integrity_check"
            }
        } else if let maximumErrors {
            sql = "PRAGMA integrity_check(\(maximumErrors))"
        } else {
            sql = "PRAGMA integrity_check"
        }
        return pragmaTextList(sql)
    }

    /// Runs a quick integrity check.
    /// - Parameters:
    ///   - maximumErrors: Optional maximum number of errors to report.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: A result code and reported messages.
    ///
    /// Related SQLite: `PRAGMA quick_check`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_text`, `sqlite3_column_type`, `sqlite3_finalize`
    public func quickCheck(maximumErrors: Int32? = nil, databaseName: String? = nil) -> (ResultCode, [String]) {
        let sql: String
        if let databaseName {
            if let maximumErrors {
                sql = "PRAGMA \(quotedIdentifier(databaseName)).quick_check(\(maximumErrors))"
            } else {
                sql = "PRAGMA \(quotedIdentifier(databaseName)).quick_check"
            }
        } else if let maximumErrors {
            sql = "PRAGMA quick_check(\(maximumErrors))"
        } else {
            sql = "PRAGMA quick_check"
        }
        return pragmaTextList(sql)
    }

    /// Reads the auto-vacuum mode.
    /// - Parameter databaseName: Optional database name qualifier.
    /// - Returns: A result code and the current mode when available.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not an integer.
    ///
    /// Related SQLite: `PRAGMA auto_vacuum`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_int`, `sqlite3_column_type`, `sqlite3_finalize`
    public func autoVacuum(databaseName: String? = nil) -> (ResultCode, AutoVacuumMode?) {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).auto_vacuum"
        } else {
            sql = "PRAGMA auto_vacuum"
        }
        let result = pragmaInt32(sql)
        return (result.0, result.1.map { AutoVacuumMode(rawValue: $0) })
    }

    /// Sets the auto-vacuum mode.
    /// - Parameters:
    ///   - mode: Mode to store.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: Result code from stepping the statement.
    ///
    /// Returns `.misuse` when a row is produced.
    ///
    /// Related SQLite: `PRAGMA auto_vacuum`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_finalize`
    public func setAutoVacuum(_ mode: AutoVacuumMode, databaseName: String? = nil) -> ResultCode {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).auto_vacuum = \(mode.rawValue)"
        } else {
            sql = "PRAGMA auto_vacuum = \(mode.rawValue)"
        }
        return pragmaNoRow(sql)
    }

    /// Runs an incremental vacuum operation.
    /// - Parameters:
    ///   - pageCount: Optional number of pages to vacuum.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: Result code from stepping the statement.
    ///
    /// Returns `.misuse` when a row is produced.
    ///
    /// Related SQLite: `PRAGMA incremental_vacuum`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_finalize`
    public func incrementalVacuum(pageCount: Int32? = nil, databaseName: String? = nil) -> ResultCode {
        let sql: String
        if let databaseName {
            if let pageCount {
                sql = "PRAGMA \(quotedIdentifier(databaseName)).incremental_vacuum(\(pageCount))"
            } else {
                sql = "PRAGMA \(quotedIdentifier(databaseName)).incremental_vacuum"
            }
        } else if let pageCount {
            sql = "PRAGMA incremental_vacuum(\(pageCount))"
        } else {
            sql = "PRAGMA incremental_vacuum"
        }
        return pragmaNoRow(sql)
    }

    /// Reads table column metadata.
    /// - Parameters:
    ///   - tableName: Table name to inspect.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: A result code and the returned rows.
    ///
    /// Related SQLite: `PRAGMA table_info`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_name`, `sqlite3_column_int64`, `sqlite3_column_text`, `sqlite3_finalize`
    public func tableInfo(_ tableName: String, databaseName: String? = nil) -> (ResultCode, [TableInfo]) {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).table_info(\(quotedIdentifier(tableName)))"
        } else {
            sql = "PRAGMA table_info(\(quotedIdentifier(tableName)))"
        }
        return query(sql, rows: TableInfo.self)
    }

    /// Reads index metadata for a table.
    /// - Parameters:
    ///   - tableName: Table name to inspect.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: A result code and the returned rows.
    ///
    /// Related SQLite: `PRAGMA index_list`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_name`, `sqlite3_column_int64`, `sqlite3_column_text`, `sqlite3_finalize`
    public func indexList(_ tableName: String, databaseName: String? = nil) -> (ResultCode, [IndexListEntry]) {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).index_list(\(quotedIdentifier(tableName)))"
        } else {
            sql = "PRAGMA index_list(\(quotedIdentifier(tableName)))"
        }
        return query(sql, rows: IndexListEntry.self)
    }

    /// Reads index column metadata.
    /// - Parameters:
    ///   - indexName: Index name to inspect.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: A result code and the returned rows.
    ///
    /// Related SQLite: `PRAGMA index_info`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_name`, `sqlite3_column_int64`, `sqlite3_column_text`, `sqlite3_finalize`
    public func indexInfo(_ indexName: String, databaseName: String? = nil) -> (ResultCode, [IndexInfo]) {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).index_info(\(quotedIdentifier(indexName)))"
        } else {
            sql = "PRAGMA index_info(\(quotedIdentifier(indexName)))"
        }
        return query(sql, rows: IndexInfo.self)
    }

    /// Reads foreign key metadata for a table.
    /// - Parameters:
    ///   - tableName: Table name to inspect.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: A result code and the returned rows.
    ///
    /// Related SQLite: `PRAGMA foreign_key_list`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_name`, `sqlite3_column_int64`, `sqlite3_column_text`, `sqlite3_finalize`
    public func foreignKeyList(_ tableName: String, databaseName: String? = nil) -> (ResultCode, [ForeignKeyListEntry]) {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).foreign_key_list(\(quotedIdentifier(tableName)))"
        } else {
            sql = "PRAGMA foreign_key_list(\(quotedIdentifier(tableName)))"
        }
        return query(sql, rows: ForeignKeyListEntry.self)
    }

    /// Reads compile-time options used to build SQLite.
    /// - Returns: A result code and the returned options.
    ///
    /// Related SQLite: `PRAGMA compile_options`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_text`, `sqlite3_column_type`, `sqlite3_finalize`
    public func compileOptions() -> (ResultCode, [String]) {
        pragmaTextList("PRAGMA compile_options")
    }

    /// Reads the database page size in bytes.
    /// - Parameter databaseName: Optional database name qualifier.
    /// - Returns: A result code and the current page size when available.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not an integer.
    ///
    /// Related SQLite: `PRAGMA page_size`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_int`, `sqlite3_column_type`, `sqlite3_finalize`
    public func pageSize(databaseName: String? = nil) -> (ResultCode, Int32?) {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).page_size"
        } else {
            sql = "PRAGMA page_size"
        }
        return pragmaInt32(sql)
    }

    /// Sets the database page size in bytes.
    /// - Parameters:
    ///   - value: Page size to store.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: Result code from stepping the statement.
    ///
    /// Returns `.misuse` when a row is produced.
    ///
    /// Related SQLite: `PRAGMA page_size`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_finalize`
    public func setPageSize(_ value: Int32, databaseName: String? = nil) -> ResultCode {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).page_size = \(value)"
        } else {
            sql = "PRAGMA page_size = \(value)"
        }
        return pragmaNoRow(sql)
    }
}

private extension Connection {
    func pragmaNoRow(_ sql: String) -> ResultCode {
        var statement: Statement?
        let prepareResult = Statement.prepare(&statement, sql: sql, for: self)
        guard let prepared = statement else {
            return prepareResult
        }
        defer { _ = prepared.finalize() }
        guard prepareResult == .ok else {
            return prepareResult
        }
        let stepResult = prepared.step()
        guard stepResult != .row else {
            return .misuse
        }
        return stepResult
    }

    func pragmaInt32(_ sql: String) -> (ResultCode, Int32?) {
        pragmaScalar(sql) { statement in
            guard statement.columnType(at: 0) == .integer else {
                return nil
            }
            return statement.columnInt(at: 0)
        }
    }

    func pragmaInt64(_ sql: String, allowNoRow: Bool = false) -> (ResultCode, Int64?) {
        pragmaScalar(sql, allowNoRow: allowNoRow) { statement in
            guard statement.columnType(at: 0) == .integer else {
                return nil
            }
            return statement.columnInt64(at: 0)
        }
    }

    func pragmaText(_ sql: String) -> (ResultCode, String?) {
        pragmaScalar(sql) { statement in
            guard statement.columnType(at: 0) == .text else {
                return nil
            }
            return statement.columnText(at: 0)
        }
    }

    func pragmaTextList(_ sql: String) -> (ResultCode, [String]) {
        var statement: Statement?
        let prepareResult = Statement.prepare(&statement, sql: sql, for: self)
        guard let prepared = statement else {
            return (prepareResult, [])
        }
        defer { _ = prepared.finalize() }
        guard prepareResult == .ok else {
            return (prepareResult, [])
        }
        var values: [String] = []
        while true {
            let stepResult = prepared.step()
            switch stepResult {
            case .row:
                guard prepared.columnType(at: 0) == .text else {
                    return (.misuse, [])
                }
                guard let text = prepared.columnText(at: 0) else {
                    return (.misuse, [])
                }
                values.append(text)
            case .done:
                return (.done, values)
            default:
                return (stepResult, [])
            }
        }
    }

    func pragmaScalar<T>(_ sql: String, allowNoRow: Bool = false, decode: (Statement) -> T?) -> (ResultCode, T?) {
        var statement: Statement?
        let prepareResult = Statement.prepare(&statement, sql: sql, for: self)
        guard let prepared = statement else {
            return (prepareResult, nil)
        }
        defer { _ = prepared.finalize() }
        guard prepareResult == .ok else {
            return (prepareResult, nil)
        }
        let firstStep = prepared.step()
        switch firstStep {
        case .row:
            guard let value = decode(prepared) else {
                return (.misuse, nil)
            }
            let secondStep = prepared.step()
            switch secondStep {
            case .done:
                return (.done, value)
            case .row:
                return (.misuse, nil)
            default:
                return (secondStep, nil)
            }
        case .done:
            return allowNoRow ? (.done, nil) : (.misuse, nil)
        default:
            return (firstStep, nil)
        }
    }
}

private func quotedIdentifier(_ rawValue: String) -> String {
    let escaped = rawValue.replacingOccurrences(of: "\"", with: "\"\"")
    return "\"\(escaped)\""
}
