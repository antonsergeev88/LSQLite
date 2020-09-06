import MissedSwiftSQLite

extension Statement {
    @inlinable public var isBusy: Bool {
        sqlite3_stmt_busy(rawValue) != 0
    }
}
