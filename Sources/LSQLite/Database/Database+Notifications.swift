import MissedSwiftSQLite

extension Database {
    public typealias CommitHookHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?) -> Int32
    public typealias RollbackHookHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?) -> Void
    public typealias UpdateHookHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ updateOperation: Int32, _ databaseName: UnsafePointer<Int8>?, _ tableName: UnsafePointer<Int8>?, _ rowID: sqlite3_int64) -> Void

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
            default: return "AuthorizerHandlerActionCode(rawValue: \(rawValue))"
            }
        }
    }

    @inlinable public func commitHook(_ userData: UnsafeMutableRawPointer? = nil, commitHookHandler: CommitHookHandler? = nil) -> UnsafeMutableRawPointer? {
        sqlite3_commit_hook(rawValue, commitHookHandler, userData)
    }

    @inlinable public func rollbackHook(_ userData: UnsafeMutableRawPointer? = nil, rollbackHookHandler: RollbackHookHandler? = nil) -> UnsafeMutableRawPointer? {
        sqlite3_rollback_hook(rawValue, rollbackHookHandler, userData)
    }

    @inlinable public func updateHook(_ userData: UnsafeMutableRawPointer? = nil, updateHookHandler: UpdateHookHandler? = nil) -> UnsafeMutableRawPointer? {
        sqlite3_update_hook(rawValue, updateHookHandler, userData)
    }
}
