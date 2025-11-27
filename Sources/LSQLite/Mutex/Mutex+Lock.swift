import MissedSwiftSQLite

extension Mutex {
    /// Locks the mutex, blocking until it becomes available.
    ///
    /// Related SQLite: `sqlite3_mutex_enter`, `sqlite3_mutex_try`
    @inlinable public func enter() {
        sqlite3_mutex_enter(rawValue)
    }

    /// Attempts to lock the mutex without blocking; returns `.ok` or `.busy`.
    ///
    /// Related SQLite: `sqlite3_mutex_try`
    @inlinable public func `try`() -> ResultCode {
        sqlite3_mutex_try(rawValue).resultCode
    }

    /// Unlocks the mutex previously entered by this thread.
    ///
    /// Related SQLite: `sqlite3_mutex_leave`
    @inlinable public func leave() {
        sqlite3_mutex_leave(rawValue)
    }
}
