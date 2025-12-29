import MissedSwiftSQLite

extension Connection {
    /// Returns the absolute filename for the named database on this connection.
    /// - Parameter name: Database name such as `"main"` or `"temp"`.
    /// - Returns: Absolute path, or `nil` for in-memory or temporary databases.
    ///
    /// Related SQLite: `sqlite3_db_filename`, `sqlite3_vfs.xFullPathname`
    @inlinable public func filename(forDatabaseNamed name: String) -> String? {
        let cString = sqlite3_db_filename(rawValue, name)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        return string
    }
}
