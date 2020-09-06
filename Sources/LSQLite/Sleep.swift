import MissedSwiftSQLite

/**
 CAPI3REF: Suspend Execution For A Short Time

 The sqlite3_sleep() function causes the current thread to suspend execution
 for at least a number of milliseconds specified in its parameter.

 If the operating system does not support sleep requests with
 millisecond time resolution, then the time will be rounded up to
 the nearest second. The number of milliseconds of sleep actually
 requested from the operating system is returned.

 ^SQLite implements this interface by calling the xSleep()
 method of the default [sqlite3_vfs] object.  If the xSleep() method
 of the default VFS is not implemented correctly, or not implemented at
 all, then the behavior of sqlite3_sleep() may deviate from the description
 in the previous paragraphs.
*/
@inlinable public func sleep(_ milliseconds: Int32) -> Int32 {
    sqlite3_sleep(milliseconds)
}
