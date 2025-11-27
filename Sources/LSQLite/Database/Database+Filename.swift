import MissedSwiftSQLite

extension Database {
    /// Returns the absolute filename for the named database on this connection.
    /// - Parameter name: Database name such as `"main"` or `"temp"`.
    /// - Returns: Absolute path, or `nil`/empty string for in-memory or temporary databases.
    ///
    /// Related SQLite: `sqlite3_db_filename`, `sqlite3_vfs.xFullPathname`
    @inlinable public func filename(forDatabaseNamed name: UnsafePointer<Int8>) -> UnsafePointer<Int8>? {
        sqlite3_db_filename(rawValue, name)
    }
}
