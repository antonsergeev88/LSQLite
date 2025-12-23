import MissedSwiftSQLite

/// Returns whether the UTF-8 SQL text ends with a complete statement (semicolon-aware trigger handling).
/// - Parameter sql: UTF-8 SQL source.
/// - Returns: `true` if SQLite considers the SQL complete.
///
/// Related SQLite: `sqlite3_complete`, `sqlite3_complete16`, `sqlite3_initialize`
@inlinable public func sqlIsComplete(_ sql: String) -> Bool {
    sqlite3_complete(sql) != 0
}
