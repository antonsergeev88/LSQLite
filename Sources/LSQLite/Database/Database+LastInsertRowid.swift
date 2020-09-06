import MissedSwiftSQLite

extension Database {
    /**
     CAPI3REF: Last Insert Rowid
     METHOD: sqlite3

     ^Each entry in most SQLite tables (except for [WITHOUT ROWID] tables)
     has a unique 64-bit signed
     integer key called the [ROWID | "rowid"]. ^The rowid is always available
     as an undeclared column named ROWID, OID, or _ROWID_ as long as those
     names are not also used by explicitly declared columns. ^If
     the table has a column of type [INTEGER PRIMARY KEY] then that column
     is another alias for the rowid.

     ^The sqlite3_last_insert_rowid(D) interface usually returns the [rowid] of
     the most recent successful [INSERT] into a rowid table or [virtual table]
     on database connection D. ^Inserts into [WITHOUT ROWID] tables are not
     recorded. ^If no successful [INSERT]s into rowid tables have ever occurred
     on the database connection D, then sqlite3_last_insert_rowid(D) returns
     zero.

     As well as being set automatically as rows are inserted into database
     tables, the value returned by this function may be set explicitly by
     [sqlite3_set_last_insert_rowid()]

     Some virtual table implementations may INSERT rows into rowid tables as
     part of committing a transaction (e.g. to flush data accumulated in memory
     to disk). In this case subsequent calls to this function return the rowid
     associated with these internal INSERT operations, which leads to
     unintuitive results. Virtual table implementations that do write to rowid
     tables in this way can avoid this problem by restoring the original
     rowid value using [sqlite3_set_last_insert_rowid()] before returning
     control to the user.

     ^(If an [INSERT] occurs within a trigger then this routine will
     return the [rowid] of the inserted row as long as the trigger is
     running. Once the trigger program ends, the value returned
     by this routine reverts to what it was before the trigger was fired.)^

     ^An [INSERT] that fails due to a constraint violation is not a
     successful [INSERT] and does not change the value returned by this
     routine.  ^Thus INSERT OR FAIL, INSERT OR IGNORE, INSERT OR ROLLBACK,
     and INSERT OR ABORT make no changes to the return value of this
     routine when their insertion fails.  ^(When INSERT OR REPLACE
     encounters a constraint violation, it does not fail.  The
     INSERT continues to completion after deleting rows that caused
     the constraint problem so INSERT OR REPLACE will always change
     the return value of this interface.)^

     ^For the purposes of this routine, an [INSERT] is considered to
     be successful even if it is subsequently rolled back.

     This function is accessible to SQL statements via the
     [last_insert_rowid() SQL function].

     If a separate thread performs a new [INSERT] on the same
     database connection while the [sqlite3_last_insert_rowid()]
     function is running and thus changes the last insert [rowid],
     then the value returned by [sqlite3_last_insert_rowid()] is
     unpredictable and might not equal either the old or the new
     last insert [rowid].
     */
    @inlinable public func lastInsertedRowID() -> RowID {
        RowID(rawValue: sqlite3_last_insert_rowid(rawValue))
    }

    /**
     CAPI3REF: Set the Last Insert Rowid value.
     METHOD: sqlite3

     The sqlite3_set_last_insert_rowid(D, R) method allows the application to
     set the value returned by calling sqlite3_last_insert_rowid(D) to R
     without inserting a row into the database.
     */
    @inlinable public func setLastInsertedRowID(_ rowID: RowID) {
        sqlite3_set_last_insert_rowid(rawValue, rowID.rawValue)
    }
}
