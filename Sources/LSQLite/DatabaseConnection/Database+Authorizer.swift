import SQLite3

extension Database {
    public typealias AuthorizerHandler = @convention(c) (_ context: UnsafeMutableRawPointer?, _ actionCode: Int32, UnsafePointer<Int8>?, UnsafePointer<Int8>?, _ databaseName: UnsafePointer<Int8>?, _ triggerOrViewName: UnsafePointer<Int8>?) -> Int32

    @frozen public struct AuthorizerHandlerResult: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let ok = Self(rawValue: SQLITE_OK)
        public static let deny = Self(rawValue: SQLITE_DENY)
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

    @frozen public struct AuthorizerHandlerActionCode: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let createIndex = Self(rawValue: SQLITE_CREATE_INDEX)
        public static let createTable = Self(rawValue: SQLITE_CREATE_TABLE)
        public static let createTempIndex = Self(rawValue: SQLITE_CREATE_TEMP_INDEX)
        public static let createTempTable = Self(rawValue: SQLITE_CREATE_TEMP_TABLE)
        public static let createTempTrigger = Self(rawValue: SQLITE_CREATE_TEMP_TRIGGER)
        public static let createTempView = Self(rawValue: SQLITE_CREATE_TEMP_VIEW)
        public static let createTrigger = Self(rawValue: SQLITE_CREATE_TRIGGER)
        public static let createView = Self(rawValue: SQLITE_CREATE_VIEW)
        public static let delete = Self(rawValue: SQLITE_DELETE)
        public static let dropIndex = Self(rawValue: SQLITE_DROP_INDEX)
        public static let dropTable = Self(rawValue: SQLITE_DROP_TABLE)
        public static let dropTempIndex = Self(rawValue: SQLITE_DROP_TEMP_INDEX)
        public static let dropTempTable = Self(rawValue: SQLITE_DROP_TEMP_TABLE)
        public static let dropTempTrigger = Self(rawValue: SQLITE_DROP_TEMP_TRIGGER)
        public static let dropTempView = Self(rawValue: SQLITE_DROP_TEMP_VIEW)
        public static let dropTrigger = Self(rawValue: SQLITE_DROP_TRIGGER)
        public static let dropView = Self(rawValue: SQLITE_DROP_VIEW)
        public static let insert = Self(rawValue: SQLITE_INSERT)
        public static let pragma = Self(rawValue: SQLITE_PRAGMA)
        public static let read = Self(rawValue: SQLITE_READ)
        public static let select = Self(rawValue: SQLITE_SELECT)
        public static let transaction = Self(rawValue: SQLITE_TRANSACTION)
        public static let update = Self(rawValue: SQLITE_UPDATE)
        public static let attach = Self(rawValue: SQLITE_ATTACH)
        public static let detach = Self(rawValue: SQLITE_DETACH)
        public static let alterTable = Self(rawValue: SQLITE_ALTER_TABLE)
        public static let reindex = Self(rawValue: SQLITE_REINDEX)
        public static let analyze = Self(rawValue: SQLITE_ANALYZE)
        public static let createVTable = Self(rawValue: SQLITE_CREATE_VTABLE)
        public static let dropVTable = Self(rawValue: SQLITE_DROP_VTABLE)
        public static let function = Self(rawValue: SQLITE_FUNCTION)
        public static let savepoint = Self(rawValue: SQLITE_SAVEPOINT)
        public static let copy = Self(rawValue: SQLITE_COPY)
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

    @inlinable public func setAuthorizerHandler(context: UnsafeMutableRawPointer? = nil, _ handler: AuthorizerHandler? = nil) -> ResultCode {
        sqlite3_set_authorizer(rawValue, handler, context).resultCode
    }
}
