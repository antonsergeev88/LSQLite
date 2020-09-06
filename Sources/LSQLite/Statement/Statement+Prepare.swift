import MissedSwiftSQLite

extension Statement {
    @frozen public struct PrepareFlag: OptionSet {
        public let rawValue: UInt32

        @inlinable public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }

        public static let persistent = Self(rawValue: UInt32(SQLITE_PREPARE_PERSISTENT))
        public static let normalize = Self(rawValue: UInt32(SQLITE_PREPARE_NORMALIZE))
        public static let noVTab = Self(rawValue: UInt32(SQLITE_PREPARE_NO_VTAB))
    }

    @inlinable public static func prepare(_ statement: inout Statement?, sql: UnsafePointer<Int8>, tail: UnsafeMutablePointer<UnsafePointer<Int8>?>? = nil, for database: Database) -> ResultCode {
        var statementPointer: OpaquePointer? = nil
        let resultCode = sqlite3_prepare_v2(database.rawValue, sql, -1, &statementPointer, tail).resultCode
        statement = statementPointer.map(Statement.init(rawValue:))
        return resultCode
    }

    @available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
    @inlinable public static func prepare(_ statement: inout Statement?, sql: UnsafePointer<Int8>, tail: UnsafeMutablePointer<UnsafePointer<Int8>?>? = nil, for database: Database, prepareFlag: PrepareFlag) -> ResultCode {
        var statementPointer: OpaquePointer? = nil
        let resultCode = sqlite3_prepare_v3(database.rawValue, sql, -1, prepareFlag.rawValue, &statementPointer, tail).resultCode
        statement = statementPointer.map(Statement.init(rawValue:))
        return resultCode
    }
}
