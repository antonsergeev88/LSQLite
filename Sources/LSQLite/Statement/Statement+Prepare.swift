import MissedSwiftSQLite

extension Statement {
    /// Flags for sqlite3_prepare_v3 prepFlags argument.
    ///
    /// Related SQLite: `sqlite3_prepare_v3`, `SQLITE_PREPARE_PERSISTENT`, `SQLITE_PREPARE_NORMALIZE`, `SQLITE_PREPARE_NO_VTAB`
    @frozen public struct PrepareFlag: OptionSet, CustomStringConvertible, CustomDebugStringConvertible {
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

        private static let knownMask: UInt32 = Self.persistent.rawValue
            | Self.normalize.rawValue
            | Self.noVTab.rawValue

        private static func hexString(_ rawValue: UInt32) -> String {
            "0x" + String(rawValue, radix: 16, uppercase: true)
        }

        public var description: String {
            var parts: [String] = []
            if contains(.persistent) { parts.append(".persistent") }
            if contains(.normalize) { parts.append(".normalize") }
            if contains(.noVTab) { parts.append(".noVTab") }

            let unknownBits = rawValue & ~Self.knownMask
            if unknownBits != 0 {
                if parts.isEmpty { return "unknown" }
                parts.append("unknown")
            }
            if parts.isEmpty { return "[]" }
            return "[\(parts.joined(separator: ", "))]"
        }

        public var debugDescription: String {
            var parts: [String] = []
            if contains(.persistent) { parts.append("SQLITE_PREPARE_PERSISTENT") }
            if contains(.normalize) { parts.append("SQLITE_PREPARE_NORMALIZE") }
            if contains(.noVTab) { parts.append("SQLITE_PREPARE_NO_VTAB") }

            let unknownBits = rawValue & ~Self.knownMask
            if unknownBits != 0 {
                let hexValue = Self.hexString(rawValue)
                if parts.isEmpty { return hexValue }
                parts.append(hexValue)
            }
            if parts.isEmpty { return "[]" }
            return parts.joined(separator: "|")
        }
    }

    /// Compiles UTF-8 SQL into a prepared statement using sqlite3_prepare_v2.
    ///
    /// Related SQLite: `sqlite3_prepare_v2`, `sqlite3_finalize`, `sqlite3_step`
    @inlinable public static func prepare(_ statement: inout Statement?, sql: String, for database: Database) -> ResultCode {
        var tail: String?
        return prepare(&statement, sql: sql, tail: &tail, for: database)
    }

    /// Compiles UTF-8 SQL into a prepared statement using sqlite3_prepare_v2.
    /// - Parameter tail: Receives the remaining SQL text, if any.
    ///
    /// Related SQLite: `sqlite3_prepare_v2`, `sqlite3_finalize`, `sqlite3_step`
    @inlinable public static func prepare(_ statement: inout Statement?, sql: String, tail: inout String?, for database: Database) -> ResultCode {
        var statementPointer: OpaquePointer?
        var tailString: String?
        let resultCode = sql.withCString { cString in
            var tailPointer: UnsafePointer<Int8>?
            let result = sqlite3_prepare_v2(database.rawValue, cString, -1, &statementPointer, &tailPointer).resultCode
            tailString = tailPointer.map { String(cString: $0) }
            return result
        }
        tail = tailString
        statement = statementPointer.map(Statement.init(rawValue:))
        return resultCode
    }

    /// Compiles UTF-8 SQL with sqlite3_prepare_v3 using the provided flags.
    ///
    /// Related SQLite: `sqlite3_prepare_v3`, `sqlite3_finalize`, `sqlite3_step`
    @available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
    @inlinable public static func prepare(_ statement: inout Statement?, sql: String, for database: Database, prepareFlag: PrepareFlag) -> ResultCode {
        var tail: String?
        return prepare(&statement, sql: sql, tail: &tail, for: database, prepareFlag: prepareFlag)
    }

    /// Compiles UTF-8 SQL with sqlite3_prepare_v3 using the provided flags.
    /// - Parameter tail: Receives the remaining SQL text, if any.
    ///
    /// Related SQLite: `sqlite3_prepare_v3`, `sqlite3_finalize`, `sqlite3_step`
    @available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
    @inlinable public static func prepare(_ statement: inout Statement?, sql: String, tail: inout String?, for database: Database, prepareFlag: PrepareFlag) -> ResultCode {
        var statementPointer: OpaquePointer? = nil
        var tailString: String? = nil
        let resultCode = sql.withCString { cString in
            var tailPointer: UnsafePointer<Int8>? = nil
            let result = sqlite3_prepare_v3(database.rawValue, cString, -1, prepareFlag.rawValue, &statementPointer, &tailPointer).resultCode
            tailString = tailPointer.map { String(cString: $0) }
            return result
        }
        tail = tailString
        statement = statementPointer.map(Statement.init(rawValue:))
        return resultCode
    }
}
