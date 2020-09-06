import MissedSwiftSQLite

extension Database {
    @frozen public struct LimitCategory: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let length = Self(rawValue: SQLITE_LIMIT_LENGTH)
        public static let sqlLength = Self(rawValue: SQLITE_LIMIT_SQL_LENGTH)
        public static let column = Self(rawValue: SQLITE_LIMIT_COLUMN)
        public static let exprDepth = Self(rawValue: SQLITE_LIMIT_EXPR_DEPTH)
        public static let compoundSelect = Self(rawValue: SQLITE_LIMIT_COMPOUND_SELECT)
        public static let vdbeOp = Self(rawValue: SQLITE_LIMIT_VDBE_OP)
        public static let functionArg = Self(rawValue: SQLITE_LIMIT_FUNCTION_ARG)
        public static let attached = Self(rawValue: SQLITE_LIMIT_ATTACHED)
        public static let likePatternLength = Self(rawValue: SQLITE_LIMIT_LIKE_PATTERN_LENGTH)
        public static let variableNumber = Self(rawValue: SQLITE_LIMIT_VARIABLE_NUMBER)
        public static let triggerDepth = Self(rawValue: SQLITE_LIMIT_TRIGGER_DEPTH)
        public static let workerThreads = Self(rawValue: SQLITE_LIMIT_WORKER_THREADS)

        public var debugDescription: String {
            switch self {
            case .length: return "SQLITE_LIMIT_LENGTH"
            case .sqlLength: return "SQLITE_LIMIT_SQL_LENGTH)"
            case .column: return "SQLITE_LIMIT_COLUMN)"
            case .exprDepth: return "SQLITE_LIMIT_EXPR_DEPTH)"
            case .compoundSelect: return "SQLITE_LIMIT_COMPOUND_SELECT)"
            case .vdbeOp: return "SQLITE_LIMIT_VDBE_OP)"
            case .functionArg: return "SQLITE_LIMIT_FUNCTION_ARG)"
            case .attached: return "SQLITE_LIMIT_ATTACHED)"
            case .likePatternLength: return "SQLITE_LIMIT_LIKE_PATTERN_LENGTH)"
            case .variableNumber: return "SQLITE_LIMIT_VARIABLE_NUMBER)"
            case .triggerDepth: return "SQLITE_LIMIT_TRIGGER_DEPTH)"
            case .workerThreads: return "SQLITE_LIMIT_WORKER_THREADS)"
            default: return "LimitCategory(rawValue: \(rawValue))"
            }
        }
    }

    @inlinable public func limit(for category: LimitCategory) -> Int32 {
        sqlite3_limit(rawValue, category.rawValue, -1)
    }

    @discardableResult @inlinable public func setLimit(_ limit: Int32, for category: LimitCategory) -> Int32 {
        sqlite3_limit(rawValue, category.rawValue, limit)
    }
}
