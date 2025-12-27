import MissedSwiftSQLite

extension Database {
    /// Authorization callback invoked while SQL statements are being prepared.
    ///
    /// SQLite calls this during `sqlite3_prepare` and its variants as the compiler considers
    /// actions like creating objects or reading tables. Return `.ok` to allow the action,
    /// `.ignore` to disallow the specific action but continue compiling, or `.deny` to
    /// reject the statement with an error.
    ///
    /// Parameters:
    /// - userData: Opaque pointer passed to `setAuthorizerHandler`.
    /// - actionCode: Integer action code describing the operation being authorized.
    /// - 3rd-6th: Optional C strings with details about the action; any may be NULL.
    ///   The 5th parameter is the database name ("main", "temp", or attached) when applicable.
    ///   The 6th parameter is the inner-most trigger or view name when applicable.
    ///
    /// The callback must not modify the database connection that invoked it.
    /// It is normally invoked only during prepare, but a statement can be reprepared
    /// during `step()` after a schema change.
    ///
    /// Related SQLite: `sqlite3_set_authorizer`, `sqlite3_prepare`, `sqlite3_prepare_v2`,
    /// `sqlite3_prepare_v3`, `sqlite3_prepare16`, `sqlite3_prepare16_v2`, `sqlite3_prepare16_v3`
    public typealias AuthorizerHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ actionCode: Int32, UnsafePointer<Int8>?, UnsafePointer<Int8>?, _ databaseName: UnsafePointer<Int8>?, _ triggerOrViewName: UnsafePointer<Int8>?) -> Int32

    /// Return codes for an authorizer callback to allow, deny, or ignore an action.
    ///
    /// The callback must return `.ok`, `.deny`, or `.ignore`. Any other value
    /// causes the prepare call that triggered the authorizer to fail.
    ///
    /// Related SQLite: `sqlite3_set_authorizer`, `SQLITE_OK`, `SQLITE_DENY`, `SQLITE_IGNORE`, `sqlite3_vtab_on_conflict`
    @frozen public struct AuthorizerHandlerResult: Hashable, RawRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        /// Allow the action.
        public static let ok = Self(rawValue: SQLITE_OK)
        /// Abort the SQL statement with an error
        public static let deny = Self(rawValue: SQLITE_DENY)
        /// Don't allow access, but don't generate an error
        public static let ignore = Self(rawValue: SQLITE_IGNORE)

        public var description: String {
            switch self {
            case .ok: "ok"
            case .deny: "deny"
            case .ignore: "ignore"
            default: rawValue.description
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

    /// Action codes describing what operation is being authorized in `setAuthorizerHandler`.
    ///
    /// The 3rd and 4th callback parameters depend on the action code; they are either NULL
    /// or zero-terminated strings as noted below. The 5th parameter is the database name
    /// ("main", "temp", or attached) when applicable, and the 6th parameter is the
    /// inner-most trigger or view name when applicable. Any of these pointers may be NULL.
    ///
    /// Related SQLite: `sqlite3_set_authorizer`, `SQLITE_CREATE_INDEX`, `SQLITE_DROP_TABLE`, `SQLITE_SELECT`
    @frozen public struct AuthorizerHandlerActionCode: Hashable, RawRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        /// Index Name      Table Name
        public static let createIndex = Self(rawValue: SQLITE_CREATE_INDEX)
        /// Table Name      NULL
        public static let createTable = Self(rawValue: SQLITE_CREATE_TABLE)
        /// Index Name      Table Name
        public static let createTempIndex = Self(rawValue: SQLITE_CREATE_TEMP_INDEX)
        /// Table Name      NULL
        public static let createTempTable = Self(rawValue: SQLITE_CREATE_TEMP_TABLE)
        /// Trigger Name    Table Name
        public static let createTempTrigger = Self(rawValue: SQLITE_CREATE_TEMP_TRIGGER)
        /// View Name       NULL
        public static let createTempView = Self(rawValue: SQLITE_CREATE_TEMP_VIEW)
        /// Trigger Name    Table Name
        public static let createTrigger = Self(rawValue: SQLITE_CREATE_TRIGGER)
        /// View Name       NULL
        public static let createView = Self(rawValue: SQLITE_CREATE_VIEW)
        /// Table Name      NULL
        public static let delete = Self(rawValue: SQLITE_DELETE)
        /// Index Name      Table Name
        public static let dropIndex = Self(rawValue: SQLITE_DROP_INDEX)
        /// Table Name      NULL
        public static let dropTable = Self(rawValue: SQLITE_DROP_TABLE)
        /// Index Name      Table Name
        public static let dropTempIndex = Self(rawValue: SQLITE_DROP_TEMP_INDEX)
        /// Table Name      NULL
        public static let dropTempTable = Self(rawValue: SQLITE_DROP_TEMP_TABLE)
        /// Trigger Name    Table Name
        public static let dropTempTrigger = Self(rawValue: SQLITE_DROP_TEMP_TRIGGER)
        /// View Name       NULL
        public static let dropTempView = Self(rawValue: SQLITE_DROP_TEMP_VIEW)
        /// Trigger Name    Table Name
        public static let dropTrigger = Self(rawValue: SQLITE_DROP_TRIGGER)
        /// View Name       NULL
        public static let dropView = Self(rawValue: SQLITE_DROP_VIEW)
        /// Table Name      NULL
        public static let insert = Self(rawValue: SQLITE_INSERT)
        /// Pragma Name     1st arg or NULL
        public static let pragma = Self(rawValue: SQLITE_PRAGMA)
        /// Table Name      Column Name
        public static let read = Self(rawValue: SQLITE_READ)
        /// NULL            NULL
        public static let select = Self(rawValue: SQLITE_SELECT)
        /// Operation       NULL
        public static let transaction = Self(rawValue: SQLITE_TRANSACTION)
        /// Table Name      Column Name
        public static let update = Self(rawValue: SQLITE_UPDATE)
        /// Filename        NULL
        public static let attach = Self(rawValue: SQLITE_ATTACH)
        /// Database Name   NULL
        public static let detach = Self(rawValue: SQLITE_DETACH)
        /// Database Name   Table Name
        public static let alterTable = Self(rawValue: SQLITE_ALTER_TABLE)
        /// Index Name      NULL
        public static let reindex = Self(rawValue: SQLITE_REINDEX)
        /// Table Name      NULL
        public static let analyze = Self(rawValue: SQLITE_ANALYZE)
        /// Table Name      Module Name
        public static let createVTable = Self(rawValue: SQLITE_CREATE_VTABLE)
        /// Table Name      Module Name
        public static let dropVTable = Self(rawValue: SQLITE_DROP_VTABLE)
        /// NULL            Function Name
        public static let function = Self(rawValue: SQLITE_FUNCTION)
        /// Operation       Savepoint Name
        public static let savepoint = Self(rawValue: SQLITE_SAVEPOINT)
        /// No longer used
        public static let copy = Self(rawValue: SQLITE_COPY)
        /// NULL            NULL
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
            default: rawValue.description
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

    /// Registers or clears a compile-time authorizer invoked while statements are prepared.
    ///
    /// The handler is called during `sqlite3_prepare` and its variants as the compiler
    /// considers actions. Return `.ok` to allow the action, `.ignore` to disallow the
    /// specific action but continue compiling, or `.deny` to reject the statement.
    ///
    /// Notes:
    /// - If the action is `.read` and the handler returns `.ignore`, the prepared statement
    ///   substitutes NULL for the requested column. If a table is referenced but no columns
    ///   are read (for example, `SELECT count(*) FROM tab`), the column name is an empty string.
    /// - If the action is `.delete` and the handler returns `.ignore`, the delete proceeds but
    ///   the truncate optimization is disabled and rows are deleted individually.
    /// - Only one authorizer is active per connection; each call replaces the previous handler.
    /// - Pass `nil` to disable authorization. The authorizer is disabled by default.
    /// - The handler must not modify the database connection that invoked it. Keep the
    ///   authorizer installed during `step()` because statements can be reprepared after
    ///   schema changes.
    /// - Parameters:
    ///   - userData: Custom context passed to the authorizer.
    ///   - handler: Callback returning `.ok`, `.deny`, or `.ignore`; `nil` disables authorization.
    /// - Returns: Result of `sqlite3_set_authorizer`.
    ///
    /// Related SQLite: `sqlite3_set_authorizer`, `sqlite3_prepare_v2`, `SQLITE_DENY`, `SQLITE_IGNORE`
    @inlinable public func setAuthorizerHandler(userData: UnsafeMutableRawPointer? = nil, _ handler: AuthorizerHandler? = nil) -> ResultCode {
        sqlite3_set_authorizer(rawValue, handler, userData).resultCode
    }
}
