import SQLite3

extension Database {
    /// Authorization callback invoked during statement compilation.
    ///
    /// Related SQLite: `sqlite3_set_authorizer`
    public typealias AuthorizerHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ actionCode: Int32, UnsafePointer<Int8>?, UnsafePointer<Int8>?, _ databaseName: UnsafePointer<Int8>?, _ triggerOrViewName: UnsafePointer<Int8>?) -> Int32

    /// Return codes for an authorizer callback to allow, deny, or ignore an action.
    ///
    /// Related SQLite: `sqlite3_set_authorizer`, `SQLITE_OK`, `SQLITE_DENY`, `SQLITE_IGNORE`, `sqlite3_vtab_on_conflict`
    @frozen public struct AuthorizerHandlerResult: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let ok = Self(rawValue: SQLITE_OK)
        /// Abort the SQL statement with an error
        public static let deny = Self(rawValue: SQLITE_DENY)
        /// Don't allow access, but don't generate an error
        public static let ignore = Self(rawValue: SQLITE_IGNORE)

        /// Debug label for an authorizer decision.
        ///
        /// Related SQLite: `sqlite3_set_authorizer`, `SQLITE_OK`, `SQLITE_DENY`, `SQLITE_IGNORE`
        public var debugDescription: String {
            switch self {
            case .ok: return "SQLITE_OK"
            case .deny: return "SQLITE_DENY"
            case .ignore: return "SQLITE_IGNORE"
            default: return "AuthorizerHandlerResult(rawValue: \(rawValue))"
            }
        }
    }

    /// Action codes describing what operation is being authorized in `setAuthorizerHandler`.
    ///
    /// Related SQLite: `sqlite3_set_authorizer`, `SQLITE_CREATE_INDEX`, `SQLITE_DROP_TABLE`, `SQLITE_SELECT`
    @frozen public struct AuthorizerHandlerActionCode: Equatable, RawRepresentable, CustomDebugStringConvertible {
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

        /// Debug label for the authorizer action code.
        ///
        /// Related SQLite: `sqlite3_set_authorizer`, `SQLITE_*`
        public var debugDescription: String {
            switch self {
            case .createIndex: return "SQLITE_CREATE_INDEX"
            case .createTable: return "SQLITE_CREATE_TABLE"
            case .createTempIndex: return "SQLITE_CREATE_TEMP_INDEX"
            case .createTempTable: return "SQLITE_CREATE_TEMP_TABLE"
            case .createTempTrigger: return "SQLITE_CREATE_TEMP_TRIGGER"
            case .createTempView: return "SQLITE_CREATE_TEMP_VIEW"
            case .createTrigger: return "SQLITE_CREATE_TRIGGER"
            case .createView: return "SQLITE_CREATE_VIEW"
            case .delete: return "SQLITE_DELETE"
            case .dropIndex: return "SQLITE_DROP_INDEX"
            case .dropTable: return "SQLITE_DROP_TABLE"
            case .dropTempIndex: return "SQLITE_DROP_TEMP_INDEX"
            case .dropTempTable: return "SQLITE_DROP_TEMP_TABLE"
            case .dropTempTrigger: return "SQLITE_DROP_TEMP_TRIGGER"
            case .dropTempView: return "SQLITE_DROP_TEMP_VIEW"
            case .dropTrigger: return "SQLITE_DROP_TRIGGER"
            case .dropView: return "SQLITE_DROP_VIEW"
            case .insert: return "SQLITE_INSERT"
            case .pragma: return "SQLITE_PRAGMA"
            case .read: return "SQLITE_READ"
            case .select: return "SQLITE_SELECT"
            case .transaction: return "SQLITE_TRANSACTION"
            case .update: return "SQLITE_UPDATE"
            case .attach: return "SQLITE_ATTACH"
            case .detach: return "SQLITE_DETACH"
            case .alterTable: return "SQLITE_ALTER_TABLE"
            case .reindex: return "SQLITE_REINDEX"
            case .analyze: return "SQLITE_ANALYZE"
            case .createVTable: return "SQLITE_CREATE_VTABLE"
            case .dropVTable: return "SQLITE_DROP_VTABLE"
            case .function: return "SQLITE_FUNCTION"
            case .savepoint: return "SQLITE_SAVEPOINT"
            case .copy: return "SQLITE_COPY"
            case .recursive: return "SQLITE_RECURSIVE"
            default: return "AuthorizerHandlerActionCode(rawValue: \(rawValue))"
            }
        }
    }

    /// Registers or clears a compile-time authorizer invoked while statements are prepared.
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
