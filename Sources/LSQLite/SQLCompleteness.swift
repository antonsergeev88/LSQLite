import MissedSwiftSQLite

/**
 CAPI3REF: Determine If An SQL Statement Is Complete

 These routines are useful during command-line input to determine if the
 currently entered text seems to form a complete SQL statement or
 if additional input is needed before sending the text into
 SQLite for parsing.  ^These routines return 1 if the input string
 appears to be a complete SQL statement.  ^A statement is judged to be
 complete if it ends with a semicolon token and is not a prefix of a
 well-formed CREATE TRIGGER statement.  ^Semicolons that are embedded within
 string literals or quoted identifier names or comments are not
 independent tokens (they are part of the token in which they are
 embedded) and thus do not count as a statement terminator.  ^Whitespace
 and comments that follow the final semicolon are ignored.

 ^These routines return 0 if the statement is incomplete.  ^If a
 memory allocation fails, then SQLITE_NOMEM is returned.

 ^These routines do not parse the SQL statements thus
 will not detect syntactically incorrect SQL.

 ^(If SQLite has not been initialized using [sqlite3_initialize()] prior
 to invoking sqlite3_complete16() then sqlite3_initialize() is invoked
 automatically by sqlite3_complete16().  If that initialization fails,
 then the return value from sqlite3_complete16() will be non-zero
 regardless of whether or not the input SQL is complete.)^

 The input to [sqlite3_complete()] must be a zero-terminated
 UTF-8 string.

 The input to [sqlite3_complete16()] must be a zero-terminated
 UTF-16 string in native byte order.
*/
@inlinable public func sqlIsComplete(_ sql: UnsafePointer<Int8>) -> Bool {
    sqlite3_complete(sql) != 0
}
