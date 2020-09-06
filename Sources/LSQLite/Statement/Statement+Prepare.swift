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

    public mutating func prepare(_ sql: UnsafePointer<Int8>, tail: UnsafeMutablePointer<UnsafePointer<Int8>?>? = nil, for database: Database) -> ResultCode {
        sqlite3_prepare_v2(database.rawValue, sql, -1, &rawValue, tail).resultCode
    }

    @available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
    public mutating func prepare(_ sql: UnsafePointer<Int8>, tail: UnsafeMutablePointer<UnsafePointer<Int8>?>? = nil, for database: Database, prepareFlag: PrepareFlag) -> ResultCode {
        sqlite3_prepare_v3(database.rawValue, sql, -1, prepareFlag.rawValue, &rawValue, tail).resultCode
    }
}
