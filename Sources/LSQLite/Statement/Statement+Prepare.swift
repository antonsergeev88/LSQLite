import MissedSwiftSQLite

extension Statement {
    /// Options that control statement compilation.
    /// Use these flags with `prepare(..., prepareFlag:)`.
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

    /// Compiles the first statement in a UTF-8 SQL string.
    /// - Parameters:
    ///   - statement: Receives the prepared statement, or nil if the input
    ///     contains no SQL.
    ///   - sql: SQL text to compile.
    ///   - connection: Connection used to compile the statement.
    /// - Returns: Result code from compilation.
    ///
    /// Related SQLite: `sqlite3_prepare_v2`
    @inlinable public static func prepare(_ statement: inout Statement?, sql: String, for connection: Connection) -> ResultCode {
        var tail: String?
        return prepare(&statement, sql: sql, tail: &tail, for: connection)
    }

    /// Compiles the first statement in a UTF-8 SQL string.
    /// - Parameters:
    ///   - statement: Receives the prepared statement, or nil if the input
    ///     contains no SQL.
    ///   - sql: SQL text to compile.
    ///   - tail: Receives any remaining SQL text after the first statement.
    ///   - connection: Connection used to compile the statement.
    /// - Returns: Result code from compilation.
    ///
    /// Related SQLite: `sqlite3_prepare_v2`
    @inlinable public static func prepare(_ statement: inout Statement?, sql: String, tail: inout String?, for connection: Connection) -> ResultCode {
        var statementPointer: OpaquePointer?
        var tailString: String?
        let resultCode = sql.withCString { cString in
            var tailPointer: UnsafePointer<Int8>?
            let result = sqlite3_prepare_v2(connection.rawValue, cString, -1, &statementPointer, &tailPointer).resultCode
            tailString = tailPointer.map { String(cString: $0) }
            return result
        }
        tail = tailString
        statement = statementPointer.map(Statement.init(rawValue:))
        return resultCode
    }

    /// Compiles the first statement in a UTF-8 SQL string with compilation options.
    /// - Parameters:
    ///   - statement: Receives the prepared statement, or nil if the input
    ///     contains no SQL.
    ///   - sql: SQL text to compile.
    ///   - connection: Connection used to compile the statement.
    ///   - prepareFlag: Options that influence compilation.
    /// - Returns: Result code from compilation.
    ///
    /// Related SQLite: `sqlite3_prepare_v3`
    @available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
    @inlinable public static func prepare(_ statement: inout Statement?, sql: String, for connection: Connection, prepareFlag: PrepareFlag) -> ResultCode {
        var tail: String?
        return prepare(&statement, sql: sql, tail: &tail, for: connection, prepareFlag: prepareFlag)
    }

    /// Compiles the first statement in a UTF-8 SQL string with compilation options.
    /// - Parameters:
    ///   - statement: Receives the prepared statement, or nil if the input
    ///     contains no SQL.
    ///   - sql: SQL text to compile.
    ///   - tail: Receives any remaining SQL text after the first statement.
    ///   - connection: Connection used to compile the statement.
    ///   - prepareFlag: Options that influence compilation.
    /// - Returns: Result code from compilation.
    ///
    /// Related SQLite: `sqlite3_prepare_v3`
    @available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
    @inlinable public static func prepare(_ statement: inout Statement?, sql: String, tail: inout String?, for connection: Connection, prepareFlag: PrepareFlag) -> ResultCode {
        var statementPointer: OpaquePointer? = nil
        var tailString: String? = nil
        let resultCode = sql.withCString { cString in
            var tailPointer: UnsafePointer<Int8>? = nil
            let result = sqlite3_prepare_v3(connection.rawValue, cString, -1, prepareFlag.rawValue, &statementPointer, &tailPointer).resultCode
            tailString = tailPointer.map { String(cString: $0) }
            return result
        }
        tail = tailString
        statement = statementPointer.map(Statement.init(rawValue:))
        return resultCode
    }
}
