import MissedSwiftSQLite

extension Database {
    public typealias CommitHookHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?) -> Int32
    public typealias RollbackHookHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?) -> Void
    public typealias UpdateHookHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ updateOperation: Int32, _ databaseName: UnsafePointer<Int8>?, _ tableName: UnsafePointer<Int8>?, _ rowID: sqlite3_int64) -> Void
    public typealias WALHookHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ database: OpaquePointer?, _ databaseName: UnsafePointer<Int8>?, _ pageInWALFileCount: Int32) -> Int32

    @frozen public struct CommitHookHandlerResult: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let `continue` = Self(rawValue: 0)
        public static let `break` = Self(rawValue: 1)

        public var debugDescription: String {
            switch self {
            case .continue: return "LSQLITE_CONTINUE"
            case .break: return "LSQLITE_BREAK"
            default: return "CommitHookHandlerResult(rawValue: \(rawValue))"
            }
        }
    }

    @frozen public struct UpdateOperation: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let delete = Self(rawValue: SQLITE_DELETE)
        public static let insert = Self(rawValue: SQLITE_INSERT)
        public static let update = Self(rawValue: SQLITE_UPDATE)

        public var debugDescription: String {
            switch self {
            case .delete: return "SQLITE_DELETE"
            case .insert: return "SQLITE_INSERT"
            case .update: return "SQLITE_UPDATE"
            default: return "UpdateOperation(rawValue: \(rawValue))"
            }
        }
    }

    /**
     CAPI3REF: Commit And Rollback Notification Callbacks
     METHOD: sqlite3

     ^The sqlite3_commit_hook() interface registers a callback
     function to be invoked whenever a transaction is [COMMIT | committed].
     ^Any callback set by a previous call to sqlite3_commit_hook()
     for the same database connection is overridden.
     ^The sqlite3_rollback_hook() interface registers a callback
     function to be invoked whenever a transaction is [ROLLBACK | rolled back].
     ^Any callback set by a previous call to sqlite3_rollback_hook()
     for the same database connection is overridden.
     ^The pArg argument is passed through to the callback.
     ^If the callback on a commit hook function returns non-zero,
     then the commit is converted into a rollback.

     ^The sqlite3_commit_hook(D,C,P) and sqlite3_rollback_hook(D,C,P) functions
     return the P argument from the previous call of the same function
     on the same [database connection] D, or NULL for
     the first call for each function on D.

     The commit and rollback hook callbacks are not reentrant.
     The callback implementation must not do anything that will modify
     the database connection that invoked the callback.  Any actions
     to modify the database connection must be deferred until after the
     completion of the [sqlite3_step()] call that triggered the commit
     or rollback hook in the first place.
     Note that running any other SQL statements, including SELECT statements,
     or merely calling [sqlite3_prepare_v2()] and [sqlite3_step()] will modify
     the database connections for the meaning of "modify" in this paragraph.

     ^Registering a NULL function disables the callback.

     ^When the commit hook callback routine returns zero, the [COMMIT]
     operation is allowed to continue normally.  ^If the commit hook
     returns non-zero, then the [COMMIT] is converted into a [ROLLBACK].
     ^The rollback hook is invoked on a rollback that results from a commit
     hook returning non-zero, just as it would be with any other rollback.

     ^For the purposes of this API, a transaction is said to have been
     rolled back if an explicit "ROLLBACK" statement is executed, or
     an error or constraint causes an implicit rollback to occur.
     ^The rollback callback is not invoked if a transaction is
     automatically rolled back because the database connection is closed.

     See also the [sqlite3_update_hook()] interface.
     */
    @inlinable public func commitHook(_ userData: UnsafeMutableRawPointer? = nil, commitHookHandler: CommitHookHandler? = nil) -> UnsafeMutableRawPointer? {
        sqlite3_commit_hook(rawValue, commitHookHandler, userData)
    }

    /**
     CAPI3REF: Commit And Rollback Notification Callbacks
     METHOD: sqlite3

     ^The sqlite3_commit_hook() interface registers a callback
     function to be invoked whenever a transaction is [COMMIT | committed].
     ^Any callback set by a previous call to sqlite3_commit_hook()
     for the same database connection is overridden.
     ^The sqlite3_rollback_hook() interface registers a callback
     function to be invoked whenever a transaction is [ROLLBACK | rolled back].
     ^Any callback set by a previous call to sqlite3_rollback_hook()
     for the same database connection is overridden.
     ^The pArg argument is passed through to the callback.
     ^If the callback on a commit hook function returns non-zero,
     then the commit is converted into a rollback.

     ^The sqlite3_commit_hook(D,C,P) and sqlite3_rollback_hook(D,C,P) functions
     return the P argument from the previous call of the same function
     on the same [database connection] D, or NULL for
     the first call for each function on D.

     The commit and rollback hook callbacks are not reentrant.
     The callback implementation must not do anything that will modify
     the database connection that invoked the callback.  Any actions
     to modify the database connection must be deferred until after the
     completion of the [sqlite3_step()] call that triggered the commit
     or rollback hook in the first place.
     Note that running any other SQL statements, including SELECT statements,
     or merely calling [sqlite3_prepare_v2()] and [sqlite3_step()] will modify
     the database connections for the meaning of "modify" in this paragraph.

     ^Registering a NULL function disables the callback.

     ^When the commit hook callback routine returns zero, the [COMMIT]
     operation is allowed to continue normally.  ^If the commit hook
     returns non-zero, then the [COMMIT] is converted into a [ROLLBACK].
     ^The rollback hook is invoked on a rollback that results from a commit
     hook returning non-zero, just as it would be with any other rollback.

     ^For the purposes of this API, a transaction is said to have been
     rolled back if an explicit "ROLLBACK" statement is executed, or
     an error or constraint causes an implicit rollback to occur.
     ^The rollback callback is not invoked if a transaction is
     automatically rolled back because the database connection is closed.

     See also the [sqlite3_update_hook()] interface.
     */
    @inlinable public func rollbackHook(_ userData: UnsafeMutableRawPointer? = nil, rollbackHookHandler: RollbackHookHandler? = nil) -> UnsafeMutableRawPointer? {
        sqlite3_rollback_hook(rawValue, rollbackHookHandler, userData)
    }

    /**
     CAPI3REF: Data Change Notification Callbacks
     METHOD: sqlite3

     ^The sqlite3_update_hook() interface registers a callback function
     with the [database connection] identified by the first argument
     to be invoked whenever a row is updated, inserted or deleted in
     a [rowid table].
     ^Any callback set by a previous call to this function
     for the same database connection is overridden.

     ^The second argument is a pointer to the function to invoke when a
     row is updated, inserted or deleted in a rowid table.
     ^The first argument to the callback is a copy of the third argument
     to sqlite3_update_hook().
     ^The second callback argument is one of [SQLITE_INSERT], [SQLITE_DELETE],
     or [SQLITE_UPDATE], depending on the operation that caused the callback
     to be invoked.
     ^The third and fourth arguments to the callback contain pointers to the
     database and table name containing the affected row.
     ^The final callback parameter is the [rowid] of the row.
     ^In the case of an update, this is the [rowid] after the update takes place.

     ^(The update hook is not invoked when internal system tables are
     modified (i.e. sqlite_master and sqlite_sequence).)^
     ^The update hook is not invoked when [WITHOUT ROWID] tables are modified.

     ^In the current implementation, the update hook
     is not invoked when conflicting rows are deleted because of an
     [ON CONFLICT | ON CONFLICT REPLACE] clause.  ^Nor is the update hook
     invoked when rows are deleted using the [truncate optimization].
     The exceptions defined in this paragraph might change in a future
     release of SQLite.

     The update hook implementation must not do anything that will modify
     the database connection that invoked the update hook.  Any actions
     to modify the database connection must be deferred until after the
     completion of the [sqlite3_step()] call that triggered the update hook.
     Note that [sqlite3_prepare_v2()] and [sqlite3_step()] both modify their
     database connections for the meaning of "modify" in this paragraph.

     ^The sqlite3_update_hook(D,C,P) function
     returns the P argument from the previous call
     on the same [database connection] D, or NULL for
     the first call on D.

     See also the [sqlite3_commit_hook()], [sqlite3_rollback_hook()],
     and [sqlite3_preupdate_hook()] interfaces.
     */
    @inlinable public func updateHook(_ userData: UnsafeMutableRawPointer? = nil, updateHookHandler: UpdateHookHandler? = nil) -> UnsafeMutableRawPointer? {
        sqlite3_update_hook(rawValue, updateHookHandler, userData)
    }

    /**
     CAPI3REF: Write-Ahead Log Commit Hook
     METHOD: sqlite3

     ^The [sqlite3_wal_hook()] function is used to register a callback that
     is invoked each time data is committed to a database in wal mode.

     ^(The callback is invoked by SQLite after the commit has taken place and
     the associated write-lock on the database released)^, so the implementation
     may read, write or [checkpoint] the database as required.

     ^The first parameter passed to the callback function when it is invoked
     is a copy of the third parameter passed to sqlite3_wal_hook() when
     registering the callback. ^The second is a copy of the database handle.
     ^The third parameter is the name of the database that was written to -
     either "main" or the name of an [ATTACH]-ed database. ^The fourth parameter
     is the number of pages currently in the write-ahead log file,
     including those that were just committed.

     The callback function should normally return [SQLITE_OK].  ^If an error
     code is returned, that error will propagate back up through the
     SQLite code base to cause the statement that provoked the callback
     to report an error, though the commit will have still occurred. If the
     callback returns [SQLITE_ROW] or [SQLITE_DONE], or if it returns a value
     that does not correspond to any valid SQLite error code, the results
     are undefined.

     A single database handle may have at most a single write-ahead log callback
     registered at one time. ^Calling [sqlite3_wal_hook()] replaces any
     previously registered write-ahead log callback. ^Note that the
     [sqlite3_wal_autocheckpoint()] interface and the
     [wal_autocheckpoint pragma] both invoke [sqlite3_wal_hook()] and will
     overwrite any prior [sqlite3_wal_hook()] settings.
     */
    @inlinable public func walHook(_ userData: UnsafeMutableRawPointer? = nil, walHookHandler: WALHookHandler? = nil) -> UnsafeMutableRawPointer? {
        sqlite3_wal_hook(rawValue, walHookHandler, userData)
    }
}
