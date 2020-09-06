import MissedSwiftSQLite

extension Database {
    @inlinable public func nextStatement(after statement: Statement?) -> Statement? {
        Statement(rawValue: sqlite3_next_stmt(rawValue, statement?.rawValue))
    }
}
