import MissedSwiftSQLite

extension Connection {
    /// Commit hook invoked before the transaction is finalized; return nonzero to roll back.
    ///
    /// Related SQLite: `sqlite3_commit_hook`
    public typealias CommitHookHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?) -> Int32

    /// Rollback hook invoked when a transaction is rolled back.
    ///
    /// Related SQLite: `sqlite3_rollback_hook`
    public typealias RollbackHookHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?) -> Void

    /// Update hook invoked for row changes on rowid tables.
    ///
    /// Related SQLite: `sqlite3_update_hook`, `SQLITE_INSERT`, `SQLITE_DELETE`, `SQLITE_UPDATE`
    public typealias UpdateHookHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ updateOperation: Int32, _ databaseName: UnsafePointer<Int8>?, _ tableName: UnsafePointer<Int8>?, _ rowID: Int64) -> Void

    /// WAL hook invoked after a write transaction commits when using WAL mode.
    ///
    /// Related SQLite: `sqlite3_wal_hook`
    public typealias WALHookHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ connection: OpaquePointer?, _ databaseName: UnsafePointer<Int8>?, _ pageInWALFileCount: Int32) -> Int32

    /// Return codes for commit hooks to continue or force a rollback.
    ///
    /// Related SQLite: `sqlite3_commit_hook`
    @frozen public struct CommitHookHandlerResult: Hashable, RawRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        /// Allow the commit to proceed.
        ///
        /// Related SQLite: `sqlite3_commit_hook`
        public static let `continue` = Self(rawValue: 0)
        /// Convert the commit into a rollback.
        ///
        /// Related SQLite: `sqlite3_commit_hook`
        public static let `break` = Self(rawValue: 1)

        public var description: String {
            switch self {
            case .continue: "continue"
            case .break: "break"
            default: "unknown"
            }
        }

        public var debugDescription: String {
            "\(description) (\(rawValue.description))"
        }
    }

    /// Operation types reported to `updateHook`.
    ///
    /// Related SQLite: `sqlite3_update_hook`, `SQLITE_INSERT`, `SQLITE_DELETE`, `SQLITE_UPDATE`
    @frozen public struct UpdateOperation: Hashable, RawRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        /// Row delete operation.
        ///
        /// Related SQLite: `SQLITE_DELETE`
        public static let delete = Self(rawValue: SQLITE_DELETE)
        /// Row insert operation.
        ///
        /// Related SQLite: `SQLITE_INSERT`
        public static let insert = Self(rawValue: SQLITE_INSERT)
        /// Row update operation.
        ///
        /// Related SQLite: `SQLITE_UPDATE`
        public static let update = Self(rawValue: SQLITE_UPDATE)

        public var description: String {
            switch self {
            case .delete: "delete"
            case .insert: "insert"
            case .update: "update"
            default: "unknown"
            }
        }

        public var debugDescription: String {
            switch self {
            case .delete: "SQLITE_DELETE"
            case .insert: "SQLITE_INSERT"
            case .update: "SQLITE_UPDATE"
            default: rawValue.description
            }
        }
    }

    /// Registers a commit hook; return `.break` to turn the commit into a rollback.
    /// - Parameters:
    ///   - userData: Custom context passed to the handler.
    ///   - commitHookHandler: Called before commit; `nil` clears the hook.
    /// - Returns: Previous user data pointer.
    ///
    /// Related SQLite: `sqlite3_commit_hook`, `sqlite3_step`, `COMMIT`, `ROLLBACK`
    @inlinable public func commitHook(_ userData: UnsafeMutableRawPointer? = nil, commitHookHandler: CommitHookHandler? = nil) -> UnsafeMutableRawPointer? {
        sqlite3_commit_hook(rawValue, commitHookHandler, userData)
    }

    /// Registers a rollback hook that fires whenever this connection rolls back.
    /// - Parameters:
    ///   - userData: Custom context passed to the handler.
    ///   - rollbackHookHandler: Handler invoked on rollback; `nil` clears the hook.
    /// - Returns: Previous user data pointer.
    ///
    /// Related SQLite: `sqlite3_rollback_hook`, `sqlite3_commit_hook`, `sqlite3_step`
    @inlinable public func rollbackHook(_ userData: UnsafeMutableRawPointer? = nil, rollbackHookHandler: RollbackHookHandler? = nil) -> UnsafeMutableRawPointer? {
        sqlite3_rollback_hook(rawValue, rollbackHookHandler, userData)
    }

    /// Registers a callback for row changes on rowid tables.
    /// - Parameters:
    ///   - userData: Custom context passed to the handler.
    ///   - updateHookHandler: Handler receiving operation, database/table names, and rowid; `nil` clears the hook.
    /// - Returns: Previous user data pointer.
    ///
    /// Related SQLite: `sqlite3_update_hook`, `SQLITE_INSERT`, `SQLITE_DELETE`, `SQLITE_UPDATE`
    @inlinable public func updateHook(_ userData: UnsafeMutableRawPointer? = nil, updateHookHandler: UpdateHookHandler? = nil) -> UnsafeMutableRawPointer? {
        sqlite3_update_hook(rawValue, updateHookHandler, userData)
    }

    /// Registers a callback fired after a WAL commit with the current WAL page count.
    /// - Parameters:
    ///   - userData: Custom context passed to the handler.
    ///   - walHookHandler: Handler invoked post-commit; `nil` clears the hook.
    /// - Returns: Previous user data pointer.
    ///
    /// Related SQLite: `sqlite3_wal_hook`, `sqlite3_wal_autocheckpoint`, `sqlite3_wal_checkpoint_v2`
    @inlinable public func walHook(_ userData: UnsafeMutableRawPointer? = nil, walHookHandler: WALHookHandler? = nil) -> UnsafeMutableRawPointer? {
        sqlite3_wal_hook(rawValue, walHookHandler, userData)
    }
}
