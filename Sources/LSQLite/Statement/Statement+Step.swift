import SQLite3

extension Statement {
    @inlinable public func step() -> ResultCode {
        sqlite3_step(rawValue).resultCode
    }
}
