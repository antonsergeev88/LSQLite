import MissedSwiftSQLite

extension Statement {
    /**
     CAPI3REF: Evaluate An SQL Statement
     METHOD: sqlite3_stmt

     After a [prepared statement] has been prepared using any of
     [sqlite3_prepare_v2()], [sqlite3_prepare_v3()], [sqlite3_prepare16_v2()],
     or [sqlite3_prepare16_v3()] or one of the legacy
     interfaces [sqlite3_prepare()] or [sqlite3_prepare16()], this function
     must be called one or more times to evaluate the statement.

     The details of the behavior of the sqlite3_step() interface depend
     on whether the statement was prepared using the newer "vX" interfaces
     [sqlite3_prepare_v3()], [sqlite3_prepare_v2()], [sqlite3_prepare16_v3()],
     [sqlite3_prepare16_v2()] or the older legacy
     interfaces [sqlite3_prepare()] and [sqlite3_prepare16()].  The use of the
     new "vX" interface is recommended for new applications but the legacy
     interface will continue to be supported.

     ^In the legacy interface, the return value will be either [SQLITE_BUSY],
     [SQLITE_DONE], [SQLITE_ROW], [SQLITE_ERROR], or [SQLITE_MISUSE].
     ^With the "v2" interface, any of the other [result codes] or
     [extended result codes] might be returned as well.

     ^[SQLITE_BUSY] means that the database engine was unable to acquire the
     database locks it needs to do its job.  ^If the statement is a [COMMIT]
     or occurs outside of an explicit transaction, then you can retry the
     statement.  If the statement is not a [COMMIT] and occurs within an
     explicit transaction then you should rollback the transaction before
     continuing.

     ^[SQLITE_DONE] means that the statement has finished executing
     successfully.  sqlite3_step() should not be called again on this virtual
     machine without first calling [sqlite3_reset()] to reset the virtual
     machine back to its initial state.

     ^If the SQL statement being executed returns any data, then [SQLITE_ROW]
     is returned each time a new row of data is ready for processing by the
     caller. The values may be accessed using the [column access functions].
     sqlite3_step() is called again to retrieve the next row of data.

     ^[SQLITE_ERROR] means that a run-time error (such as a constraint
     violation) has occurred.  sqlite3_step() should not be called again on
     the VM. More information may be found by calling [sqlite3_errmsg()].
     ^With the legacy interface, a more specific error code (for example,
     [SQLITE_INTERRUPT], [SQLITE_SCHEMA], [SQLITE_CORRUPT], and so forth)
     can be obtained by calling [sqlite3_reset()] on the
     [prepared statement].  ^In the "v2" interface,
     the more specific error code is returned directly by sqlite3_step().

     [SQLITE_MISUSE] means that the this routine was called inappropriately.
     Perhaps it was called on a [prepared statement] that has
     already been [sqlite3_finalize | finalized] or on one that had
     previously returned [SQLITE_ERROR] or [SQLITE_DONE].  Or it could
     be the case that the same database connection is being used by two or
     more threads at the same moment in time.

     For all versions of SQLite up to and including 3.6.23.1, a call to
     [sqlite3_reset()] was required after sqlite3_step() returned anything
     other than [SQLITE_ROW] before any subsequent invocation of
     sqlite3_step().  Failure to reset the prepared statement using
     [sqlite3_reset()] would result in an [SQLITE_MISUSE] return from
     sqlite3_step().  But after [version 3.6.23.1] ([dateof:3.6.23.1],
     sqlite3_step() began
     calling [sqlite3_reset()] automatically in this circumstance rather
     than returning [SQLITE_MISUSE].  This is not considered a compatibility
     break because any application that ever receives an SQLITE_MISUSE error
     is broken by definition.  The [SQLITE_OMIT_AUTORESET] compile-time option
     can be used to restore the legacy behavior.

     <b>Goofy Interface Alert:</b> In the legacy interface, the sqlite3_step()
     API always returns a generic error code, [SQLITE_ERROR], following any
     error other than [SQLITE_BUSY] and [SQLITE_MISUSE].  You must call
     [sqlite3_reset()] or [sqlite3_finalize()] in order to find one of the
     specific [error codes] that better describes the error.
     We admit that this is a goofy design.  The problem has been fixed
     with the "v2" interface.  If you prepare all of your SQL statements
     using [sqlite3_prepare_v3()] or [sqlite3_prepare_v2()]
     or [sqlite3_prepare16_v2()] or [sqlite3_prepare16_v3()] instead
     of the legacy [sqlite3_prepare()] and [sqlite3_prepare16()] interfaces,
     then the more specific [error codes] are returned directly
     by sqlite3_step().  The use of the "vX" interfaces is recommended.
     */
    @inlinable public func step() -> ResultCode {
        sqlite3_step(rawValue).resultCode
    }
}
