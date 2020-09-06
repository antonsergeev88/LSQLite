import MissedSwiftSQLite

extension Database {
    @inlinable public func interrupt() {
        sqlite3_interrupt(rawValue)
    }
}
