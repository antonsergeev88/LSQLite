import MissedSwiftSQLite

extension Statement {
    @inlinable public func reset() -> ResultCode {
        sqlite3_reset(rawValue).resultCode
    }
}
