import MissedSwiftSQLite

extension Database {
    /// Returns the next prepared statement on this connection.
    /// - Parameter statement: The current statement, or nil to fetch the first.
    /// - Returns: The next statement, or nil if none exist.
    ///
    /// Related SQLite: `sqlite3_next_stmt`
    @inlinable public func nextStatement(after statement: Statement?) -> Statement? {
        return sqlite3_next_stmt(rawValue, statement?.rawValue).map(Statement.init(rawValue:))
    }
}
