import MissedSwiftSQLite

extension Statement {
    @inlinable public func step() -> ResultCode {
        sqlite3_step(rawValue).resultCode
    }
}
