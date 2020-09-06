import MissedSwiftSQLite

extension Database {
    /**
     CAPI3REF: Find the next prepared statement
     METHOD: sqlite3

     ^This interface returns a pointer to the next [prepared statement] after
     pStmt associated with the [database connection] pDb.  ^If pStmt is NULL
     then this interface returns a pointer to the first prepared statement
     associated with the database connection pDb.  ^If no prepared statement
     satisfies the conditions of this routine, it returns NULL.

     The [database connection] pointer D in a call to
     [sqlite3_next_stmt(D,S)] must refer to an open database
     connection and in particular must not be a NULL pointer.
     */
    @inlinable public func nextStatement(after statement: Statement?) -> Statement? {
        return sqlite3_next_stmt(rawValue, statement?.rawValue).map(Statement.init(rawValue:))
    }
}
