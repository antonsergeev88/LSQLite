import MissedSwiftSQLite

extension Database {
    @inlinable public var isAutocommit: Bool {
        sqlite3_get_autocommit(rawValue) != 0
    }
}
