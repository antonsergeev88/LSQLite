import MissedSwiftSQLite

/// Initializes the SQLite library once for the process; normally invoked automatically but available for manual setup.
/// - Returns: Result of `sqlite3_initialize`.
///
/// Related SQLite: `sqlite3_initialize`, `sqlite3_os_init`
@inlinable public func initialize() -> ResultCode {
    sqlite3_initialize().resultCode
}

/// Shuts down SQLite global state after all connections are closed.
/// - Returns: Result of `sqlite3_shutdown`.
///
/// Related SQLite: `sqlite3_shutdown`, `sqlite3_os_end`
@inlinable public func shutdown() -> ResultCode {
    sqlite3_shutdown().resultCode
}
