import MissedSwiftSQLite

extension Statement {
    /**
     CAPI3REF: Destroy A Prepared Statement Object
     DESTRUCTOR: sqlite3_stmt

     ^The sqlite3_finalize() function is called to delete a [prepared statement].
     ^If the most recent evaluation of the statement encountered no errors
     or if the statement is never been evaluated, then sqlite3_finalize() returns
     SQLITE_OK.  ^If the most recent evaluation of statement S failed, then
     sqlite3_finalize(S) returns the appropriate [error code] or
     [extended error code].

     ^The sqlite3_finalize(S) routine can be called at any point during
     the life cycle of [prepared statement] S:
     before statement S is ever evaluated, after
     one or more calls to [sqlite3_reset()], or after any call
     to [sqlite3_step()] regardless of whether or not the statement has
     completed execution.

     ^Invoking sqlite3_finalize() on a NULL pointer is a harmless no-op.

     The application must finalize every [prepared statement] in order to avoid
     resource leaks.  It is a grievous error for the application to try to use
     a prepared statement after it has been finalized.  Any use of a prepared
     statement after it has been finalized can result in undefined and
     undesirable behavior such as segfaults and heap corruption.
    */
    @inlinable public func finalize() -> ResultCode {
        sqlite3_finalize(rawValue).resultCode
    }
}
