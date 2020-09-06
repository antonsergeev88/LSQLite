import MissedSwiftSQLite

@inlinable public func initialize() -> ResultCode {
    sqlite3_initialize().resultCode
}

@inlinable public func shutdown() -> ResultCode {
    sqlite3_shutdown().resultCode
}
