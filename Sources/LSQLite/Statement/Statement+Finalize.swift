import MissedSwiftSQLite

extension Statement {
    @inlinable public func finalize() -> ResultCode {
        sqlite3_finalize(rawValue).resultCode
    }
}
