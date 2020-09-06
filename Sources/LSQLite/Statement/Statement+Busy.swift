import MissedSwiftSQLite

extension Statement {
    /**
     CAPI3REF: Determine If A Prepared Statement Has Been Reset
     METHOD: sqlite3_stmt

     ^The sqlite3_stmt_busy(S) interface returns true (non-zero) if the
     [prepared statement] S has been stepped at least once using
     [sqlite3_step(S)] but has neither run to completion (returned
     [SQLITE_DONE] from [sqlite3_step(S)]) nor
     been reset using [sqlite3_reset(S)].  ^The sqlite3_stmt_busy(S)
     interface returns false if S is a NULL pointer.  If S is not a
     NULL pointer and is not a pointer to a valid [prepared statement]
     object, then the behavior is undefined and probably undesirable.

     This interface can be used in combination [sqlite3_next_stmt()]
     to locate all prepared statements associated with a database
     connection that are in need of being reset.  This can be used,
     for example, in diagnostic routines to search for prepared
     statements that are holding a transaction open.
     */
    @inlinable public var isBusy: Bool {
        sqlite3_stmt_busy(rawValue) != 0
    }
}
