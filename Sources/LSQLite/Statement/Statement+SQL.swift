import SQLite3

extension Statement {
    @inlinable public var sql: UnsafePointer<Int8>? {
        sqlite3_sql(rawValue)
    }

    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    @inlinable public var expandedSql: UnsafeMutablePointer<Int8>? {
        sqlite3_expanded_sql(rawValue)
    }
}
