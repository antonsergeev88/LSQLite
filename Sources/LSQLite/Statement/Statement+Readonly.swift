import MissedSwiftSQLite

extension Statement {
    /**
     CAPI3REF: Determine If An SQL Statement Writes The Database
     METHOD: sqlite3_stmt

     ^The sqlite3_stmt_readonly(X) interface returns true (non-zero) if
     and only if the [prepared statement] X makes no direct changes to
     the content of the database file.

     Note that [application-defined SQL functions] or
     [virtual tables] might change the database indirectly as a side effect.
     ^(For example, if an application defines a function "eval()" that
     calls [sqlite3_exec()], then the following SQL statement would
     change the database file through side-effects:

     <blockquote><pre>
        SELECT eval('DELETE FROM t1') FROM t2;
     </pre></blockquote>

     But because the [SELECT] statement does not change the database file
     directly, sqlite3_stmt_readonly() would still return true.)^

     ^Transaction control statements such as [BEGIN], [COMMIT], [ROLLBACK],
     [SAVEPOINT], and [RELEASE] cause sqlite3_stmt_readonly() to return true,
     since the statements themselves do not actually modify the database but
     rather they control the timing of when other statements modify the
     database.  ^The [ATTACH] and [DETACH] statements also cause
     sqlite3_stmt_readonly() to return true since, while those statements
     change the configuration of a database connection, they do not make
     changes to the content of the database files on disk.
     ^The sqlite3_stmt_readonly() interface returns true for [BEGIN] since
     [BEGIN] merely sets internal flags, but the [BEGIN|BEGIN IMMEDIATE] and
     [BEGIN|BEGIN EXCLUSIVE] commands do touch the database and so
     sqlite3_stmt_readonly() returns false for those commands.
    */
    @inlinable public var isReadonly: Bool {
        sqlite3_stmt_readonly(rawValue) != 0
    }
}
