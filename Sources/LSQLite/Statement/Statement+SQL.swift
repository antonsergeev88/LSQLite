import MissedSwiftSQLite

extension Statement {
    /**
     CAPI3REF: Retrieving Statement SQL
     METHOD: sqlite3_stmt

     ^The sqlite3_sql(P) interface returns a pointer to a copy of the UTF-8
     SQL text used to create [prepared statement] P if P was
     created by [sqlite3_prepare_v2()], [sqlite3_prepare_v3()],
     [sqlite3_prepare16_v2()], or [sqlite3_prepare16_v3()].
     ^The sqlite3_expanded_sql(P) interface returns a pointer to a UTF-8
     string containing the SQL text of prepared statement P with
     [bound parameters] expanded.

     ^The sqlite3_expanded_sql() interface returns NULL if insufficient memory
     is available to hold the result, or if the result would exceed the
     the maximum string length determined by the [SQLITE_LIMIT_LENGTH].

     ^The [SQLITE_TRACE_SIZE_LIMIT] compile-time option limits the size of
     bound parameter expansions.  ^The [SQLITE_OMIT_TRACE] compile-time
     option causes sqlite3_expanded_sql() to always return NULL.

     ^The string returned by sqlite3_sql(P) is managed by SQLite and is
     automatically freed when the prepared statement is finalized.
     ^The string returned by sqlite3_expanded_sql(P), on the other hand,
     is obtained from [sqlite3_malloc()] and must be free by the application
     by passing it to [sqlite3_free()].
     */
    @inlinable public var sql: UnsafePointer<Int8>? {
        sqlite3_sql(rawValue)
    }

    /**
     CAPI3REF: Retrieving Statement SQL
     METHOD: sqlite3_stmt

     ^The sqlite3_sql(P) interface returns a pointer to a copy of the UTF-8
     SQL text used to create [prepared statement] P if P was
     created by [sqlite3_prepare_v2()], [sqlite3_prepare_v3()],
     [sqlite3_prepare16_v2()], or [sqlite3_prepare16_v3()].
     ^The sqlite3_expanded_sql(P) interface returns a pointer to a UTF-8
     string containing the SQL text of prepared statement P with
     [bound parameters] expanded.

     ^The sqlite3_expanded_sql() interface returns NULL if insufficient memory
     is available to hold the result, or if the result would exceed the
     the maximum string length determined by the [SQLITE_LIMIT_LENGTH].

     ^The [SQLITE_TRACE_SIZE_LIMIT] compile-time option limits the size of
     bound parameter expansions.  ^The [SQLITE_OMIT_TRACE] compile-time
     option causes sqlite3_expanded_sql() to always return NULL.

     ^The string returned by sqlite3_sql(P) is managed by SQLite and is
     automatically freed when the prepared statement is finalized.
     ^The string returned by sqlite3_expanded_sql(P), on the other hand,
     is obtained from [sqlite3_malloc()] and must be free by the application
     by passing it to [sqlite3_free()].
     */
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    @inlinable public var expandedSql: UnsafeMutablePointer<Int8>? {
        sqlite3_expanded_sql(rawValue)
    }
}
