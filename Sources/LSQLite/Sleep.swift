import MissedSwiftSQLite

@inlinable public func sleep(_ milliseconds: Int32) -> Int32 {
    sqlite3_sleep(milliseconds)
}
