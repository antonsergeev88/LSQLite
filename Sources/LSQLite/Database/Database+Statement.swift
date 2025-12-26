import SQLite3

extension Database {
    /// Returns the next prepared statement on this connection after the given one, or the first when `statement` is `nil`.
    ///
    /// Related SQLite: `sqlite3_next_stmt`, `sqlite3_prepare_v2`, `sqlite3_finalize`
    @inlinable public func nextStatement(after statement: Statement?) -> Statement? {
        return sqlite3_next_stmt(rawValue, statement?.rawValue).map(Statement.init(rawValue:))
    }
}
