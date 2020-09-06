import MissedSwiftSQLite

extension Database {
    @inlinable public func nextStatement(after statement: Statement?) -> Statement? {
        return sqlite3_next_stmt(rawValue, statement?.rawValue).map(Statement.init(rawValue:))
    }
}
