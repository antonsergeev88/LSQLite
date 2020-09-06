import MissedSwiftSQLite

extension Database {
    public typealias AuthorizerHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ actionCode: Int32, UnsafePointer<Int8>?, UnsafePointer<Int8>?, _ databaseName: UnsafePointer<Int8>?, _ triggerOrViewName: UnsafePointer<Int8>?) -> Int32

    /**
     CAPI3REF: Authorizer Return Codes

     The [sqlite3_set_authorizer | authorizer callback function] must
     return either [SQLITE_OK] or one of these two constants in order
     to signal SQLite whether or not the action is permitted.  See the
     [sqlite3_set_authorizer | authorizer documentation] for additional
     information.

     Note that SQLITE_IGNORE is also used as a [conflict resolution mode]
     returned from the [sqlite3_vtab_on_conflict()] interface.
     */
    @frozen public struct AuthorizerHandlerResult: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let ok = Self(rawValue: SQLITE_OK)
        /** Abort the SQL statement with an error */
        public static let deny = Self(rawValue: SQLITE_DENY)
        /** Don't allow access, but don't generate an error */
        public static let ignore = Self(rawValue: SQLITE_IGNORE)

        public var debugDescription: String {
            switch self {
            case .ok: return "SQLITE_OK"
            case .deny: return "SQLITE_DENY"
            case .ignore: return "SQLITE_IGNORE"
            default: return "AuthorizerHandlerResult(rawValue: \(rawValue))"
            }
        }
    }

    /**
     CAPI3REF: Authorizer Action Codes

     The [sqlite3_set_authorizer()] interface registers a callback function
     that is invoked to authorize certain SQL statement actions.  The
     second parameter to the callback is an integer code that specifies
     what action is being authorized.  These are the integer action codes that
     the authorizer callback may be passed.

     These action code values signify what kind of operation is to be
     authorized.  The 3rd and 4th parameters to the authorization
     callback function will be parameters or NULL depending on which of these
     codes is used as the second parameter.  ^(The 5th parameter to the
     authorizer callback is the name of the database ("main", "temp",
     etc.) if applicable.)^  ^The 6th parameter to the authorizer callback
     is the name of the inner-most trigger or view that is responsible for
     the access attempt or NULL if this access attempt is directly from
     top-level SQL code.
     */
    @frozen public struct AuthorizerHandlerActionCode: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        /** Index Name      Table Name      */
        public static let createIndex = Self(rawValue: SQLITE_CREATE_INDEX)
        /** Table Name      NULL            */
        public static let createTable = Self(rawValue: SQLITE_CREATE_TABLE)
        /** Index Name      Table Name      */
        public static let createTempIndex = Self(rawValue: SQLITE_CREATE_TEMP_INDEX)
        /** Table Name      NULL            */
        public static let createTempTable = Self(rawValue: SQLITE_CREATE_TEMP_TABLE)
        /** Trigger Name    Table Name      */
        public static let createTempTrigger = Self(rawValue: SQLITE_CREATE_TEMP_TRIGGER)
        /** View Name       NULL            */
        public static let createTempView = Self(rawValue: SQLITE_CREATE_TEMP_VIEW)
        /** Trigger Name    Table Name      */
        public static let createTrigger = Self(rawValue: SQLITE_CREATE_TRIGGER)
        /** View Name       NULL            */
        public static let createView = Self(rawValue: SQLITE_CREATE_VIEW)
        /** Table Name      NULL            */
        public static let delete = Self(rawValue: SQLITE_DELETE)
        /** Index Name      Table Name      */
        public static let dropIndex = Self(rawValue: SQLITE_DROP_INDEX)
        /** Table Name      NULL            */
        public static let dropTable = Self(rawValue: SQLITE_DROP_TABLE)
        /** Index Name      Table Name      */
        public static let dropTempIndex = Self(rawValue: SQLITE_DROP_TEMP_INDEX)
        /** Table Name      NULL            */
        public static let dropTempTable = Self(rawValue: SQLITE_DROP_TEMP_TABLE)
        /** Trigger Name    Table Name      */
        public static let dropTempTrigger = Self(rawValue: SQLITE_DROP_TEMP_TRIGGER)
        /** View Name       NULL            */
        public static let dropTempView = Self(rawValue: SQLITE_DROP_TEMP_VIEW)
        /** Trigger Name    Table Name      */
        public static let dropTrigger = Self(rawValue: SQLITE_DROP_TRIGGER)
        /** View Name       NULL            */
        public static let dropView = Self(rawValue: SQLITE_DROP_VIEW)
        /** Table Name      NULL            */
        public static let insert = Self(rawValue: SQLITE_INSERT)
        /** Pragma Name     1st arg or NULL */
        public static let pragma = Self(rawValue: SQLITE_PRAGMA)
        /** Table Name      Column Name     */
        public static let read = Self(rawValue: SQLITE_READ)
        /** NULL            NULL            */
        public static let select = Self(rawValue: SQLITE_SELECT)
        /** Operation       NULL            */
        public static let transaction = Self(rawValue: SQLITE_TRANSACTION)
        /** Table Name      Column Name     */
        public static let update = Self(rawValue: SQLITE_UPDATE)
        /** Filename        NULL            */
        public static let attach = Self(rawValue: SQLITE_ATTACH)
        /** Database Name   NULL            */
        public static let detach = Self(rawValue: SQLITE_DETACH)
        /** Database Name   Table Name      */
        public static let alterTable = Self(rawValue: SQLITE_ALTER_TABLE)
        /** Index Name      NULL            */
        public static let reindex = Self(rawValue: SQLITE_REINDEX)
        /** Table Name      NULL            */
        public static let analyze = Self(rawValue: SQLITE_ANALYZE)
        /** Table Name      Module Name     */
        public static let createVTable = Self(rawValue: SQLITE_CREATE_VTABLE)
        /** Table Name      Module Name     */
        public static let dropVTable = Self(rawValue: SQLITE_DROP_VTABLE)
        /** NULL            Function Name   */
        public static let function = Self(rawValue: SQLITE_FUNCTION)
        /** Operation       Savepoint Name  */
        public static let savepoint = Self(rawValue: SQLITE_SAVEPOINT)
        /** No longer used */
        public static let copy = Self(rawValue: SQLITE_COPY)
        /** NULL            NULL            */
        public static let recursive = Self(rawValue: SQLITE_RECURSIVE)

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

    /**
     CAPI3REF: Compile-Time Authorization Callbacks
     METHOD: sqlite3
     KEYWORDS: {authorizer callback}

     ^This routine registers an authorizer callback with a particular
     [database connection], supplied in the first argument.
     ^The authorizer callback is invoked as SQL statements are being compiled
     by [sqlite3_prepare()] or its variants [sqlite3_prepare_v2()],
     [sqlite3_prepare_v3()], [sqlite3_prepare16()], [sqlite3_prepare16_v2()],
     and [sqlite3_prepare16_v3()].  ^At various
     points during the compilation process, as logic is being created
     to perform various actions, the authorizer callback is invoked to
     see if those actions are allowed.  ^The authorizer callback should
     return [SQLITE_OK] to allow the action, [SQLITE_IGNORE] to disallow the
     specific action but allow the SQL statement to continue to be
     compiled, or [SQLITE_DENY] to cause the entire SQL statement to be
     rejected with an error.  ^If the authorizer callback returns
     any value other than [SQLITE_IGNORE], [SQLITE_OK], or [SQLITE_DENY]
     then the [sqlite3_prepare_v2()] or equivalent call that triggered
     the authorizer will fail with an error message.

     When the callback returns [SQLITE_OK], that means the operation
     requested is ok.  ^When the callback returns [SQLITE_DENY], the
     [sqlite3_prepare_v2()] or equivalent call that triggered the
     authorizer will fail with an error message explaining that
     access is denied.

     ^The first parameter to the authorizer callback is a copy of the third
     parameter to the sqlite3_set_authorizer() interface. ^The second parameter
     to the callback is an integer [SQLITE_COPY | action code] that specifies
     the particular action to be authorized. ^The third through sixth parameters
     to the callback are either NULL pointers or zero-terminated strings
     that contain additional details about the action to be authorized.
     Applications must always be prepared to encounter a NULL pointer in any
     of the third through the sixth parameters of the authorization callback.

     ^If the action code is [SQLITE_READ]
     and the callback returns [SQLITE_IGNORE] then the
     [prepared statement] statement is constructed to substitute
     a NULL value in place of the table column that would have
     been read if [SQLITE_OK] had been returned.  The [SQLITE_IGNORE]
     return can be used to deny an untrusted user access to individual
     columns of a table.
     ^When a table is referenced by a [SELECT] but no column values are
     extracted from that table (for example in a query like
     "SELECT count(*) FROM tab") then the [SQLITE_READ] authorizer callback
     is invoked once for that table with a column name that is an empty string.
     ^If the action code is [SQLITE_DELETE] and the callback returns
     [SQLITE_IGNORE] then the [DELETE] operation proceeds but the
     [truncate optimization] is disabled and all rows are deleted individually.

     An authorizer is used when [sqlite3_prepare | preparing]
     SQL statements from an untrusted source, to ensure that the SQL statements
     do not try to access data they are not allowed to see, or that they do not
     try to execute malicious statements that damage the database.  For
     example, an application may allow a user to enter arbitrary
     SQL queries for evaluation by a database.  But the application does
     not want the user to be able to make arbitrary changes to the
     database.  An authorizer could then be put in place while the
     user-entered SQL is being [sqlite3_prepare | prepared] that
     disallows everything except [SELECT] statements.

     Applications that need to process SQL from untrusted sources
     might also consider lowering resource limits using [sqlite3_limit()]
     and limiting database size using the [max_page_count] [PRAGMA]
     in addition to using an authorizer.

     ^(Only a single authorizer can be in place on a database connection
     at a time.  Each call to sqlite3_set_authorizer overrides the
     previous call.)^  ^Disable the authorizer by installing a NULL callback.
     The authorizer is disabled by default.

     The authorizer callback must not do anything that will modify
     the database connection that invoked the authorizer callback.
     Note that [sqlite3_prepare_v2()] and [sqlite3_step()] both modify their
     database connections for the meaning of "modify" in this paragraph.

     ^When [sqlite3_prepare_v2()] is used to prepare a statement, the
     statement might be re-prepared during [sqlite3_step()] due to a
     schema change.  Hence, the application should ensure that the
     correct authorizer callback remains in place during the [sqlite3_step()].

     ^Note that the authorizer callback is invoked only during
     [sqlite3_prepare()] or its variants.  Authorization is not
     performed during statement evaluation in [sqlite3_step()], unless
     as stated in the previous paragraph, sqlite3_step() invokes
     sqlite3_prepare_v2() to reprepare a statement after a schema change.
     */
    @inlinable public func setAuthorizerHandler(userData: UnsafeMutableRawPointer? = nil, _ handler: AuthorizerHandler? = nil) -> ResultCode {
        sqlite3_set_authorizer(rawValue, handler, userData).resultCode
    }
}
