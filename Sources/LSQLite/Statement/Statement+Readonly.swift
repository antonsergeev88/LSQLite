import MissedSwiftSQLite

extension Statement {
    @inlinable public var isReadonly: Bool {
        sqlite3_stmt_readonly(rawValue) != 0
    }
}
