import MissedSwiftSQLite

extension Database {
    /**
     CAPI3REF: Test For Auto-Commit Mode
     KEYWORDS: {autocommit mode}
     METHOD: sqlite3

     ^The sqlite3_get_autocommit() interface returns non-zero or
     zero if the given database connection is or is not in autocommit mode,
     respectively.  ^Autocommit mode is on by default.
     ^Autocommit mode is disabled by a [BEGIN] statement.
     ^Autocommit mode is re-enabled by a [COMMIT] or [ROLLBACK].

     If certain kinds of errors occur on a statement within a multi-statement
     transaction (errors including [SQLITE_FULL], [SQLITE_IOERR],
     [SQLITE_NOMEM], [SQLITE_BUSY], and [SQLITE_INTERRUPT]) then the
     transaction might be rolled back automatically.  The only way to
     find out whether SQLite automatically rolled back the transaction after
     an error is to use this function.

     If another thread changes the autocommit status of the database
     connection while this routine is running, then the return value
     is undefined.
     */
    @inlinable public var isAutocommit: Bool {
        sqlite3_get_autocommit(rawValue) != 0
    }
}
