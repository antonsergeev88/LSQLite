import MissedSwiftSQLite

extension Statement {
    /**
     CAPI3REF: Reset A Prepared Statement Object
     METHOD: sqlite3_stmt

     The sqlite3_reset() function is called to reset a [prepared statement]
     object back to its initial state, ready to be re-executed.
     ^Any SQL statement variables that had values bound to them using
     the [sqlite3_bind_blob | sqlite3_bind_*() API] retain their values.
     Use [sqlite3_clear_bindings()] to reset the bindings.

     ^The [sqlite3_reset(S)] interface resets the [prepared statement] S
     back to the beginning of its program.

     ^If the most recent call to [sqlite3_step(S)] for the
     [prepared statement] S returned [SQLITE_ROW] or [SQLITE_DONE],
     or if [sqlite3_step(S)] has never before been called on S,
     then [sqlite3_reset(S)] returns [SQLITE_OK].

     ^If the most recent call to [sqlite3_step(S)] for the
     [prepared statement] S indicated an error, then
     [sqlite3_reset(S)] returns an appropriate [error code].

     ^The [sqlite3_reset(S)] interface does not change the values
     of any [sqlite3_bind_blob|bindings] on the [prepared statement] S.
     */
    @inlinable public func reset() -> ResultCode {
        sqlite3_reset(rawValue).resultCode
    }
}
