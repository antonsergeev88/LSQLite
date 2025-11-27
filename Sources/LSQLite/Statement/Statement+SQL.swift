import MissedSwiftSQLite

extension Statement {
    /// Original SQL text used to create the statement.
    ///
    /// Related SQLite: `sqlite3_sql`
    @inlinable public var sql: UnsafePointer<Int8>? {
        sqlite3_sql(rawValue)
    }

    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    /// SQL text with bound parameters expanded; caller is responsible for freeing.
    ///
    /// Related SQLite: `sqlite3_expanded_sql`
    @inlinable public var expandedSql: UnsafeMutablePointer<Int8>? {
        sqlite3_expanded_sql(rawValue)
    }
}
