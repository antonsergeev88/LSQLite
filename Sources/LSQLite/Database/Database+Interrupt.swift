import MissedSwiftSQLite

extension Database {
    /**
     CAPI3REF: Interrupt A Long-Running Query
     METHOD: sqlite3

     ^This function causes any pending database operation to abort and
     return at its earliest opportunity. This routine is typically
     called in response to a user action such as pressing "Cancel"
     or Ctrl-C where the user wants a long query operation to halt
     immediately.

     ^It is safe to call this routine from a thread different from the
     thread that is currently running the database operation.  But it
     is not safe to call this routine with a [database connection] that
     is closed or might close before sqlite3_interrupt() returns.

     ^If an SQL operation is very nearly finished at the time when
     sqlite3_interrupt() is called, then it might not have an opportunity
     to be interrupted and might continue to completion.

     ^An SQL operation that is interrupted will return [SQLITE_INTERRUPT].
     ^If the interrupted SQL operation is an INSERT, UPDATE, or DELETE
     that is inside an explicit transaction, then the entire transaction
     will be rolled back automatically.

     ^The sqlite3_interrupt(D) call is in effect until all currently running
     SQL statements on [database connection] D complete.  ^Any new SQL statements
     that are started after the sqlite3_interrupt() call and before the
     running statements reaches zero are interrupted as if they had been
     running prior to the sqlite3_interrupt() call.  ^New SQL statements
     that are started after the running statement count reaches zero are
     not effected by the sqlite3_interrupt().
     ^A call to sqlite3_interrupt(D) that occurs when there are no running
     SQL statements is a no-op and has no effect on SQL statements
     that are started after the sqlite3_interrupt() call returns.
     */
    @inlinable public func interrupt() {
        sqlite3_interrupt(rawValue)
    }
}
