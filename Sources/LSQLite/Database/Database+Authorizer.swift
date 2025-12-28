import MissedSwiftSQLite

extension Database {
    /// Authorization callback invoked while SQL statements are being compiled.
    ///
    /// The callback runs as the compiler considers each operation. Return `.ok` to allow
    /// the action, `.ignore` to block just that action while continuing compilation, or
    /// `.deny` to reject the statement with an access error. Returning any other value
    /// causes statement preparation to fail.
    ///
    /// - Parameters:
    ///   - userData: Context pointer provided to `setAuthorizerHandler`.
    ///   - actionCode: Operation being authorized.
    ///   - detail1: Optional C string with the first action detail; meaning depends on `actionCode`.
    ///   - detail2: Optional C string with the second action detail; meaning depends on `actionCode`.
    ///   - databaseName: Optional schema name when applicable (for example, "main", "temp", or an attached name).
    ///   - triggerOrViewName: Optional name of the innermost trigger or view responsible for the access.
    /// - Returns: An authorization decision as an `Int32` matching `AuthorizerHandlerResult`.
    ///
    /// The callback must not mutate the database connection that invoked it. It is normally
    /// called only during statement preparation, but statements can be recompiled during
    /// execution after schema changes.
    ///
    /// Related SQLite: `sqlite3_set_authorizer`, `sqlite3_prepare`, `sqlite3_prepare_v2`,
    /// `sqlite3_prepare_v3`, `sqlite3_prepare16`, `sqlite3_prepare16_v2`, `sqlite3_prepare16_v3`
    public typealias AuthorizerHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ actionCode: Int32, _ detail1: UnsafePointer<Int8>?, _ detail2: UnsafePointer<Int8>?, _ databaseName: UnsafePointer<Int8>?, _ triggerOrViewName: UnsafePointer<Int8>?) -> Int32

    /// Return codes for an authorizer callback.
    ///
    /// Return `.ok` to allow the operation, `.ignore` to block only that action while still
    /// compiling the statement, or `.deny` to reject the statement with an access error.
    /// Any other value causes statement preparation to fail. `.ignore` is also used as
    /// a conflict resolution code for virtual table conflict handling.
    ///
    /// Related SQLite: `sqlite3_set_authorizer`, `SQLITE_OK`, `SQLITE_DENY`, `SQLITE_IGNORE`, `sqlite3_vtab_on_conflict`
    @frozen public struct AuthorizerHandlerResult: Hashable, RawRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        /// Allow the action to proceed.
        ///
        /// Related SQLite: `SQLITE_OK`
        public static let ok = Self(rawValue: SQLITE_OK)
        /// Reject the statement with an access error.
        ///
        /// Related SQLite: `SQLITE_DENY`
        public static let deny = Self(rawValue: SQLITE_DENY)
        /// Block the specific action but continue compiling.
        ///
        /// Related SQLite: `SQLITE_IGNORE`
        public static let ignore = Self(rawValue: SQLITE_IGNORE)

        public var description: String {
            switch self {
            case .ok: "ok"
            case .deny: "deny"
            case .ignore: "ignore"
            default: "unknown"
            }
        }

        public var debugDescription: String {
            switch self {
            case .ok: "SQLITE_OK"
            case .deny: "SQLITE_DENY"
            case .ignore: "SQLITE_IGNORE"
            default: rawValue.description
            }
        }
    }

    /// Action codes that describe the operation being authorized.
    ///
    /// These values appear in the `actionCode` parameter of the authorizer callback. The
    /// `detail1` and `detail2` parameters provide per-action context as described below, or
    /// `nil` when not applicable. `databaseName` is the schema name when applicable, and
    /// `triggerOrViewName` is the innermost trigger or view responsible for the access.
    /// Any of these parameters may be `nil`.
    ///
    /// Related SQLite: `sqlite3_set_authorizer`, `SQLITE_CREATE_INDEX`, `SQLITE_DROP_TABLE`, `SQLITE_SELECT`
    @frozen public struct AuthorizerHandlerActionCode: Hashable, RawRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        /// Provides the index name in `detail1` and the table name in `detail2`.
        ///
        /// Related SQLite: `SQLITE_CREATE_INDEX`
        public static let createIndex = Self(rawValue: SQLITE_CREATE_INDEX)
        /// Provides the table name in `detail1`; `detail2` is `nil`.
        ///
        /// Related SQLite: `SQLITE_CREATE_TABLE`
        public static let createTable = Self(rawValue: SQLITE_CREATE_TABLE)
        /// Provides the index name in `detail1` and the table name in `detail2`.
        ///
        /// Related SQLite: `SQLITE_CREATE_TEMP_INDEX`
        public static let createTempIndex = Self(rawValue: SQLITE_CREATE_TEMP_INDEX)
        /// Provides the table name in `detail1`; `detail2` is `nil`.
        ///
        /// Related SQLite: `SQLITE_CREATE_TEMP_TABLE`
        public static let createTempTable = Self(rawValue: SQLITE_CREATE_TEMP_TABLE)
        /// Provides the trigger name in `detail1` and the table name in `detail2`.
        ///
        /// Related SQLite: `SQLITE_CREATE_TEMP_TRIGGER`
        public static let createTempTrigger = Self(rawValue: SQLITE_CREATE_TEMP_TRIGGER)
        /// Provides the view name in `detail1`; `detail2` is `nil`.
        ///
        /// Related SQLite: `SQLITE_CREATE_TEMP_VIEW`
        public static let createTempView = Self(rawValue: SQLITE_CREATE_TEMP_VIEW)
        /// Provides the trigger name in `detail1` and the table name in `detail2`.
        ///
        /// Related SQLite: `SQLITE_CREATE_TRIGGER`
        public static let createTrigger = Self(rawValue: SQLITE_CREATE_TRIGGER)
        /// Provides the view name in `detail1`; `detail2` is `nil`.
        ///
        /// Related SQLite: `SQLITE_CREATE_VIEW`
        public static let createView = Self(rawValue: SQLITE_CREATE_VIEW)
        /// Provides the table name in `detail1`; `detail2` is `nil`.
        ///
        /// Related SQLite: `SQLITE_DELETE`
        public static let delete = Self(rawValue: SQLITE_DELETE)
        /// Provides the index name in `detail1` and the table name in `detail2`.
        ///
        /// Related SQLite: `SQLITE_DROP_INDEX`
        public static let dropIndex = Self(rawValue: SQLITE_DROP_INDEX)
        /// Provides the table name in `detail1`; `detail2` is `nil`.
        ///
        /// Related SQLite: `SQLITE_DROP_TABLE`
        public static let dropTable = Self(rawValue: SQLITE_DROP_TABLE)
        /// Provides the index name in `detail1` and the table name in `detail2`.
        ///
        /// Related SQLite: `SQLITE_DROP_TEMP_INDEX`
        public static let dropTempIndex = Self(rawValue: SQLITE_DROP_TEMP_INDEX)
        /// Provides the table name in `detail1`; `detail2` is `nil`.
        ///
        /// Related SQLite: `SQLITE_DROP_TEMP_TABLE`
        public static let dropTempTable = Self(rawValue: SQLITE_DROP_TEMP_TABLE)
        /// Provides the trigger name in `detail1` and the table name in `detail2`.
        ///
        /// Related SQLite: `SQLITE_DROP_TEMP_TRIGGER`
        public static let dropTempTrigger = Self(rawValue: SQLITE_DROP_TEMP_TRIGGER)
        /// Provides the view name in `detail1`; `detail2` is `nil`.
        ///
        /// Related SQLite: `SQLITE_DROP_TEMP_VIEW`
        public static let dropTempView = Self(rawValue: SQLITE_DROP_TEMP_VIEW)
        /// Provides the trigger name in `detail1` and the table name in `detail2`.
        ///
        /// Related SQLite: `SQLITE_DROP_TRIGGER`
        public static let dropTrigger = Self(rawValue: SQLITE_DROP_TRIGGER)
        /// Provides the view name in `detail1`; `detail2` is `nil`.
        ///
        /// Related SQLite: `SQLITE_DROP_VIEW`
        public static let dropView = Self(rawValue: SQLITE_DROP_VIEW)
        /// Provides the table name in `detail1`; `detail2` is `nil`.
        ///
        /// Related SQLite: `SQLITE_INSERT`
        public static let insert = Self(rawValue: SQLITE_INSERT)
        /// Provides the pragma name in `detail1` and the first argument in `detail2` when present.
        ///
        /// Related SQLite: `SQLITE_PRAGMA`
        public static let pragma = Self(rawValue: SQLITE_PRAGMA)
        /// Provides the table name in `detail1` and the column name in `detail2`.
        /// The column name can be an empty string when no columns are read.
        ///
        /// Related SQLite: `SQLITE_READ`
        public static let read = Self(rawValue: SQLITE_READ)
        /// No detail strings are provided.
        ///
        /// Related SQLite: `SQLITE_SELECT`
        public static let select = Self(rawValue: SQLITE_SELECT)
        /// Provides the transaction operation in `detail1`; `detail2` is `nil`.
        ///
        /// Related SQLite: `SQLITE_TRANSACTION`
        public static let transaction = Self(rawValue: SQLITE_TRANSACTION)
        /// Provides the table name in `detail1` and the column name in `detail2`.
        ///
        /// Related SQLite: `SQLITE_UPDATE`
        public static let update = Self(rawValue: SQLITE_UPDATE)
        /// Provides the filename in `detail1`; `detail2` is `nil`.
        ///
        /// Related SQLite: `SQLITE_ATTACH`
        public static let attach = Self(rawValue: SQLITE_ATTACH)
        /// Provides the database name in `detail1`; `detail2` is `nil`.
        ///
        /// Related SQLite: `SQLITE_DETACH`
        public static let detach = Self(rawValue: SQLITE_DETACH)
        /// Provides the database name in `detail1` and the table name in `detail2`.
        ///
        /// Related SQLite: `SQLITE_ALTER_TABLE`
        public static let alterTable = Self(rawValue: SQLITE_ALTER_TABLE)
        /// Provides the index name in `detail1`; `detail2` is `nil`.
        ///
        /// Related SQLite: `SQLITE_REINDEX`
        public static let reindex = Self(rawValue: SQLITE_REINDEX)
        /// Provides the table name in `detail1`; `detail2` is `nil`.
        ///
        /// Related SQLite: `SQLITE_ANALYZE`
        public static let analyze = Self(rawValue: SQLITE_ANALYZE)
        /// Provides the table name in `detail1` and the module name in `detail2`.
        ///
        /// Related SQLite: `SQLITE_CREATE_VTABLE`
        public static let createVTable = Self(rawValue: SQLITE_CREATE_VTABLE)
        /// Provides the table name in `detail1` and the module name in `detail2`.
        ///
        /// Related SQLite: `SQLITE_DROP_VTABLE`
        public static let dropVTable = Self(rawValue: SQLITE_DROP_VTABLE)
        /// Provides the function name in `detail2`; `detail1` is `nil`.
        ///
        /// Related SQLite: `SQLITE_FUNCTION`
        public static let function = Self(rawValue: SQLITE_FUNCTION)
        /// Provides the savepoint operation in `detail1` and the savepoint name in `detail2`.
        ///
        /// Related SQLite: `SQLITE_SAVEPOINT`
        public static let savepoint = Self(rawValue: SQLITE_SAVEPOINT)
        /// No longer used; no detail strings are provided.
        ///
        /// Related SQLite: `SQLITE_COPY`
        public static let copy = Self(rawValue: SQLITE_COPY)
        /// No detail strings are provided.
        ///
        /// Related SQLite: `SQLITE_RECURSIVE`
        public static let recursive = Self(rawValue: SQLITE_RECURSIVE)

        public var description: String {
            switch self {
            case .createIndex: "create index"
            case .createTable: "create table"
            case .createTempIndex: "create temp index"
            case .createTempTable: "create temp table"
            case .createTempTrigger: "create temp trigger"
            case .createTempView: "create temp view"
            case .createTrigger: "create trigger"
            case .createView: "create view"
            case .delete: "delete"
            case .dropIndex: "drop index"
            case .dropTable: "drop table"
            case .dropTempIndex: "drop temp index"
            case .dropTempTable: "drop temp table"
            case .dropTempTrigger: "drop temp trigger"
            case .dropTempView: "drop temp view"
            case .dropTrigger: "drop trigger"
            case .dropView: "drop view"
            case .insert: "insert"
            case .pragma: "pragma"
            case .read: "read"
            case .select: "select"
            case .transaction: "transaction"
            case .update: "update"
            case .attach: "attach"
            case .detach: "detach"
            case .alterTable: "alter table"
            case .reindex: "reindex"
            case .analyze: "analyze"
            case .createVTable: "create vtable"
            case .dropVTable: "drop vtable"
            case .function: "function"
            case .savepoint: "savepoint"
            case .copy: "copy"
            case .recursive: "recursive"
            default: "unknown"
            }
        }

        public var debugDescription: String {
            switch self {
            case .createIndex: "SQLITE_CREATE_INDEX"
            case .createTable: "SQLITE_CREATE_TABLE"
            case .createTempIndex: "SQLITE_CREATE_TEMP_INDEX"
            case .createTempTable: "SQLITE_CREATE_TEMP_TABLE"
            case .createTempTrigger: "SQLITE_CREATE_TEMP_TRIGGER"
            case .createTempView: "SQLITE_CREATE_TEMP_VIEW"
            case .createTrigger: "SQLITE_CREATE_TRIGGER"
            case .createView: "SQLITE_CREATE_VIEW"
            case .delete: "SQLITE_DELETE"
            case .dropIndex: "SQLITE_DROP_INDEX"
            case .dropTable: "SQLITE_DROP_TABLE"
            case .dropTempIndex: "SQLITE_DROP_TEMP_INDEX"
            case .dropTempTable: "SQLITE_DROP_TEMP_TABLE"
            case .dropTempTrigger: "SQLITE_DROP_TEMP_TRIGGER"
            case .dropTempView: "SQLITE_DROP_TEMP_VIEW"
            case .dropTrigger: "SQLITE_DROP_TRIGGER"
            case .dropView: "SQLITE_DROP_VIEW"
            case .insert: "SQLITE_INSERT"
            case .pragma: "SQLITE_PRAGMA"
            case .read: "SQLITE_READ"
            case .select: "SQLITE_SELECT"
            case .transaction: "SQLITE_TRANSACTION"
            case .update: "SQLITE_UPDATE"
            case .attach: "SQLITE_ATTACH"
            case .detach: "SQLITE_DETACH"
            case .alterTable: "SQLITE_ALTER_TABLE"
            case .reindex: "SQLITE_REINDEX"
            case .analyze: "SQLITE_ANALYZE"
            case .createVTable: "SQLITE_CREATE_VTABLE"
            case .dropVTable: "SQLITE_DROP_VTABLE"
            case .function: "SQLITE_FUNCTION"
            case .savepoint: "SQLITE_SAVEPOINT"
            case .copy: "SQLITE_COPY"
            case .recursive: "SQLITE_RECURSIVE"
            default: rawValue.description
            }
        }
    }

    /// Registers or clears a compile-time authorizer for this connection.
    ///
    /// The handler is consulted while statements are compiled. Return `.ok` to allow the
    /// action, `.ignore` to block only that action while continuing compilation, or
    /// `.deny` to reject the statement with an access error. Any other return value
    /// causes statement preparation to fail.
    ///
    /// Notes:
    /// - If the action is `.read` and the handler returns `.ignore`, the prepared statement
    ///   substitutes SQL NULL for the requested column. If a table is referenced but no
    ///   columns are read (for example, `SELECT count(*) FROM tab`), `detail2` is an empty string.
    /// - If the action is `.delete` and the handler returns `.ignore`, the delete proceeds but
    ///   the truncate optimization is disabled and rows are deleted individually.
    /// - Only one authorizer is active per connection; each call replaces the previous handler.
    /// - Pass `nil` to disable authorization. The authorizer is disabled by default.
    /// - The handler must not mutate the database connection that invoked it. Keep it installed
    ///   while executing statements because they can be recompiled after schema changes.
    /// - Use an authorizer when compiling SQL from untrusted sources to prevent unauthorized
    ///   access or modification, and consider pairing it with resource limits and size caps.
    ///
    /// - Parameters:
    ///   - userData: Custom context passed to the authorizer.
    ///   - handler: Callback returning `.ok`, `.deny`, or `.ignore`; `nil` disables authorization.
    /// - Returns: Result of registering the authorizer.
    ///
    /// Related SQLite: `sqlite3_set_authorizer`, `sqlite3_prepare_v2`, `SQLITE_DENY`, `SQLITE_IGNORE`
    @inlinable public func setAuthorizerHandler(userData: UnsafeMutableRawPointer? = nil, _ handler: AuthorizerHandler? = nil) -> ResultCode {
        sqlite3_set_authorizer(rawValue, handler, userData).resultCode
    }
}
