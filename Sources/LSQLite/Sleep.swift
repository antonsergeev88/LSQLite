import MissedSwiftSQLite

/// Suspends the current thread for at least the given number of milliseconds using SQLite's VFS sleep hook.
/// - Parameter milliseconds: Minimum time to pause.
/// - Returns: The millisecond duration requested from the VFS.
///
/// Related SQLite: `sqlite3_sleep`, `sqlite3_vfs.xSleep`
@inlinable public func sleep(_ milliseconds: Int32) -> Int32 {
    sqlite3_sleep(milliseconds)
}
