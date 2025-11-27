import MissedSwiftSQLite

extension Statement {
    /// Flags for sqlite3_prepare_v3 prepFlags argument.
    ///
    /// Related SQLite: `sqlite3_prepare_v3`, `SQLITE_PREPARE_PERSISTENT`, `SQLITE_PREPARE_NORMALIZE`, `SQLITE_PREPARE_NO_VTAB`
    @frozen public struct PrepareFlag: OptionSet {
        public let rawValue: UInt32

        @inlinable public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }

        /// Hint that the statement will be reused; SQLite may avoid lookaside allocations.
        ///
        /// Related SQLite: `SQLITE_PREPARE_PERSISTENT`
        public static let persistent = Self(rawValue: UInt32(SQLITE_PREPARE_PERSISTENT))
        /// Normalization flag (currently a no-op).
        ///
        /// Related SQLite: `SQLITE_PREPARE_NORMALIZE`
        public static let normalize = Self(rawValue: UInt32(SQLITE_PREPARE_NORMALIZE))
        /// Causes preparation to fail if the SQL uses virtual tables.
        ///
        /// Related SQLite: `SQLITE_PREPARE_NO_VTAB`
        public static let noVTab = Self(rawValue: UInt32(SQLITE_PREPARE_NO_VTAB))
    }

    /// Compiles UTF-8 SQL into a prepared statement using sqlite3_prepare_v2.
    ///
    /// Related SQLite: `sqlite3_prepare_v2`, `sqlite3_finalize`, `sqlite3_step`
    @inlinable public static func prepare(_ statement: inout Statement?, sql: UnsafePointer<Int8>, tail: UnsafeMutablePointer<UnsafePointer<Int8>?>? = nil, for database: Database) -> ResultCode {
        var statementPointer: OpaquePointer? = nil
        let resultCode = sqlite3_prepare_v2(database.rawValue, sql, -1, &statementPointer, tail).resultCode
        statement = statementPointer.map(Statement.init(rawValue:))
        return resultCode
    }

    @available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
    /// Compiles UTF-8 SQL with sqlite3_prepare_v3 using the provided flags.
    ///
    /// Related SQLite: `sqlite3_prepare_v3`, `sqlite3_finalize`, `sqlite3_step`
    @inlinable public static func prepare(_ statement: inout Statement?, sql: UnsafePointer<Int8>, tail: UnsafeMutablePointer<UnsafePointer<Int8>?>? = nil, for database: Database, prepareFlag: PrepareFlag) -> ResultCode {
        var statementPointer: OpaquePointer? = nil
        let resultCode = sqlite3_prepare_v3(database.rawValue, sql, -1, prepareFlag.rawValue, &statementPointer, tail).resultCode
        statement = statementPointer.map(Statement.init(rawValue:))
        return resultCode
    }
}
