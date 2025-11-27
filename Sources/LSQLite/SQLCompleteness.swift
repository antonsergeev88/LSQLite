import MissedSwiftSQLite

/// Returns whether the UTF-8 SQL text ends with a complete statement (semicolon-aware trigger handling).
/// - Parameter sql: Zero-terminated UTF-8 SQL source.
/// - Returns: `true` if SQLite considers the SQL complete.
///
/// Related SQLite: `sqlite3_complete`, `sqlite3_complete16`, `sqlite3_initialize`
@inlinable public func sqlIsComplete(_ sql: UnsafePointer<Int8>) -> Bool {
    sqlite3_complete(sql) != 0
}
