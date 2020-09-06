import MissedSwiftSQLite

extension Context {
    @inlinable public var userData: UnsafeMutableRawPointer? {
        sqlite3_user_data(rawValue)
    }
}
