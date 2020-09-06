import MissedSwiftSQLite

extension Database {
    /**
     CAPI3REF: Run-Time Limit Categories
     KEYWORDS: {limit category} {*limit categories}

     These constants define various performance limits
     that can be lowered at run-time using [sqlite3_limit()].
     The synopsis of the meanings of the various limits is shown below.
     Additional information is available at [limits | Limits in SQLite].
    */
    @frozen public struct LimitCategory: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        /// The maximum size of any string or BLOB or table row, in bytes.
        public static let length = Self(rawValue: SQLITE_LIMIT_LENGTH)
        /// The maximum length of an SQL statement, in bytes.
        public static let sqlLength = Self(rawValue: SQLITE_LIMIT_SQL_LENGTH)
        /// The maximum number of columns in a table definition or in the
        /// result set of a [SELECT] or the maximum number of columns in an index
        /// or in an ORDER BY or GROUP BY clause.
        public static let column = Self(rawValue: SQLITE_LIMIT_COLUMN)
        /// The maximum depth of the parse tree on any expression.
        public static let exprDepth = Self(rawValue: SQLITE_LIMIT_EXPR_DEPTH)
        /// The maximum number of terms in a compound SELECT statement.
        public static let compoundSelect = Self(rawValue: SQLITE_LIMIT_COMPOUND_SELECT)
        /// The maximum number of instructions in a virtual machine program
        /// used to implement an SQL statement.  If [sqlite3_prepare_v2()] or
        /// the equivalent tries to allocate space for more than this many opcodes
        /// in a single prepared statement, an SQLITE_NOMEM error is returned.
        public static let vdbeOp = Self(rawValue: SQLITE_LIMIT_VDBE_OP)
        /// The maximum number of arguments on a function.
        public static let functionArg = Self(rawValue: SQLITE_LIMIT_FUNCTION_ARG)
        /// The maximum number of [ATTACH | attached databases].
        public static let attached = Self(rawValue: SQLITE_LIMIT_ATTACHED)
        /// The maximum length of the pattern argument to the [LIKE] or
        /// [GLOB] operators.
        public static let likePatternLength = Self(rawValue: SQLITE_LIMIT_LIKE_PATTERN_LENGTH)
        /// The maximum index number of any [parameter] in an SQL statement.
        public static let variableNumber = Self(rawValue: SQLITE_LIMIT_VARIABLE_NUMBER)
        /// The maximum depth of recursion for triggers.
        public static let triggerDepth = Self(rawValue: SQLITE_LIMIT_TRIGGER_DEPTH)
        /// The maximum number of auxiliary worker threads that a single
        /// [prepared statement] may start.
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

    /**
     CAPI3REF: Run-time Limits
     METHOD: sqlite3

     ^(This interface allows the size of various constructs to be limited
     on a connection by connection basis.  The first parameter is the
     [database connection] whose limit is to be set or queried.  The
     second parameter is one of the [limit categories] that define a
     class of constructs to be size limited.  The third parameter is the
     new limit for that construct.)^

     ^If the new limit is a negative number, the limit is unchanged.
     ^(For each limit category SQLITE_LIMIT_<i>NAME</i> there is a
     [limits | hard upper bound]
     set at compile-time by a C preprocessor macro called
     [limits | SQLITE_MAX_<i>NAME</i>].
     (The "_LIMIT_" in the name is changed to "_MAX_".))^
     ^Attempts to increase a limit above its hard upper bound are
     silently truncated to the hard upper bound.

     ^Regardless of whether or not the limit was changed, the
     [sqlite3_limit()] interface returns the prior value of the limit.
     ^Hence, to find the current value of a limit without changing it,
     simply invoke this interface with the third parameter set to -1.

     Run-time limits are intended for use in applications that manage
     both their own internal database and also databases that are controlled
     by untrusted external sources.  An example application might be a
     web browser that has its own databases for storing history and
     separate databases controlled by JavaScript applications downloaded
     off the Internet.  The internal databases can be given the
     large, default limits.  Databases managed by external sources can
     be given much smaller limits designed to prevent a denial of service
     attack.  Developers might also want to use the [sqlite3_set_authorizer()]
     interface to further control untrusted SQL.  The size of the database
     created by an untrusted script can be contained using the
     [max_page_count] [PRAGMA].

     New run-time limit categories may be added in future releases.
    */
    @inlinable public func limit(for category: LimitCategory) -> Int32 {
        sqlite3_limit(rawValue, category.rawValue, -1)
    }

    /**
     CAPI3REF: Run-time Limits
     METHOD: sqlite3

     ^(This interface allows the size of various constructs to be limited
     on a connection by connection basis.  The first parameter is the
     [database connection] whose limit is to be set or queried.  The
     second parameter is one of the [limit categories] that define a
     class of constructs to be size limited.  The third parameter is the
     new limit for that construct.)^

     ^If the new limit is a negative number, the limit is unchanged.
     ^(For each limit category SQLITE_LIMIT_<i>NAME</i> there is a
     [limits | hard upper bound]
     set at compile-time by a C preprocessor macro called
     [limits | SQLITE_MAX_<i>NAME</i>].
     (The "_LIMIT_" in the name is changed to "_MAX_".))^
     ^Attempts to increase a limit above its hard upper bound are
     silently truncated to the hard upper bound.

     ^Regardless of whether or not the limit was changed, the
     [sqlite3_limit()] interface returns the prior value of the limit.
     ^Hence, to find the current value of a limit without changing it,
     simply invoke this interface with the third parameter set to -1.

     Run-time limits are intended for use in applications that manage
     both their own internal database and also databases that are controlled
     by untrusted external sources.  An example application might be a
     web browser that has its own databases for storing history and
     separate databases controlled by JavaScript applications downloaded
     off the Internet.  The internal databases can be given the
     large, default limits.  Databases managed by external sources can
     be given much smaller limits designed to prevent a denial of service
     attack.  Developers might also want to use the [sqlite3_set_authorizer()]
     interface to further control untrusted SQL.  The size of the database
     created by an untrusted script can be contained using the
     [max_page_count] [PRAGMA].

     New run-time limit categories may be added in future releases.
    */
    @discardableResult @inlinable public func setLimit(_ limit: Int32, for category: LimitCategory) -> Int32 {
        sqlite3_limit(rawValue, category.rawValue, limit)
    }
}
