import SQLite3

extension Database {
    /// Runtime limit categories used with `Database.limit(for:)` and `Database.setLimit(_:for:)`.
    ///
    /// Related SQLite: `sqlite3_limit`, `SQLITE_LIMIT_*`
    @frozen public struct LimitCategory: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        /// Maximum size of any string, BLOB, or table row in bytes.
        ///
        /// Related SQLite: `SQLITE_LIMIT_LENGTH`
        public static let length = Self(rawValue: SQLITE_LIMIT_LENGTH)
        /// Maximum length of an SQL statement in bytes.
        ///
        /// Related SQLite: `SQLITE_LIMIT_SQL_LENGTH`
        public static let sqlLength = Self(rawValue: SQLITE_LIMIT_SQL_LENGTH)
        /// Maximum number of columns in a table definition, result set, index, ORDER BY, or GROUP BY.
        ///
        /// Related SQLite: `SQLITE_LIMIT_COLUMN`
        public static let column = Self(rawValue: SQLITE_LIMIT_COLUMN)
        /// Maximum expression parse-tree depth.
        ///
        /// Related SQLite: `SQLITE_LIMIT_EXPR_DEPTH`
        public static let exprDepth = Self(rawValue: SQLITE_LIMIT_EXPR_DEPTH)
        /// Maximum terms in a compound SELECT.
        ///
        /// Related SQLite: `SQLITE_LIMIT_COMPOUND_SELECT`
        public static let compoundSelect = Self(rawValue: SQLITE_LIMIT_COMPOUND_SELECT)
        /// Maximum opcodes in a single prepared statement VM program.
        ///
        /// Related SQLite: `SQLITE_LIMIT_VDBE_OP`
        public static let vdbeOp = Self(rawValue: SQLITE_LIMIT_VDBE_OP)
        /// Maximum number of arguments on a function.
        ///
        /// Related SQLite: `SQLITE_LIMIT_FUNCTION_ARG`
        public static let functionArg = Self(rawValue: SQLITE_LIMIT_FUNCTION_ARG)
        /// Maximum number of attached databases.
        ///
        /// Related SQLite: `SQLITE_LIMIT_ATTACHED`
        public static let attached = Self(rawValue: SQLITE_LIMIT_ATTACHED)
        /// Maximum pattern length for LIKE or GLOB.
        ///
        /// Related SQLite: `SQLITE_LIMIT_LIKE_PATTERN_LENGTH`
        public static let likePatternLength = Self(rawValue: SQLITE_LIMIT_LIKE_PATTERN_LENGTH)
        /// Maximum parameter index in a statement.
        ///
        /// Related SQLite: `SQLITE_LIMIT_VARIABLE_NUMBER`
        public static let variableNumber = Self(rawValue: SQLITE_LIMIT_VARIABLE_NUMBER)
        /// Maximum trigger recursion depth.
        ///
        /// Related SQLite: `SQLITE_LIMIT_TRIGGER_DEPTH`
        public static let triggerDepth = Self(rawValue: SQLITE_LIMIT_TRIGGER_DEPTH)
        /// Maximum auxiliary worker threads a prepared statement may start.
        ///
        /// Related SQLite: `SQLITE_LIMIT_WORKER_THREADS`
        public static let workerThreads = Self(rawValue: SQLITE_LIMIT_WORKER_THREADS)

        /// Debug label for the limit category.
        ///
        /// Related SQLite: `SQLITE_LIMIT_*`
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

    /// Reads the current run-time limit for the given category on this connection.
    /// - Parameter category: Limit to query.
    /// - Returns: Current value for the limit.
    ///
    /// Related SQLite: `sqlite3_limit`, `SQLITE_LIMIT_*`
    @inlinable public func limit(for category: LimitCategory) -> Int32 {
        sqlite3_limit(rawValue, category.rawValue, -1)
    }

    /// Sets a run-time limit for this connection and returns the previous value.
    /// - Parameters:
    ///   - limit: New limit value; pass a negative number to leave the limit unchanged.
    ///   - category: Limit to update.
    /// - Returns: Prior value of the limit.
    ///
    /// Related SQLite: `sqlite3_limit`, `SQLITE_LIMIT_*`
    @discardableResult @inlinable public func setLimit(_ limit: Int32, for category: LimitCategory) -> Int32 {
        sqlite3_limit(rawValue, category.rawValue, limit)
    }
}
