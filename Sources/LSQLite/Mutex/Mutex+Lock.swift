import MissedSwiftSQLite

extension Mutex {
    @inlinable public func enter() {
        sqlite3_mutex_enter(rawValue)
    }

    @inlinable public func `try`() -> ResultCode {
        sqlite3_mutex_try(rawValue).resultCode
    }

    @inlinable public func leave() {
        sqlite3_mutex_leave(rawValue)
    }
}
