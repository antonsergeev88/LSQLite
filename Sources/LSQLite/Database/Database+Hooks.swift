import MissedSwiftSQLite

extension Database {
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
    public typealias UpdateHookHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ updateOperation: Int32, _ databaseName: UnsafePointer<Int8>?, _ tableName: UnsafePointer<Int8>?, _ rowID: sqlite3_int64) -> Void

    /// WAL hook invoked after a write transaction commits when using WAL mode.
    ///
    /// Related SQLite: `sqlite3_wal_hook`
    public typealias WALHookHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ database: OpaquePointer?, _ databaseName: UnsafePointer<Int8>?, _ pageInWALFileCount: Int32) -> Int32

    /// Return codes for commit hooks to continue or force a rollback.
    ///
    /// Related SQLite: `sqlite3_commit_hook`
    @frozen public struct CommitHookHandlerResult: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let `continue` = Self(rawValue: 0)
        public static let `break` = Self(rawValue: 1)

        /// Debug label for the commit hook decision.
        ///
        /// Related SQLite: `sqlite3_commit_hook`
        public var debugDescription: String {
            switch self {
            case .continue: return "LSQLITE_CONTINUE"
            case .break: return "LSQLITE_BREAK"
            default: return "CommitHookHandlerResult(rawValue: \(rawValue))"
            }
        }
    }

    /// Operation types reported to `updateHook`.
    ///
    /// Related SQLite: `sqlite3_update_hook`, `SQLITE_INSERT`, `SQLITE_DELETE`, `SQLITE_UPDATE`
    @frozen public struct UpdateOperation: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let delete = Self(rawValue: SQLITE_DELETE)
        public static let insert = Self(rawValue: SQLITE_INSERT)
        public static let update = Self(rawValue: SQLITE_UPDATE)

        /// Debug label for the update operation.
        ///
        /// Related SQLite: `sqlite3_update_hook`, `SQLITE_INSERT`, `SQLITE_DELETE`, `SQLITE_UPDATE`
        public var debugDescription: String {
            switch self {
            case .delete: return "SQLITE_DELETE"
            case .insert: return "SQLITE_INSERT"
            case .update: return "SQLITE_UPDATE"
            default: return "UpdateOperation(rawValue: \(rawValue))"
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
