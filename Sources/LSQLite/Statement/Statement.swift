/**
 CAPI3REF: Compiling An SQL Statement
 KEYWORDS: {SQL statement compiler}
 METHOD: sqlite3
 CONSTRUCTOR: sqlite3_stmt

 To execute an SQL statement, it must first be compiled into a byte-code
 program using one of these routines.  Or, in other words, these routines
 are constructors for the [prepared statement] object.

 The preferred routine to use is [sqlite3_prepare_v2()].  The
 [sqlite3_prepare()] interface is legacy and should be avoided.
 [sqlite3_prepare_v3()] has an extra "prepFlags" option that is used
 for special purposes.

 The use of the UTF-8 interfaces is preferred, as SQLite currently
 does all parsing using UTF-8.  The UTF-16 interfaces are provided
 as a convenience.  The UTF-16 interfaces work by converting the
 input text into UTF-8, then invoking the corresponding UTF-8 interface.

 The first argument, "db", is a [database connection] obtained from a
 prior successful call to [sqlite3_open()], [sqlite3_open_v2()] or
 [sqlite3_open16()].  The database connection must not have been closed.

 The second argument, "zSql", is the statement to be compiled, encoded
 as either UTF-8 or UTF-16.  The sqlite3_prepare(), sqlite3_prepare_v2(),
 and sqlite3_prepare_v3()
 interfaces use UTF-8, and sqlite3_prepare16(), sqlite3_prepare16_v2(),
 and sqlite3_prepare16_v3() use UTF-16.

 ^If the nByte argument is negative, then zSql is read up to the
 first zero terminator. ^If nByte is positive, then it is the
 number of bytes read from zSql.  ^If nByte is zero, then no prepared
 statement is generated.
 If the caller knows that the supplied string is nul-terminated, then
 there is a small performance advantage to passing an nByte parameter that
 is the number of bytes in the input string <i>including</i>
 the nul-terminator.

 ^If pzTail is not NULL then *pzTail is made to point to the first byte
 past the end of the first SQL statement in zSql.  These routines only
 compile the first statement in zSql, so *pzTail is left pointing to
 what remains uncompiled.

 ^*ppStmt is left pointing to a compiled [prepared statement] that can be
 executed using [sqlite3_step()].  ^If there is an error, *ppStmt is set
 to NULL.  ^If the input text contains no SQL (if the input is an empty
 string or a comment) then *ppStmt is set to NULL.
 The calling procedure is responsible for deleting the compiled
 SQL statement using [sqlite3_finalize()] after it has finished with it.
 ppStmt may not be NULL.

 ^On success, the sqlite3_prepare() family of routines return [SQLITE_OK];
 otherwise an [error code] is returned.

 The sqlite3_prepare_v2(), sqlite3_prepare_v3(), sqlite3_prepare16_v2(),
 and sqlite3_prepare16_v3() interfaces are recommended for all new programs.
 The older interfaces (sqlite3_prepare() and sqlite3_prepare16())
 are retained for backwards compatibility, but their use is discouraged.
 ^In the "vX" interfaces, the prepared statement
 that is returned (the [sqlite3_stmt] object) contains a copy of the
 original SQL text. This causes the [sqlite3_step()] interface to
 behave differently in three ways:

 <ol>
 <li>
 ^If the database schema changes, instead of returning [SQLITE_SCHEMA] as it
 always used to do, [sqlite3_step()] will automatically recompile the SQL
 statement and try to run it again. As many as [SQLITE_MAX_SCHEMA_RETRY]
 retries will occur before sqlite3_step() gives up and returns an error.
 </li>

 <li>
 ^When an error occurs, [sqlite3_step()] will return one of the detailed
 [error codes] or [extended error codes].  ^The legacy behavior was that
 [sqlite3_step()] would only return a generic [SQLITE_ERROR] result code
 and the application would have to make a second call to [sqlite3_reset()]
 in order to find the underlying cause of the problem. With the "v2" prepare
 interfaces, the underlying reason for the error is returned immediately.
 </li>

 <li>
 ^If the specific value bound to [parameter | host parameter] in the
 WHERE clause might influence the choice of query plan for a statement,
 then the statement will be automatically recompiled, as if there had been
 a schema change, on the first  [sqlite3_step()] call following any change
 to the [sqlite3_bind_text | bindings] of that [parameter].
 ^The specific value of WHERE-clause [parameter] might influence the
 choice of query plan if the parameter is the left-hand side of a [LIKE]
 or [GLOB] operator or if the parameter is compared to an indexed column
 and the [SQLITE_ENABLE_STAT3] compile-time option is enabled.
 </li>
 </ol>

 <p>^sqlite3_prepare_v3() differs from sqlite3_prepare_v2() only in having
 the extra prepFlags parameter, which is a bit array consisting of zero or
 more of the [SQLITE_PREPARE_PERSISTENT|SQLITE_PREPARE_*] flags.  ^The
 sqlite3_prepare_v2() interface works exactly the same as
 sqlite3_prepare_v3() with a zero prepFlags parameter.
*/
@frozen public struct Statement: RawRepresentable {
    public let rawValue: OpaquePointer

    @inlinable public init(rawValue: OpaquePointer) {
        self.rawValue = rawValue
    }
}
