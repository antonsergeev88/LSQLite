import MissedSwiftSQLite

extension Statement {
    /**
     CAPI3REF: Number Of Columns In A Result Set
     METHOD: sqlite3_stmt

     ^Return the number of columns in the result set returned by the
     [prepared statement]. ^If this routine returns 0, that means the
     [prepared statement] returns no data (for example an [UPDATE]).
     ^However, just because this routine returns a positive number does not
     mean that one or more rows of data will be returned.  ^A SELECT statement
     will always have a positive sqlite3_column_count() but depending on the
     WHERE clause constraints and the table content, it might return no rows.

     See also: [sqlite3_data_count()]
     */
    @inlinable public var columnCount: Int32 {
        sqlite3_column_count(rawValue)
    }

    /**
     CAPI3REF: Column Names In A Result Set
     METHOD: sqlite3_stmt

     ^These routines return the name assigned to a particular column
     in the result set of a [SELECT] statement.  ^The sqlite3_column_name()
     interface returns a pointer to a zero-terminated UTF-8 string
     and sqlite3_column_name16() returns a pointer to a zero-terminated
     UTF-16 string.  ^The first parameter is the [prepared statement]
     that implements the [SELECT] statement. ^The second parameter is the
     column number.  ^The leftmost column is number 0.

     ^The returned string pointer is valid until either the [prepared statement]
     is destroyed by [sqlite3_finalize()] or until the statement is automatically
     reprepared by the first call to [sqlite3_step()] for a particular run
     or until the next call to
     sqlite3_column_name() or sqlite3_column_name16() on the same column.

     ^If sqlite3_malloc() fails during the processing of either routine
     (for example during a conversion from UTF-8 to UTF-16) then a
     NULL pointer is returned.

     ^The name of a result column is the value of the "AS" clause for
     that column, if there is an AS clause.  If there is no AS clause
     then the name of the column is unspecified and may change from
     one release of SQLite to the next.
     */
    @inlinable public func columnName(at index: Int32) -> UnsafePointer<Int8>? {
        sqlite3_column_name(rawValue, index)
    }

    /**
     CAPI3REF: Source Of Data In A Query Result
     METHOD: sqlite3_stmt

     ^These routines provide a means to determine the database, table, and
     table column that is the origin of a particular result column in
     [SELECT] statement.
     ^The name of the database or table or column can be returned as
     either a UTF-8 or UTF-16 string.  ^The _database_ routines return
     the database name, the _table_ routines return the table name, and
     the origin_ routines return the column name.
     ^The returned string is valid until the [prepared statement] is destroyed
     using [sqlite3_finalize()] or until the statement is automatically
     reprepared by the first call to [sqlite3_step()] for a particular run
     or until the same information is requested
     again in a different encoding.

     ^The names returned are the original un-aliased names of the
     database, table, and column.

     ^The first argument to these interfaces is a [prepared statement].
     ^These functions return information about the Nth result column returned by
     the statement, where N is the second function argument.
     ^The left-most column is column 0 for these routines.

     ^If the Nth column returned by the statement is an expression or
     subquery and is not a column value, then all of these functions return
     NULL.  ^These routine might also return NULL if a memory allocation error
     occurs.  ^Otherwise, they return the name of the attached database, table,
     or column that query result column was extracted from.

     ^As with all other SQLite APIs, those whose names end with "16" return
     UTF-16 encoded strings and the other functions return UTF-8.

     ^These APIs are only available if the library was compiled with the
     [SQLITE_ENABLE_COLUMN_METADATA] C-preprocessor symbol.

     If two or more threads call one or more of these routines against the same
     prepared statement and column at the same time then the results are
     undefined.

     If two or more threads call one or more
     [sqlite3_column_database_name | column metadata interfaces]
     for the same [prepared statement] and result column
     at the same time then the results are undefined.
     */
    @inlinable public func columnDatabaseName(at index: Int32) -> UnsafePointer<Int8>? {
        sqlite3_column_database_name(rawValue, index)
    }

    /**
     CAPI3REF: Source Of Data In A Query Result
     METHOD: sqlite3_stmt

     ^These routines provide a means to determine the database, table, and
     table column that is the origin of a particular result column in
     [SELECT] statement.
     ^The name of the database or table or column can be returned as
     either a UTF-8 or UTF-16 string.  ^The _database_ routines return
     the database name, the _table_ routines return the table name, and
     the origin_ routines return the column name.
     ^The returned string is valid until the [prepared statement] is destroyed
     using [sqlite3_finalize()] or until the statement is automatically
     reprepared by the first call to [sqlite3_step()] for a particular run
     or until the same information is requested
     again in a different encoding.

     ^The names returned are the original un-aliased names of the
     database, table, and column.

     ^The first argument to these interfaces is a [prepared statement].
     ^These functions return information about the Nth result column returned by
     the statement, where N is the second function argument.
     ^The left-most column is column 0 for these routines.

     ^If the Nth column returned by the statement is an expression or
     subquery and is not a column value, then all of these functions return
     NULL.  ^These routine might also return NULL if a memory allocation error
     occurs.  ^Otherwise, they return the name of the attached database, table,
     or column that query result column was extracted from.

     ^As with all other SQLite APIs, those whose names end with "16" return
     UTF-16 encoded strings and the other functions return UTF-8.

     ^These APIs are only available if the library was compiled with the
     [SQLITE_ENABLE_COLUMN_METADATA] C-preprocessor symbol.

     If two or more threads call one or more of these routines against the same
     prepared statement and column at the same time then the results are
     undefined.

     If two or more threads call one or more
     [sqlite3_column_database_name | column metadata interfaces]
     for the same [prepared statement] and result column
     at the same time then the results are undefined.
     */
    @inlinable public func columnTableName(at index: Int32) -> UnsafePointer<Int8>? {
        sqlite3_column_table_name(rawValue, index)
    }

    /**
     CAPI3REF: Source Of Data In A Query Result
     METHOD: sqlite3_stmt

     ^These routines provide a means to determine the database, table, and
     table column that is the origin of a particular result column in
     [SELECT] statement.
     ^The name of the database or table or column can be returned as
     either a UTF-8 or UTF-16 string.  ^The _database_ routines return
     the database name, the _table_ routines return the table name, and
     the origin_ routines return the column name.
     ^The returned string is valid until the [prepared statement] is destroyed
     using [sqlite3_finalize()] or until the statement is automatically
     reprepared by the first call to [sqlite3_step()] for a particular run
     or until the same information is requested
     again in a different encoding.

     ^The names returned are the original un-aliased names of the
     database, table, and column.

     ^The first argument to these interfaces is a [prepared statement].
     ^These functions return information about the Nth result column returned by
     the statement, where N is the second function argument.
     ^The left-most column is column 0 for these routines.

     ^If the Nth column returned by the statement is an expression or
     subquery and is not a column value, then all of these functions return
     NULL.  ^These routine might also return NULL if a memory allocation error
     occurs.  ^Otherwise, they return the name of the attached database, table,
     or column that query result column was extracted from.

     ^As with all other SQLite APIs, those whose names end with "16" return
     UTF-16 encoded strings and the other functions return UTF-8.

     ^These APIs are only available if the library was compiled with the
     [SQLITE_ENABLE_COLUMN_METADATA] C-preprocessor symbol.

     If two or more threads call one or more of these routines against the same
     prepared statement and column at the same time then the results are
     undefined.

     If two or more threads call one or more
     [sqlite3_column_database_name | column metadata interfaces]
     for the same [prepared statement] and result column
     at the same time then the results are undefined.
     */
    @inlinable public func columnOriginName(at index: Int32) -> UnsafePointer<Int8>? {
        sqlite3_column_origin_name(rawValue, index)
    }

    /**
     CAPI3REF: Declared Datatype Of A Query Result
     METHOD: sqlite3_stmt

     ^(The first parameter is a [prepared statement].
     If this statement is a [SELECT] statement and the Nth column of the
     returned result set of that [SELECT] is a table column (not an
     expression or subquery) then the declared type of the table
     column is returned.)^  ^If the Nth column of the result set is an
     expression or subquery, then a NULL pointer is returned.
     ^The returned string is always UTF-8 encoded.

     ^(For example, given the database schema:

     CREATE TABLE t1(c1 VARIANT);

     and the following statement to be compiled:

     SELECT c1 + 1, c1 FROM t1;

     this routine would return the string "VARIANT" for the second result
     column (i==1), and a NULL pointer for the first result column (i==0).)^

     ^SQLite uses dynamic run-time typing.  ^So just because a column
     is declared to contain a particular type does not mean that the
     data stored in that column is of the declared type.  SQLite is
     strongly typed, but the typing is dynamic not static.  ^Type
     is associated with individual values, not with the containers
     used to hold those values.
     */
    @inlinable public func columnDeclaredType(at index: Int32) -> UnsafePointer<Int8>? {
        sqlite3_column_decltype(rawValue, index)
    }

    /**
     CAPI3REF: Number of columns in a result set
     METHOD: sqlite3_stmt

     ^The sqlite3_data_count(P) interface returns the number of columns in the
     current row of the result set of [prepared statement] P.
     ^If prepared statement P does not have results ready to return
     (via calls to the [sqlite3_column_int | sqlite3_column_*()] of
     interfaces) then sqlite3_data_count(P) returns 0.
     ^The sqlite3_data_count(P) routine also returns 0 if P is a NULL pointer.
     ^The sqlite3_data_count(P) routine returns 0 if the previous call to
     [sqlite3_step](P) returned [SQLITE_DONE].  ^The sqlite3_data_count(P)
     will return non-zero if previous call to [sqlite3_step](P) returned
     [SQLITE_ROW], except in the case of the [PRAGMA incremental_vacuum]
     where it always returns zero since each step of that multi-step
     pragma returns 0 columns of data.

     See also: [sqlite3_column_count()]
     */
    @inlinable public var dataCount: Int32 {
        sqlite3_data_count(rawValue)
    }

    /**
     CAPI3REF: Result Values From A Query
     KEYWORDS: {column access functions}
     METHOD: sqlite3_stmt

     <b>Summary:</b>
     <blockquote><table border=0 cellpadding=0 cellspacing=0>
     <tr><td><b>sqlite3_column_blob</b><td>&rarr;<td>BLOB result
     <tr><td><b>sqlite3_column_double</b><td>&rarr;<td>REAL result
     <tr><td><b>sqlite3_column_int</b><td>&rarr;<td>32-bit INTEGER result
     <tr><td><b>sqlite3_column_int64</b><td>&rarr;<td>64-bit INTEGER result
     <tr><td><b>sqlite3_column_text</b><td>&rarr;<td>UTF-8 TEXT result
     <tr><td><b>sqlite3_column_text16</b><td>&rarr;<td>UTF-16 TEXT result
     <tr><td><b>sqlite3_column_value</b><td>&rarr;<td>The result as an
     [sqlite3_value|unprotected sqlite3_value] object.
     <tr><td>&nbsp;<td>&nbsp;<td>&nbsp;
     <tr><td><b>sqlite3_column_bytes</b><td>&rarr;<td>Size of a BLOB
     or a UTF-8 TEXT result in bytes
     <tr><td><b>sqlite3_column_bytes16&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>Size of UTF-16
     TEXT in bytes
     <tr><td><b>sqlite3_column_type</b><td>&rarr;<td>Default
     datatype of the result
     </table></blockquote>

     <b>Details:</b>

     ^These routines return information about a single column of the current
     result row of a query.  ^In every case the first argument is a pointer
     to the [prepared statement] that is being evaluated (the [sqlite3_stmt*]
     that was returned from [sqlite3_prepare_v2()] or one of its variants)
     and the second argument is the index of the column for which information
     should be returned. ^The leftmost column of the result set has the index 0.
     ^The number of columns in the result can be determined using
     [sqlite3_column_count()].

     If the SQL statement does not currently point to a valid row, or if the
     column index is out of range, the result is undefined.
     These routines may only be called when the most recent call to
     [sqlite3_step()] has returned [SQLITE_ROW] and neither
     [sqlite3_reset()] nor [sqlite3_finalize()] have been called subsequently.
     If any of these routines are called after [sqlite3_reset()] or
     [sqlite3_finalize()] or after [sqlite3_step()] has returned
     something other than [SQLITE_ROW], the results are undefined.
     If [sqlite3_step()] or [sqlite3_reset()] or [sqlite3_finalize()]
     are called from a different thread while any of these routines
     are pending, then the results are undefined.

     The first six interfaces (_blob, _double, _int, _int64, _text, and _text16)
     each return the value of a result column in a specific data format.  If
     the result column is not initially in the requested format (for example,
     if the query returns an integer but the sqlite3_column_text() interface
     is used to extract the value) then an automatic type conversion is performed.

     ^The sqlite3_column_type() routine returns the
     [SQLITE_INTEGER | datatype code] for the initial data type
     of the result column.  ^The returned value is one of [SQLITE_INTEGER],
     [SQLITE_FLOAT], [SQLITE_TEXT], [SQLITE_BLOB], or [SQLITE_NULL].
     The return value of sqlite3_column_type() can be used to decide which
     of the first six interface should be used to extract the column value.
     The value returned by sqlite3_column_type() is only meaningful if no
     automatic type conversions have occurred for the value in question.
     After a type conversion, the result of calling sqlite3_column_type()
     is undefined, though harmless.  Future
     versions of SQLite may change the behavior of sqlite3_column_type()
     following a type conversion.

     If the result is a BLOB or a TEXT string, then the sqlite3_column_bytes()
     or sqlite3_column_bytes16() interfaces can be used to determine the size
     of that BLOB or string.

     ^If the result is a BLOB or UTF-8 string then the sqlite3_column_bytes()
     routine returns the number of bytes in that BLOB or string.
     ^If the result is a UTF-16 string, then sqlite3_column_bytes() converts
     the string to UTF-8 and then returns the number of bytes.
     ^If the result is a numeric value then sqlite3_column_bytes() uses
     [sqlite3_snprintf()] to convert that value to a UTF-8 string and returns
     the number of bytes in that string.
     ^If the result is NULL, then sqlite3_column_bytes() returns zero.

     ^If the result is a BLOB or UTF-16 string then the sqlite3_column_bytes16()
     routine returns the number of bytes in that BLOB or string.
     ^If the result is a UTF-8 string, then sqlite3_column_bytes16() converts
     the string to UTF-16 and then returns the number of bytes.
     ^If the result is a numeric value then sqlite3_column_bytes16() uses
     [sqlite3_snprintf()] to convert that value to a UTF-16 string and returns
     the number of bytes in that string.
     ^If the result is NULL, then sqlite3_column_bytes16() returns zero.

     ^The values returned by [sqlite3_column_bytes()] and
     [sqlite3_column_bytes16()] do not include the zero terminators at the end
     of the string.  ^For clarity: the values returned by
     [sqlite3_column_bytes()] and [sqlite3_column_bytes16()] are the number of
     bytes in the string, not the number of characters.

     ^Strings returned by sqlite3_column_text() and sqlite3_column_text16(),
     even empty strings, are always zero-terminated.  ^The return
     value from sqlite3_column_blob() for a zero-length BLOB is a NULL pointer.

     <b>Warning:</b> ^The object returned by [sqlite3_column_value()] is an
     [unprotected sqlite3_value] object.  In a multithreaded environment,
     an unprotected sqlite3_value object may only be used safely with
     [sqlite3_bind_value()] and [sqlite3_result_value()].
     If the [unprotected sqlite3_value] object returned by
     [sqlite3_column_value()] is used in any other way, including calls
     to routines like [sqlite3_value_int()], [sqlite3_value_text()],
     or [sqlite3_value_bytes()], the behavior is not threadsafe.
     Hence, the sqlite3_column_value() interface
     is normally only useful within the implementation of
     [application-defined SQL functions] or [virtual tables], not within
     top-level application code.

     The these routines may attempt to convert the datatype of the result.
     ^For example, if the internal representation is FLOAT and a text result
     is requested, [sqlite3_snprintf()] is used internally to perform the
     conversion automatically.  ^(The following table details the conversions
     that are applied:

     <blockquote>
     <table border="1">
     <tr><th> Internal<br>Type <th> Requested<br>Type <th>  Conversion

     <tr><td>  NULL    <td> INTEGER   <td> Result is 0
     <tr><td>  NULL    <td>  FLOAT    <td> Result is 0.0
     <tr><td>  NULL    <td>   TEXT    <td> Result is a NULL pointer
     <tr><td>  NULL    <td>   BLOB    <td> Result is a NULL pointer
     <tr><td> INTEGER  <td>  FLOAT    <td> Convert from integer to float
     <tr><td> INTEGER  <td>   TEXT    <td> ASCII rendering of the integer
     <tr><td> INTEGER  <td>   BLOB    <td> Same as INTEGER->TEXT
     <tr><td>  FLOAT   <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  FLOAT   <td>   TEXT    <td> ASCII rendering of the float
     <tr><td>  FLOAT   <td>   BLOB    <td> [CAST] to BLOB
     <tr><td>  TEXT    <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  TEXT    <td>  FLOAT    <td> [CAST] to REAL
     <tr><td>  TEXT    <td>   BLOB    <td> No change
     <tr><td>  BLOB    <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  BLOB    <td>  FLOAT    <td> [CAST] to REAL
     <tr><td>  BLOB    <td>   TEXT    <td> Add a zero terminator if needed
     </table>
     </blockquote>)^

     Note that when type conversions occur, pointers returned by prior
     calls to sqlite3_column_blob(), sqlite3_column_text(), and/or
     sqlite3_column_text16() may be invalidated.
     Type conversions and pointer invalidations might occur
     in the following cases:

     <ul>
     <li> The initial content is a BLOB and sqlite3_column_text() or
     sqlite3_column_text16() is called.  A zero-terminator might
     need to be added to the string.</li>
     <li> The initial content is UTF-8 text and sqlite3_column_bytes16() or
     sqlite3_column_text16() is called.  The content must be converted
     to UTF-16.</li>
     <li> The initial content is UTF-16 text and sqlite3_column_bytes() or
     sqlite3_column_text() is called.  The content must be converted
     to UTF-8.</li>
     </ul>

     ^Conversions between UTF-16be and UTF-16le are always done in place and do
     not invalidate a prior pointer, though of course the content of the buffer
     that the prior pointer references will have been modified.  Other kinds
     of conversion are done in place when it is possible, but sometimes they
     are not possible and in those cases prior pointers are invalidated.

     The safest policy is to invoke these routines
     in one of the following ways:

     <ul>
     <li>sqlite3_column_text() followed by sqlite3_column_bytes()</li>
     <li>sqlite3_column_blob() followed by sqlite3_column_bytes()</li>
     <li>sqlite3_column_text16() followed by sqlite3_column_bytes16()</li>
     </ul>

     In other words, you should call sqlite3_column_text(),
     sqlite3_column_blob(), or sqlite3_column_text16() first to force the result
     into the desired format, then invoke sqlite3_column_bytes() or
     sqlite3_column_bytes16() to find the size of the result.  Do not mix calls
     to sqlite3_column_text() or sqlite3_column_blob() with calls to
     sqlite3_column_bytes16(), and do not mix calls to sqlite3_column_text16()
     with calls to sqlite3_column_bytes().

     ^The pointers returned are valid until a type conversion occurs as
     described above, or until [sqlite3_step()] or [sqlite3_reset()] or
     [sqlite3_finalize()] is called.  ^The memory space used to hold strings
     and BLOBs is freed automatically.  Do not pass the pointers returned
     from [sqlite3_column_blob()], [sqlite3_column_text()], etc. into
     [sqlite3_free()].

     As long as the input parameters are correct, these routines will only
     fail if an out-of-memory error occurs during a format conversion.
     Only the following subset of interfaces are subject to out-of-memory
     errors:

     <ul>
     <li> sqlite3_column_blob()
     <li> sqlite3_column_text()
     <li> sqlite3_column_text16()
     <li> sqlite3_column_bytes()
     <li> sqlite3_column_bytes16()
     </ul>

     If an out-of-memory error occurs, then the return value from these
     routines is the same as if the column had contained an SQL NULL value.
     Valid SQL NULL returns can be distinguished from out-of-memory errors
     by invoking the [sqlite3_errcode()] immediately after the suspect
     return value is obtained and before any
     other SQLite interface is called on the same [database connection].
     */
    @inlinable public func columnBlob(at index: Int32) -> UnsafeRawPointer? {
        sqlite3_column_blob(rawValue, index)
    }

    /**
     CAPI3REF: Result Values From A Query
     KEYWORDS: {column access functions}
     METHOD: sqlite3_stmt

     <b>Summary:</b>
     <blockquote><table border=0 cellpadding=0 cellspacing=0>
     <tr><td><b>sqlite3_column_blob</b><td>&rarr;<td>BLOB result
     <tr><td><b>sqlite3_column_double</b><td>&rarr;<td>REAL result
     <tr><td><b>sqlite3_column_int</b><td>&rarr;<td>32-bit INTEGER result
     <tr><td><b>sqlite3_column_int64</b><td>&rarr;<td>64-bit INTEGER result
     <tr><td><b>sqlite3_column_text</b><td>&rarr;<td>UTF-8 TEXT result
     <tr><td><b>sqlite3_column_text16</b><td>&rarr;<td>UTF-16 TEXT result
     <tr><td><b>sqlite3_column_value</b><td>&rarr;<td>The result as an
     [sqlite3_value|unprotected sqlite3_value] object.
     <tr><td>&nbsp;<td>&nbsp;<td>&nbsp;
     <tr><td><b>sqlite3_column_bytes</b><td>&rarr;<td>Size of a BLOB
     or a UTF-8 TEXT result in bytes
     <tr><td><b>sqlite3_column_bytes16&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>Size of UTF-16
     TEXT in bytes
     <tr><td><b>sqlite3_column_type</b><td>&rarr;<td>Default
     datatype of the result
     </table></blockquote>

     <b>Details:</b>

     ^These routines return information about a single column of the current
     result row of a query.  ^In every case the first argument is a pointer
     to the [prepared statement] that is being evaluated (the [sqlite3_stmt*]
     that was returned from [sqlite3_prepare_v2()] or one of its variants)
     and the second argument is the index of the column for which information
     should be returned. ^The leftmost column of the result set has the index 0.
     ^The number of columns in the result can be determined using
     [sqlite3_column_count()].

     If the SQL statement does not currently point to a valid row, or if the
     column index is out of range, the result is undefined.
     These routines may only be called when the most recent call to
     [sqlite3_step()] has returned [SQLITE_ROW] and neither
     [sqlite3_reset()] nor [sqlite3_finalize()] have been called subsequently.
     If any of these routines are called after [sqlite3_reset()] or
     [sqlite3_finalize()] or after [sqlite3_step()] has returned
     something other than [SQLITE_ROW], the results are undefined.
     If [sqlite3_step()] or [sqlite3_reset()] or [sqlite3_finalize()]
     are called from a different thread while any of these routines
     are pending, then the results are undefined.

     The first six interfaces (_blob, _double, _int, _int64, _text, and _text16)
     each return the value of a result column in a specific data format.  If
     the result column is not initially in the requested format (for example,
     if the query returns an integer but the sqlite3_column_text() interface
     is used to extract the value) then an automatic type conversion is performed.

     ^The sqlite3_column_type() routine returns the
     [SQLITE_INTEGER | datatype code] for the initial data type
     of the result column.  ^The returned value is one of [SQLITE_INTEGER],
     [SQLITE_FLOAT], [SQLITE_TEXT], [SQLITE_BLOB], or [SQLITE_NULL].
     The return value of sqlite3_column_type() can be used to decide which
     of the first six interface should be used to extract the column value.
     The value returned by sqlite3_column_type() is only meaningful if no
     automatic type conversions have occurred for the value in question.
     After a type conversion, the result of calling sqlite3_column_type()
     is undefined, though harmless.  Future
     versions of SQLite may change the behavior of sqlite3_column_type()
     following a type conversion.

     If the result is a BLOB or a TEXT string, then the sqlite3_column_bytes()
     or sqlite3_column_bytes16() interfaces can be used to determine the size
     of that BLOB or string.

     ^If the result is a BLOB or UTF-8 string then the sqlite3_column_bytes()
     routine returns the number of bytes in that BLOB or string.
     ^If the result is a UTF-16 string, then sqlite3_column_bytes() converts
     the string to UTF-8 and then returns the number of bytes.
     ^If the result is a numeric value then sqlite3_column_bytes() uses
     [sqlite3_snprintf()] to convert that value to a UTF-8 string and returns
     the number of bytes in that string.
     ^If the result is NULL, then sqlite3_column_bytes() returns zero.

     ^If the result is a BLOB or UTF-16 string then the sqlite3_column_bytes16()
     routine returns the number of bytes in that BLOB or string.
     ^If the result is a UTF-8 string, then sqlite3_column_bytes16() converts
     the string to UTF-16 and then returns the number of bytes.
     ^If the result is a numeric value then sqlite3_column_bytes16() uses
     [sqlite3_snprintf()] to convert that value to a UTF-16 string and returns
     the number of bytes in that string.
     ^If the result is NULL, then sqlite3_column_bytes16() returns zero.

     ^The values returned by [sqlite3_column_bytes()] and
     [sqlite3_column_bytes16()] do not include the zero terminators at the end
     of the string.  ^For clarity: the values returned by
     [sqlite3_column_bytes()] and [sqlite3_column_bytes16()] are the number of
     bytes in the string, not the number of characters.

     ^Strings returned by sqlite3_column_text() and sqlite3_column_text16(),
     even empty strings, are always zero-terminated.  ^The return
     value from sqlite3_column_blob() for a zero-length BLOB is a NULL pointer.

     <b>Warning:</b> ^The object returned by [sqlite3_column_value()] is an
     [unprotected sqlite3_value] object.  In a multithreaded environment,
     an unprotected sqlite3_value object may only be used safely with
     [sqlite3_bind_value()] and [sqlite3_result_value()].
     If the [unprotected sqlite3_value] object returned by
     [sqlite3_column_value()] is used in any other way, including calls
     to routines like [sqlite3_value_int()], [sqlite3_value_text()],
     or [sqlite3_value_bytes()], the behavior is not threadsafe.
     Hence, the sqlite3_column_value() interface
     is normally only useful within the implementation of
     [application-defined SQL functions] or [virtual tables], not within
     top-level application code.

     The these routines may attempt to convert the datatype of the result.
     ^For example, if the internal representation is FLOAT and a text result
     is requested, [sqlite3_snprintf()] is used internally to perform the
     conversion automatically.  ^(The following table details the conversions
     that are applied:

     <blockquote>
     <table border="1">
     <tr><th> Internal<br>Type <th> Requested<br>Type <th>  Conversion

     <tr><td>  NULL    <td> INTEGER   <td> Result is 0
     <tr><td>  NULL    <td>  FLOAT    <td> Result is 0.0
     <tr><td>  NULL    <td>   TEXT    <td> Result is a NULL pointer
     <tr><td>  NULL    <td>   BLOB    <td> Result is a NULL pointer
     <tr><td> INTEGER  <td>  FLOAT    <td> Convert from integer to float
     <tr><td> INTEGER  <td>   TEXT    <td> ASCII rendering of the integer
     <tr><td> INTEGER  <td>   BLOB    <td> Same as INTEGER->TEXT
     <tr><td>  FLOAT   <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  FLOAT   <td>   TEXT    <td> ASCII rendering of the float
     <tr><td>  FLOAT   <td>   BLOB    <td> [CAST] to BLOB
     <tr><td>  TEXT    <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  TEXT    <td>  FLOAT    <td> [CAST] to REAL
     <tr><td>  TEXT    <td>   BLOB    <td> No change
     <tr><td>  BLOB    <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  BLOB    <td>  FLOAT    <td> [CAST] to REAL
     <tr><td>  BLOB    <td>   TEXT    <td> Add a zero terminator if needed
     </table>
     </blockquote>)^

     Note that when type conversions occur, pointers returned by prior
     calls to sqlite3_column_blob(), sqlite3_column_text(), and/or
     sqlite3_column_text16() may be invalidated.
     Type conversions and pointer invalidations might occur
     in the following cases:

     <ul>
     <li> The initial content is a BLOB and sqlite3_column_text() or
     sqlite3_column_text16() is called.  A zero-terminator might
     need to be added to the string.</li>
     <li> The initial content is UTF-8 text and sqlite3_column_bytes16() or
     sqlite3_column_text16() is called.  The content must be converted
     to UTF-16.</li>
     <li> The initial content is UTF-16 text and sqlite3_column_bytes() or
     sqlite3_column_text() is called.  The content must be converted
     to UTF-8.</li>
     </ul>

     ^Conversions between UTF-16be and UTF-16le are always done in place and do
     not invalidate a prior pointer, though of course the content of the buffer
     that the prior pointer references will have been modified.  Other kinds
     of conversion are done in place when it is possible, but sometimes they
     are not possible and in those cases prior pointers are invalidated.

     The safest policy is to invoke these routines
     in one of the following ways:

     <ul>
     <li>sqlite3_column_text() followed by sqlite3_column_bytes()</li>
     <li>sqlite3_column_blob() followed by sqlite3_column_bytes()</li>
     <li>sqlite3_column_text16() followed by sqlite3_column_bytes16()</li>
     </ul>

     In other words, you should call sqlite3_column_text(),
     sqlite3_column_blob(), or sqlite3_column_text16() first to force the result
     into the desired format, then invoke sqlite3_column_bytes() or
     sqlite3_column_bytes16() to find the size of the result.  Do not mix calls
     to sqlite3_column_text() or sqlite3_column_blob() with calls to
     sqlite3_column_bytes16(), and do not mix calls to sqlite3_column_text16()
     with calls to sqlite3_column_bytes().

     ^The pointers returned are valid until a type conversion occurs as
     described above, or until [sqlite3_step()] or [sqlite3_reset()] or
     [sqlite3_finalize()] is called.  ^The memory space used to hold strings
     and BLOBs is freed automatically.  Do not pass the pointers returned
     from [sqlite3_column_blob()], [sqlite3_column_text()], etc. into
     [sqlite3_free()].

     As long as the input parameters are correct, these routines will only
     fail if an out-of-memory error occurs during a format conversion.
     Only the following subset of interfaces are subject to out-of-memory
     errors:

     <ul>
     <li> sqlite3_column_blob()
     <li> sqlite3_column_text()
     <li> sqlite3_column_text16()
     <li> sqlite3_column_bytes()
     <li> sqlite3_column_bytes16()
     </ul>

     If an out-of-memory error occurs, then the return value from these
     routines is the same as if the column had contained an SQL NULL value.
     Valid SQL NULL returns can be distinguished from out-of-memory errors
     by invoking the [sqlite3_errcode()] immediately after the suspect
     return value is obtained and before any
     other SQLite interface is called on the same [database connection].
     */
    @inlinable public func columnDouble(at index: Int32) -> Double {
        sqlite3_column_double(rawValue, index)
    }

    /**
     CAPI3REF: Result Values From A Query
     KEYWORDS: {column access functions}
     METHOD: sqlite3_stmt

     <b>Summary:</b>
     <blockquote><table border=0 cellpadding=0 cellspacing=0>
     <tr><td><b>sqlite3_column_blob</b><td>&rarr;<td>BLOB result
     <tr><td><b>sqlite3_column_double</b><td>&rarr;<td>REAL result
     <tr><td><b>sqlite3_column_int</b><td>&rarr;<td>32-bit INTEGER result
     <tr><td><b>sqlite3_column_int64</b><td>&rarr;<td>64-bit INTEGER result
     <tr><td><b>sqlite3_column_text</b><td>&rarr;<td>UTF-8 TEXT result
     <tr><td><b>sqlite3_column_text16</b><td>&rarr;<td>UTF-16 TEXT result
     <tr><td><b>sqlite3_column_value</b><td>&rarr;<td>The result as an
     [sqlite3_value|unprotected sqlite3_value] object.
     <tr><td>&nbsp;<td>&nbsp;<td>&nbsp;
     <tr><td><b>sqlite3_column_bytes</b><td>&rarr;<td>Size of a BLOB
     or a UTF-8 TEXT result in bytes
     <tr><td><b>sqlite3_column_bytes16&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>Size of UTF-16
     TEXT in bytes
     <tr><td><b>sqlite3_column_type</b><td>&rarr;<td>Default
     datatype of the result
     </table></blockquote>

     <b>Details:</b>

     ^These routines return information about a single column of the current
     result row of a query.  ^In every case the first argument is a pointer
     to the [prepared statement] that is being evaluated (the [sqlite3_stmt*]
     that was returned from [sqlite3_prepare_v2()] or one of its variants)
     and the second argument is the index of the column for which information
     should be returned. ^The leftmost column of the result set has the index 0.
     ^The number of columns in the result can be determined using
     [sqlite3_column_count()].

     If the SQL statement does not currently point to a valid row, or if the
     column index is out of range, the result is undefined.
     These routines may only be called when the most recent call to
     [sqlite3_step()] has returned [SQLITE_ROW] and neither
     [sqlite3_reset()] nor [sqlite3_finalize()] have been called subsequently.
     If any of these routines are called after [sqlite3_reset()] or
     [sqlite3_finalize()] or after [sqlite3_step()] has returned
     something other than [SQLITE_ROW], the results are undefined.
     If [sqlite3_step()] or [sqlite3_reset()] or [sqlite3_finalize()]
     are called from a different thread while any of these routines
     are pending, then the results are undefined.

     The first six interfaces (_blob, _double, _int, _int64, _text, and _text16)
     each return the value of a result column in a specific data format.  If
     the result column is not initially in the requested format (for example,
     if the query returns an integer but the sqlite3_column_text() interface
     is used to extract the value) then an automatic type conversion is performed.

     ^The sqlite3_column_type() routine returns the
     [SQLITE_INTEGER | datatype code] for the initial data type
     of the result column.  ^The returned value is one of [SQLITE_INTEGER],
     [SQLITE_FLOAT], [SQLITE_TEXT], [SQLITE_BLOB], or [SQLITE_NULL].
     The return value of sqlite3_column_type() can be used to decide which
     of the first six interface should be used to extract the column value.
     The value returned by sqlite3_column_type() is only meaningful if no
     automatic type conversions have occurred for the value in question.
     After a type conversion, the result of calling sqlite3_column_type()
     is undefined, though harmless.  Future
     versions of SQLite may change the behavior of sqlite3_column_type()
     following a type conversion.

     If the result is a BLOB or a TEXT string, then the sqlite3_column_bytes()
     or sqlite3_column_bytes16() interfaces can be used to determine the size
     of that BLOB or string.

     ^If the result is a BLOB or UTF-8 string then the sqlite3_column_bytes()
     routine returns the number of bytes in that BLOB or string.
     ^If the result is a UTF-16 string, then sqlite3_column_bytes() converts
     the string to UTF-8 and then returns the number of bytes.
     ^If the result is a numeric value then sqlite3_column_bytes() uses
     [sqlite3_snprintf()] to convert that value to a UTF-8 string and returns
     the number of bytes in that string.
     ^If the result is NULL, then sqlite3_column_bytes() returns zero.

     ^If the result is a BLOB or UTF-16 string then the sqlite3_column_bytes16()
     routine returns the number of bytes in that BLOB or string.
     ^If the result is a UTF-8 string, then sqlite3_column_bytes16() converts
     the string to UTF-16 and then returns the number of bytes.
     ^If the result is a numeric value then sqlite3_column_bytes16() uses
     [sqlite3_snprintf()] to convert that value to a UTF-16 string and returns
     the number of bytes in that string.
     ^If the result is NULL, then sqlite3_column_bytes16() returns zero.

     ^The values returned by [sqlite3_column_bytes()] and
     [sqlite3_column_bytes16()] do not include the zero terminators at the end
     of the string.  ^For clarity: the values returned by
     [sqlite3_column_bytes()] and [sqlite3_column_bytes16()] are the number of
     bytes in the string, not the number of characters.

     ^Strings returned by sqlite3_column_text() and sqlite3_column_text16(),
     even empty strings, are always zero-terminated.  ^The return
     value from sqlite3_column_blob() for a zero-length BLOB is a NULL pointer.

     <b>Warning:</b> ^The object returned by [sqlite3_column_value()] is an
     [unprotected sqlite3_value] object.  In a multithreaded environment,
     an unprotected sqlite3_value object may only be used safely with
     [sqlite3_bind_value()] and [sqlite3_result_value()].
     If the [unprotected sqlite3_value] object returned by
     [sqlite3_column_value()] is used in any other way, including calls
     to routines like [sqlite3_value_int()], [sqlite3_value_text()],
     or [sqlite3_value_bytes()], the behavior is not threadsafe.
     Hence, the sqlite3_column_value() interface
     is normally only useful within the implementation of
     [application-defined SQL functions] or [virtual tables], not within
     top-level application code.

     The these routines may attempt to convert the datatype of the result.
     ^For example, if the internal representation is FLOAT and a text result
     is requested, [sqlite3_snprintf()] is used internally to perform the
     conversion automatically.  ^(The following table details the conversions
     that are applied:

     <blockquote>
     <table border="1">
     <tr><th> Internal<br>Type <th> Requested<br>Type <th>  Conversion

     <tr><td>  NULL    <td> INTEGER   <td> Result is 0
     <tr><td>  NULL    <td>  FLOAT    <td> Result is 0.0
     <tr><td>  NULL    <td>   TEXT    <td> Result is a NULL pointer
     <tr><td>  NULL    <td>   BLOB    <td> Result is a NULL pointer
     <tr><td> INTEGER  <td>  FLOAT    <td> Convert from integer to float
     <tr><td> INTEGER  <td>   TEXT    <td> ASCII rendering of the integer
     <tr><td> INTEGER  <td>   BLOB    <td> Same as INTEGER->TEXT
     <tr><td>  FLOAT   <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  FLOAT   <td>   TEXT    <td> ASCII rendering of the float
     <tr><td>  FLOAT   <td>   BLOB    <td> [CAST] to BLOB
     <tr><td>  TEXT    <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  TEXT    <td>  FLOAT    <td> [CAST] to REAL
     <tr><td>  TEXT    <td>   BLOB    <td> No change
     <tr><td>  BLOB    <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  BLOB    <td>  FLOAT    <td> [CAST] to REAL
     <tr><td>  BLOB    <td>   TEXT    <td> Add a zero terminator if needed
     </table>
     </blockquote>)^

     Note that when type conversions occur, pointers returned by prior
     calls to sqlite3_column_blob(), sqlite3_column_text(), and/or
     sqlite3_column_text16() may be invalidated.
     Type conversions and pointer invalidations might occur
     in the following cases:

     <ul>
     <li> The initial content is a BLOB and sqlite3_column_text() or
     sqlite3_column_text16() is called.  A zero-terminator might
     need to be added to the string.</li>
     <li> The initial content is UTF-8 text and sqlite3_column_bytes16() or
     sqlite3_column_text16() is called.  The content must be converted
     to UTF-16.</li>
     <li> The initial content is UTF-16 text and sqlite3_column_bytes() or
     sqlite3_column_text() is called.  The content must be converted
     to UTF-8.</li>
     </ul>

     ^Conversions between UTF-16be and UTF-16le are always done in place and do
     not invalidate a prior pointer, though of course the content of the buffer
     that the prior pointer references will have been modified.  Other kinds
     of conversion are done in place when it is possible, but sometimes they
     are not possible and in those cases prior pointers are invalidated.

     The safest policy is to invoke these routines
     in one of the following ways:

     <ul>
     <li>sqlite3_column_text() followed by sqlite3_column_bytes()</li>
     <li>sqlite3_column_blob() followed by sqlite3_column_bytes()</li>
     <li>sqlite3_column_text16() followed by sqlite3_column_bytes16()</li>
     </ul>

     In other words, you should call sqlite3_column_text(),
     sqlite3_column_blob(), or sqlite3_column_text16() first to force the result
     into the desired format, then invoke sqlite3_column_bytes() or
     sqlite3_column_bytes16() to find the size of the result.  Do not mix calls
     to sqlite3_column_text() or sqlite3_column_blob() with calls to
     sqlite3_column_bytes16(), and do not mix calls to sqlite3_column_text16()
     with calls to sqlite3_column_bytes().

     ^The pointers returned are valid until a type conversion occurs as
     described above, or until [sqlite3_step()] or [sqlite3_reset()] or
     [sqlite3_finalize()] is called.  ^The memory space used to hold strings
     and BLOBs is freed automatically.  Do not pass the pointers returned
     from [sqlite3_column_blob()], [sqlite3_column_text()], etc. into
     [sqlite3_free()].

     As long as the input parameters are correct, these routines will only
     fail if an out-of-memory error occurs during a format conversion.
     Only the following subset of interfaces are subject to out-of-memory
     errors:

     <ul>
     <li> sqlite3_column_blob()
     <li> sqlite3_column_text()
     <li> sqlite3_column_text16()
     <li> sqlite3_column_bytes()
     <li> sqlite3_column_bytes16()
     </ul>

     If an out-of-memory error occurs, then the return value from these
     routines is the same as if the column had contained an SQL NULL value.
     Valid SQL NULL returns can be distinguished from out-of-memory errors
     by invoking the [sqlite3_errcode()] immediately after the suspect
     return value is obtained and before any
     other SQLite interface is called on the same [database connection].
     */
    @inlinable public func columnInt(at index: Int32) -> Int32 {
        sqlite3_column_int(rawValue, index)
    }

    /**
     CAPI3REF: Result Values From A Query
     KEYWORDS: {column access functions}
     METHOD: sqlite3_stmt

     <b>Summary:</b>
     <blockquote><table border=0 cellpadding=0 cellspacing=0>
     <tr><td><b>sqlite3_column_blob</b><td>&rarr;<td>BLOB result
     <tr><td><b>sqlite3_column_double</b><td>&rarr;<td>REAL result
     <tr><td><b>sqlite3_column_int</b><td>&rarr;<td>32-bit INTEGER result
     <tr><td><b>sqlite3_column_int64</b><td>&rarr;<td>64-bit INTEGER result
     <tr><td><b>sqlite3_column_text</b><td>&rarr;<td>UTF-8 TEXT result
     <tr><td><b>sqlite3_column_text16</b><td>&rarr;<td>UTF-16 TEXT result
     <tr><td><b>sqlite3_column_value</b><td>&rarr;<td>The result as an
     [sqlite3_value|unprotected sqlite3_value] object.
     <tr><td>&nbsp;<td>&nbsp;<td>&nbsp;
     <tr><td><b>sqlite3_column_bytes</b><td>&rarr;<td>Size of a BLOB
     or a UTF-8 TEXT result in bytes
     <tr><td><b>sqlite3_column_bytes16&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>Size of UTF-16
     TEXT in bytes
     <tr><td><b>sqlite3_column_type</b><td>&rarr;<td>Default
     datatype of the result
     </table></blockquote>

     <b>Details:</b>

     ^These routines return information about a single column of the current
     result row of a query.  ^In every case the first argument is a pointer
     to the [prepared statement] that is being evaluated (the [sqlite3_stmt*]
     that was returned from [sqlite3_prepare_v2()] or one of its variants)
     and the second argument is the index of the column for which information
     should be returned. ^The leftmost column of the result set has the index 0.
     ^The number of columns in the result can be determined using
     [sqlite3_column_count()].

     If the SQL statement does not currently point to a valid row, or if the
     column index is out of range, the result is undefined.
     These routines may only be called when the most recent call to
     [sqlite3_step()] has returned [SQLITE_ROW] and neither
     [sqlite3_reset()] nor [sqlite3_finalize()] have been called subsequently.
     If any of these routines are called after [sqlite3_reset()] or
     [sqlite3_finalize()] or after [sqlite3_step()] has returned
     something other than [SQLITE_ROW], the results are undefined.
     If [sqlite3_step()] or [sqlite3_reset()] or [sqlite3_finalize()]
     are called from a different thread while any of these routines
     are pending, then the results are undefined.

     The first six interfaces (_blob, _double, _int, _int64, _text, and _text16)
     each return the value of a result column in a specific data format.  If
     the result column is not initially in the requested format (for example,
     if the query returns an integer but the sqlite3_column_text() interface
     is used to extract the value) then an automatic type conversion is performed.

     ^The sqlite3_column_type() routine returns the
     [SQLITE_INTEGER | datatype code] for the initial data type
     of the result column.  ^The returned value is one of [SQLITE_INTEGER],
     [SQLITE_FLOAT], [SQLITE_TEXT], [SQLITE_BLOB], or [SQLITE_NULL].
     The return value of sqlite3_column_type() can be used to decide which
     of the first six interface should be used to extract the column value.
     The value returned by sqlite3_column_type() is only meaningful if no
     automatic type conversions have occurred for the value in question.
     After a type conversion, the result of calling sqlite3_column_type()
     is undefined, though harmless.  Future
     versions of SQLite may change the behavior of sqlite3_column_type()
     following a type conversion.

     If the result is a BLOB or a TEXT string, then the sqlite3_column_bytes()
     or sqlite3_column_bytes16() interfaces can be used to determine the size
     of that BLOB or string.

     ^If the result is a BLOB or UTF-8 string then the sqlite3_column_bytes()
     routine returns the number of bytes in that BLOB or string.
     ^If the result is a UTF-16 string, then sqlite3_column_bytes() converts
     the string to UTF-8 and then returns the number of bytes.
     ^If the result is a numeric value then sqlite3_column_bytes() uses
     [sqlite3_snprintf()] to convert that value to a UTF-8 string and returns
     the number of bytes in that string.
     ^If the result is NULL, then sqlite3_column_bytes() returns zero.

     ^If the result is a BLOB or UTF-16 string then the sqlite3_column_bytes16()
     routine returns the number of bytes in that BLOB or string.
     ^If the result is a UTF-8 string, then sqlite3_column_bytes16() converts
     the string to UTF-16 and then returns the number of bytes.
     ^If the result is a numeric value then sqlite3_column_bytes16() uses
     [sqlite3_snprintf()] to convert that value to a UTF-16 string and returns
     the number of bytes in that string.
     ^If the result is NULL, then sqlite3_column_bytes16() returns zero.

     ^The values returned by [sqlite3_column_bytes()] and
     [sqlite3_column_bytes16()] do not include the zero terminators at the end
     of the string.  ^For clarity: the values returned by
     [sqlite3_column_bytes()] and [sqlite3_column_bytes16()] are the number of
     bytes in the string, not the number of characters.

     ^Strings returned by sqlite3_column_text() and sqlite3_column_text16(),
     even empty strings, are always zero-terminated.  ^The return
     value from sqlite3_column_blob() for a zero-length BLOB is a NULL pointer.

     <b>Warning:</b> ^The object returned by [sqlite3_column_value()] is an
     [unprotected sqlite3_value] object.  In a multithreaded environment,
     an unprotected sqlite3_value object may only be used safely with
     [sqlite3_bind_value()] and [sqlite3_result_value()].
     If the [unprotected sqlite3_value] object returned by
     [sqlite3_column_value()] is used in any other way, including calls
     to routines like [sqlite3_value_int()], [sqlite3_value_text()],
     or [sqlite3_value_bytes()], the behavior is not threadsafe.
     Hence, the sqlite3_column_value() interface
     is normally only useful within the implementation of
     [application-defined SQL functions] or [virtual tables], not within
     top-level application code.

     The these routines may attempt to convert the datatype of the result.
     ^For example, if the internal representation is FLOAT and a text result
     is requested, [sqlite3_snprintf()] is used internally to perform the
     conversion automatically.  ^(The following table details the conversions
     that are applied:

     <blockquote>
     <table border="1">
     <tr><th> Internal<br>Type <th> Requested<br>Type <th>  Conversion

     <tr><td>  NULL    <td> INTEGER   <td> Result is 0
     <tr><td>  NULL    <td>  FLOAT    <td> Result is 0.0
     <tr><td>  NULL    <td>   TEXT    <td> Result is a NULL pointer
     <tr><td>  NULL    <td>   BLOB    <td> Result is a NULL pointer
     <tr><td> INTEGER  <td>  FLOAT    <td> Convert from integer to float
     <tr><td> INTEGER  <td>   TEXT    <td> ASCII rendering of the integer
     <tr><td> INTEGER  <td>   BLOB    <td> Same as INTEGER->TEXT
     <tr><td>  FLOAT   <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  FLOAT   <td>   TEXT    <td> ASCII rendering of the float
     <tr><td>  FLOAT   <td>   BLOB    <td> [CAST] to BLOB
     <tr><td>  TEXT    <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  TEXT    <td>  FLOAT    <td> [CAST] to REAL
     <tr><td>  TEXT    <td>   BLOB    <td> No change
     <tr><td>  BLOB    <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  BLOB    <td>  FLOAT    <td> [CAST] to REAL
     <tr><td>  BLOB    <td>   TEXT    <td> Add a zero terminator if needed
     </table>
     </blockquote>)^

     Note that when type conversions occur, pointers returned by prior
     calls to sqlite3_column_blob(), sqlite3_column_text(), and/or
     sqlite3_column_text16() may be invalidated.
     Type conversions and pointer invalidations might occur
     in the following cases:

     <ul>
     <li> The initial content is a BLOB and sqlite3_column_text() or
     sqlite3_column_text16() is called.  A zero-terminator might
     need to be added to the string.</li>
     <li> The initial content is UTF-8 text and sqlite3_column_bytes16() or
     sqlite3_column_text16() is called.  The content must be converted
     to UTF-16.</li>
     <li> The initial content is UTF-16 text and sqlite3_column_bytes() or
     sqlite3_column_text() is called.  The content must be converted
     to UTF-8.</li>
     </ul>

     ^Conversions between UTF-16be and UTF-16le are always done in place and do
     not invalidate a prior pointer, though of course the content of the buffer
     that the prior pointer references will have been modified.  Other kinds
     of conversion are done in place when it is possible, but sometimes they
     are not possible and in those cases prior pointers are invalidated.

     The safest policy is to invoke these routines
     in one of the following ways:

     <ul>
     <li>sqlite3_column_text() followed by sqlite3_column_bytes()</li>
     <li>sqlite3_column_blob() followed by sqlite3_column_bytes()</li>
     <li>sqlite3_column_text16() followed by sqlite3_column_bytes16()</li>
     </ul>

     In other words, you should call sqlite3_column_text(),
     sqlite3_column_blob(), or sqlite3_column_text16() first to force the result
     into the desired format, then invoke sqlite3_column_bytes() or
     sqlite3_column_bytes16() to find the size of the result.  Do not mix calls
     to sqlite3_column_text() or sqlite3_column_blob() with calls to
     sqlite3_column_bytes16(), and do not mix calls to sqlite3_column_text16()
     with calls to sqlite3_column_bytes().

     ^The pointers returned are valid until a type conversion occurs as
     described above, or until [sqlite3_step()] or [sqlite3_reset()] or
     [sqlite3_finalize()] is called.  ^The memory space used to hold strings
     and BLOBs is freed automatically.  Do not pass the pointers returned
     from [sqlite3_column_blob()], [sqlite3_column_text()], etc. into
     [sqlite3_free()].

     As long as the input parameters are correct, these routines will only
     fail if an out-of-memory error occurs during a format conversion.
     Only the following subset of interfaces are subject to out-of-memory
     errors:

     <ul>
     <li> sqlite3_column_blob()
     <li> sqlite3_column_text()
     <li> sqlite3_column_text16()
     <li> sqlite3_column_bytes()
     <li> sqlite3_column_bytes16()
     </ul>

     If an out-of-memory error occurs, then the return value from these
     routines is the same as if the column had contained an SQL NULL value.
     Valid SQL NULL returns can be distinguished from out-of-memory errors
     by invoking the [sqlite3_errcode()] immediately after the suspect
     return value is obtained and before any
     other SQLite interface is called on the same [database connection].
     */
    @inlinable public func columnInt64(at index: Int32) -> sqlite3_int64 {
        sqlite3_column_int64(rawValue, index)
    }

    /**
     CAPI3REF: Result Values From A Query
     KEYWORDS: {column access functions}
     METHOD: sqlite3_stmt

     <b>Summary:</b>
     <blockquote><table border=0 cellpadding=0 cellspacing=0>
     <tr><td><b>sqlite3_column_blob</b><td>&rarr;<td>BLOB result
     <tr><td><b>sqlite3_column_double</b><td>&rarr;<td>REAL result
     <tr><td><b>sqlite3_column_int</b><td>&rarr;<td>32-bit INTEGER result
     <tr><td><b>sqlite3_column_int64</b><td>&rarr;<td>64-bit INTEGER result
     <tr><td><b>sqlite3_column_text</b><td>&rarr;<td>UTF-8 TEXT result
     <tr><td><b>sqlite3_column_text16</b><td>&rarr;<td>UTF-16 TEXT result
     <tr><td><b>sqlite3_column_value</b><td>&rarr;<td>The result as an
     [sqlite3_value|unprotected sqlite3_value] object.
     <tr><td>&nbsp;<td>&nbsp;<td>&nbsp;
     <tr><td><b>sqlite3_column_bytes</b><td>&rarr;<td>Size of a BLOB
     or a UTF-8 TEXT result in bytes
     <tr><td><b>sqlite3_column_bytes16&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>Size of UTF-16
     TEXT in bytes
     <tr><td><b>sqlite3_column_type</b><td>&rarr;<td>Default
     datatype of the result
     </table></blockquote>

     <b>Details:</b>

     ^These routines return information about a single column of the current
     result row of a query.  ^In every case the first argument is a pointer
     to the [prepared statement] that is being evaluated (the [sqlite3_stmt*]
     that was returned from [sqlite3_prepare_v2()] or one of its variants)
     and the second argument is the index of the column for which information
     should be returned. ^The leftmost column of the result set has the index 0.
     ^The number of columns in the result can be determined using
     [sqlite3_column_count()].

     If the SQL statement does not currently point to a valid row, or if the
     column index is out of range, the result is undefined.
     These routines may only be called when the most recent call to
     [sqlite3_step()] has returned [SQLITE_ROW] and neither
     [sqlite3_reset()] nor [sqlite3_finalize()] have been called subsequently.
     If any of these routines are called after [sqlite3_reset()] or
     [sqlite3_finalize()] or after [sqlite3_step()] has returned
     something other than [SQLITE_ROW], the results are undefined.
     If [sqlite3_step()] or [sqlite3_reset()] or [sqlite3_finalize()]
     are called from a different thread while any of these routines
     are pending, then the results are undefined.

     The first six interfaces (_blob, _double, _int, _int64, _text, and _text16)
     each return the value of a result column in a specific data format.  If
     the result column is not initially in the requested format (for example,
     if the query returns an integer but the sqlite3_column_text() interface
     is used to extract the value) then an automatic type conversion is performed.

     ^The sqlite3_column_type() routine returns the
     [SQLITE_INTEGER | datatype code] for the initial data type
     of the result column.  ^The returned value is one of [SQLITE_INTEGER],
     [SQLITE_FLOAT], [SQLITE_TEXT], [SQLITE_BLOB], or [SQLITE_NULL].
     The return value of sqlite3_column_type() can be used to decide which
     of the first six interface should be used to extract the column value.
     The value returned by sqlite3_column_type() is only meaningful if no
     automatic type conversions have occurred for the value in question.
     After a type conversion, the result of calling sqlite3_column_type()
     is undefined, though harmless.  Future
     versions of SQLite may change the behavior of sqlite3_column_type()
     following a type conversion.

     If the result is a BLOB or a TEXT string, then the sqlite3_column_bytes()
     or sqlite3_column_bytes16() interfaces can be used to determine the size
     of that BLOB or string.

     ^If the result is a BLOB or UTF-8 string then the sqlite3_column_bytes()
     routine returns the number of bytes in that BLOB or string.
     ^If the result is a UTF-16 string, then sqlite3_column_bytes() converts
     the string to UTF-8 and then returns the number of bytes.
     ^If the result is a numeric value then sqlite3_column_bytes() uses
     [sqlite3_snprintf()] to convert that value to a UTF-8 string and returns
     the number of bytes in that string.
     ^If the result is NULL, then sqlite3_column_bytes() returns zero.

     ^If the result is a BLOB or UTF-16 string then the sqlite3_column_bytes16()
     routine returns the number of bytes in that BLOB or string.
     ^If the result is a UTF-8 string, then sqlite3_column_bytes16() converts
     the string to UTF-16 and then returns the number of bytes.
     ^If the result is a numeric value then sqlite3_column_bytes16() uses
     [sqlite3_snprintf()] to convert that value to a UTF-16 string and returns
     the number of bytes in that string.
     ^If the result is NULL, then sqlite3_column_bytes16() returns zero.

     ^The values returned by [sqlite3_column_bytes()] and
     [sqlite3_column_bytes16()] do not include the zero terminators at the end
     of the string.  ^For clarity: the values returned by
     [sqlite3_column_bytes()] and [sqlite3_column_bytes16()] are the number of
     bytes in the string, not the number of characters.

     ^Strings returned by sqlite3_column_text() and sqlite3_column_text16(),
     even empty strings, are always zero-terminated.  ^The return
     value from sqlite3_column_blob() for a zero-length BLOB is a NULL pointer.

     <b>Warning:</b> ^The object returned by [sqlite3_column_value()] is an
     [unprotected sqlite3_value] object.  In a multithreaded environment,
     an unprotected sqlite3_value object may only be used safely with
     [sqlite3_bind_value()] and [sqlite3_result_value()].
     If the [unprotected sqlite3_value] object returned by
     [sqlite3_column_value()] is used in any other way, including calls
     to routines like [sqlite3_value_int()], [sqlite3_value_text()],
     or [sqlite3_value_bytes()], the behavior is not threadsafe.
     Hence, the sqlite3_column_value() interface
     is normally only useful within the implementation of
     [application-defined SQL functions] or [virtual tables], not within
     top-level application code.

     The these routines may attempt to convert the datatype of the result.
     ^For example, if the internal representation is FLOAT and a text result
     is requested, [sqlite3_snprintf()] is used internally to perform the
     conversion automatically.  ^(The following table details the conversions
     that are applied:

     <blockquote>
     <table border="1">
     <tr><th> Internal<br>Type <th> Requested<br>Type <th>  Conversion

     <tr><td>  NULL    <td> INTEGER   <td> Result is 0
     <tr><td>  NULL    <td>  FLOAT    <td> Result is 0.0
     <tr><td>  NULL    <td>   TEXT    <td> Result is a NULL pointer
     <tr><td>  NULL    <td>   BLOB    <td> Result is a NULL pointer
     <tr><td> INTEGER  <td>  FLOAT    <td> Convert from integer to float
     <tr><td> INTEGER  <td>   TEXT    <td> ASCII rendering of the integer
     <tr><td> INTEGER  <td>   BLOB    <td> Same as INTEGER->TEXT
     <tr><td>  FLOAT   <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  FLOAT   <td>   TEXT    <td> ASCII rendering of the float
     <tr><td>  FLOAT   <td>   BLOB    <td> [CAST] to BLOB
     <tr><td>  TEXT    <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  TEXT    <td>  FLOAT    <td> [CAST] to REAL
     <tr><td>  TEXT    <td>   BLOB    <td> No change
     <tr><td>  BLOB    <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  BLOB    <td>  FLOAT    <td> [CAST] to REAL
     <tr><td>  BLOB    <td>   TEXT    <td> Add a zero terminator if needed
     </table>
     </blockquote>)^

     Note that when type conversions occur, pointers returned by prior
     calls to sqlite3_column_blob(), sqlite3_column_text(), and/or
     sqlite3_column_text16() may be invalidated.
     Type conversions and pointer invalidations might occur
     in the following cases:

     <ul>
     <li> The initial content is a BLOB and sqlite3_column_text() or
     sqlite3_column_text16() is called.  A zero-terminator might
     need to be added to the string.</li>
     <li> The initial content is UTF-8 text and sqlite3_column_bytes16() or
     sqlite3_column_text16() is called.  The content must be converted
     to UTF-16.</li>
     <li> The initial content is UTF-16 text and sqlite3_column_bytes() or
     sqlite3_column_text() is called.  The content must be converted
     to UTF-8.</li>
     </ul>

     ^Conversions between UTF-16be and UTF-16le are always done in place and do
     not invalidate a prior pointer, though of course the content of the buffer
     that the prior pointer references will have been modified.  Other kinds
     of conversion are done in place when it is possible, but sometimes they
     are not possible and in those cases prior pointers are invalidated.

     The safest policy is to invoke these routines
     in one of the following ways:

     <ul>
     <li>sqlite3_column_text() followed by sqlite3_column_bytes()</li>
     <li>sqlite3_column_blob() followed by sqlite3_column_bytes()</li>
     <li>sqlite3_column_text16() followed by sqlite3_column_bytes16()</li>
     </ul>

     In other words, you should call sqlite3_column_text(),
     sqlite3_column_blob(), or sqlite3_column_text16() first to force the result
     into the desired format, then invoke sqlite3_column_bytes() or
     sqlite3_column_bytes16() to find the size of the result.  Do not mix calls
     to sqlite3_column_text() or sqlite3_column_blob() with calls to
     sqlite3_column_bytes16(), and do not mix calls to sqlite3_column_text16()
     with calls to sqlite3_column_bytes().

     ^The pointers returned are valid until a type conversion occurs as
     described above, or until [sqlite3_step()] or [sqlite3_reset()] or
     [sqlite3_finalize()] is called.  ^The memory space used to hold strings
     and BLOBs is freed automatically.  Do not pass the pointers returned
     from [sqlite3_column_blob()], [sqlite3_column_text()], etc. into
     [sqlite3_free()].

     As long as the input parameters are correct, these routines will only
     fail if an out-of-memory error occurs during a format conversion.
     Only the following subset of interfaces are subject to out-of-memory
     errors:

     <ul>
     <li> sqlite3_column_blob()
     <li> sqlite3_column_text()
     <li> sqlite3_column_text16()
     <li> sqlite3_column_bytes()
     <li> sqlite3_column_bytes16()
     </ul>

     If an out-of-memory error occurs, then the return value from these
     routines is the same as if the column had contained an SQL NULL value.
     Valid SQL NULL returns can be distinguished from out-of-memory errors
     by invoking the [sqlite3_errcode()] immediately after the suspect
     return value is obtained and before any
     other SQLite interface is called on the same [database connection].
     */
    @inlinable public func columnText(at index: Int32) -> UnsafePointer<UInt8>? {
        sqlite3_column_text(rawValue, index)
    }

    /**
     CAPI3REF: Result Values From A Query
     KEYWORDS: {column access functions}
     METHOD: sqlite3_stmt

     <b>Summary:</b>
     <blockquote><table border=0 cellpadding=0 cellspacing=0>
     <tr><td><b>sqlite3_column_blob</b><td>&rarr;<td>BLOB result
     <tr><td><b>sqlite3_column_double</b><td>&rarr;<td>REAL result
     <tr><td><b>sqlite3_column_int</b><td>&rarr;<td>32-bit INTEGER result
     <tr><td><b>sqlite3_column_int64</b><td>&rarr;<td>64-bit INTEGER result
     <tr><td><b>sqlite3_column_text</b><td>&rarr;<td>UTF-8 TEXT result
     <tr><td><b>sqlite3_column_text16</b><td>&rarr;<td>UTF-16 TEXT result
     <tr><td><b>sqlite3_column_value</b><td>&rarr;<td>The result as an
     [sqlite3_value|unprotected sqlite3_value] object.
     <tr><td>&nbsp;<td>&nbsp;<td>&nbsp;
     <tr><td><b>sqlite3_column_bytes</b><td>&rarr;<td>Size of a BLOB
     or a UTF-8 TEXT result in bytes
     <tr><td><b>sqlite3_column_bytes16&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>Size of UTF-16
     TEXT in bytes
     <tr><td><b>sqlite3_column_type</b><td>&rarr;<td>Default
     datatype of the result
     </table></blockquote>

     <b>Details:</b>

     ^These routines return information about a single column of the current
     result row of a query.  ^In every case the first argument is a pointer
     to the [prepared statement] that is being evaluated (the [sqlite3_stmt*]
     that was returned from [sqlite3_prepare_v2()] or one of its variants)
     and the second argument is the index of the column for which information
     should be returned. ^The leftmost column of the result set has the index 0.
     ^The number of columns in the result can be determined using
     [sqlite3_column_count()].

     If the SQL statement does not currently point to a valid row, or if the
     column index is out of range, the result is undefined.
     These routines may only be called when the most recent call to
     [sqlite3_step()] has returned [SQLITE_ROW] and neither
     [sqlite3_reset()] nor [sqlite3_finalize()] have been called subsequently.
     If any of these routines are called after [sqlite3_reset()] or
     [sqlite3_finalize()] or after [sqlite3_step()] has returned
     something other than [SQLITE_ROW], the results are undefined.
     If [sqlite3_step()] or [sqlite3_reset()] or [sqlite3_finalize()]
     are called from a different thread while any of these routines
     are pending, then the results are undefined.

     The first six interfaces (_blob, _double, _int, _int64, _text, and _text16)
     each return the value of a result column in a specific data format.  If
     the result column is not initially in the requested format (for example,
     if the query returns an integer but the sqlite3_column_text() interface
     is used to extract the value) then an automatic type conversion is performed.

     ^The sqlite3_column_type() routine returns the
     [SQLITE_INTEGER | datatype code] for the initial data type
     of the result column.  ^The returned value is one of [SQLITE_INTEGER],
     [SQLITE_FLOAT], [SQLITE_TEXT], [SQLITE_BLOB], or [SQLITE_NULL].
     The return value of sqlite3_column_type() can be used to decide which
     of the first six interface should be used to extract the column value.
     The value returned by sqlite3_column_type() is only meaningful if no
     automatic type conversions have occurred for the value in question.
     After a type conversion, the result of calling sqlite3_column_type()
     is undefined, though harmless.  Future
     versions of SQLite may change the behavior of sqlite3_column_type()
     following a type conversion.

     If the result is a BLOB or a TEXT string, then the sqlite3_column_bytes()
     or sqlite3_column_bytes16() interfaces can be used to determine the size
     of that BLOB or string.

     ^If the result is a BLOB or UTF-8 string then the sqlite3_column_bytes()
     routine returns the number of bytes in that BLOB or string.
     ^If the result is a UTF-16 string, then sqlite3_column_bytes() converts
     the string to UTF-8 and then returns the number of bytes.
     ^If the result is a numeric value then sqlite3_column_bytes() uses
     [sqlite3_snprintf()] to convert that value to a UTF-8 string and returns
     the number of bytes in that string.
     ^If the result is NULL, then sqlite3_column_bytes() returns zero.

     ^If the result is a BLOB or UTF-16 string then the sqlite3_column_bytes16()
     routine returns the number of bytes in that BLOB or string.
     ^If the result is a UTF-8 string, then sqlite3_column_bytes16() converts
     the string to UTF-16 and then returns the number of bytes.
     ^If the result is a numeric value then sqlite3_column_bytes16() uses
     [sqlite3_snprintf()] to convert that value to a UTF-16 string and returns
     the number of bytes in that string.
     ^If the result is NULL, then sqlite3_column_bytes16() returns zero.

     ^The values returned by [sqlite3_column_bytes()] and
     [sqlite3_column_bytes16()] do not include the zero terminators at the end
     of the string.  ^For clarity: the values returned by
     [sqlite3_column_bytes()] and [sqlite3_column_bytes16()] are the number of
     bytes in the string, not the number of characters.

     ^Strings returned by sqlite3_column_text() and sqlite3_column_text16(),
     even empty strings, are always zero-terminated.  ^The return
     value from sqlite3_column_blob() for a zero-length BLOB is a NULL pointer.

     <b>Warning:</b> ^The object returned by [sqlite3_column_value()] is an
     [unprotected sqlite3_value] object.  In a multithreaded environment,
     an unprotected sqlite3_value object may only be used safely with
     [sqlite3_bind_value()] and [sqlite3_result_value()].
     If the [unprotected sqlite3_value] object returned by
     [sqlite3_column_value()] is used in any other way, including calls
     to routines like [sqlite3_value_int()], [sqlite3_value_text()],
     or [sqlite3_value_bytes()], the behavior is not threadsafe.
     Hence, the sqlite3_column_value() interface
     is normally only useful within the implementation of
     [application-defined SQL functions] or [virtual tables], not within
     top-level application code.

     The these routines may attempt to convert the datatype of the result.
     ^For example, if the internal representation is FLOAT and a text result
     is requested, [sqlite3_snprintf()] is used internally to perform the
     conversion automatically.  ^(The following table details the conversions
     that are applied:

     <blockquote>
     <table border="1">
     <tr><th> Internal<br>Type <th> Requested<br>Type <th>  Conversion

     <tr><td>  NULL    <td> INTEGER   <td> Result is 0
     <tr><td>  NULL    <td>  FLOAT    <td> Result is 0.0
     <tr><td>  NULL    <td>   TEXT    <td> Result is a NULL pointer
     <tr><td>  NULL    <td>   BLOB    <td> Result is a NULL pointer
     <tr><td> INTEGER  <td>  FLOAT    <td> Convert from integer to float
     <tr><td> INTEGER  <td>   TEXT    <td> ASCII rendering of the integer
     <tr><td> INTEGER  <td>   BLOB    <td> Same as INTEGER->TEXT
     <tr><td>  FLOAT   <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  FLOAT   <td>   TEXT    <td> ASCII rendering of the float
     <tr><td>  FLOAT   <td>   BLOB    <td> [CAST] to BLOB
     <tr><td>  TEXT    <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  TEXT    <td>  FLOAT    <td> [CAST] to REAL
     <tr><td>  TEXT    <td>   BLOB    <td> No change
     <tr><td>  BLOB    <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  BLOB    <td>  FLOAT    <td> [CAST] to REAL
     <tr><td>  BLOB    <td>   TEXT    <td> Add a zero terminator if needed
     </table>
     </blockquote>)^

     Note that when type conversions occur, pointers returned by prior
     calls to sqlite3_column_blob(), sqlite3_column_text(), and/or
     sqlite3_column_text16() may be invalidated.
     Type conversions and pointer invalidations might occur
     in the following cases:

     <ul>
     <li> The initial content is a BLOB and sqlite3_column_text() or
     sqlite3_column_text16() is called.  A zero-terminator might
     need to be added to the string.</li>
     <li> The initial content is UTF-8 text and sqlite3_column_bytes16() or
     sqlite3_column_text16() is called.  The content must be converted
     to UTF-16.</li>
     <li> The initial content is UTF-16 text and sqlite3_column_bytes() or
     sqlite3_column_text() is called.  The content must be converted
     to UTF-8.</li>
     </ul>

     ^Conversions between UTF-16be and UTF-16le are always done in place and do
     not invalidate a prior pointer, though of course the content of the buffer
     that the prior pointer references will have been modified.  Other kinds
     of conversion are done in place when it is possible, but sometimes they
     are not possible and in those cases prior pointers are invalidated.

     The safest policy is to invoke these routines
     in one of the following ways:

     <ul>
     <li>sqlite3_column_text() followed by sqlite3_column_bytes()</li>
     <li>sqlite3_column_blob() followed by sqlite3_column_bytes()</li>
     <li>sqlite3_column_text16() followed by sqlite3_column_bytes16()</li>
     </ul>

     In other words, you should call sqlite3_column_text(),
     sqlite3_column_blob(), or sqlite3_column_text16() first to force the result
     into the desired format, then invoke sqlite3_column_bytes() or
     sqlite3_column_bytes16() to find the size of the result.  Do not mix calls
     to sqlite3_column_text() or sqlite3_column_blob() with calls to
     sqlite3_column_bytes16(), and do not mix calls to sqlite3_column_text16()
     with calls to sqlite3_column_bytes().

     ^The pointers returned are valid until a type conversion occurs as
     described above, or until [sqlite3_step()] or [sqlite3_reset()] or
     [sqlite3_finalize()] is called.  ^The memory space used to hold strings
     and BLOBs is freed automatically.  Do not pass the pointers returned
     from [sqlite3_column_blob()], [sqlite3_column_text()], etc. into
     [sqlite3_free()].

     As long as the input parameters are correct, these routines will only
     fail if an out-of-memory error occurs during a format conversion.
     Only the following subset of interfaces are subject to out-of-memory
     errors:

     <ul>
     <li> sqlite3_column_blob()
     <li> sqlite3_column_text()
     <li> sqlite3_column_text16()
     <li> sqlite3_column_bytes()
     <li> sqlite3_column_bytes16()
     </ul>

     If an out-of-memory error occurs, then the return value from these
     routines is the same as if the column had contained an SQL NULL value.
     Valid SQL NULL returns can be distinguished from out-of-memory errors
     by invoking the [sqlite3_errcode()] immediately after the suspect
     return value is obtained and before any
     other SQLite interface is called on the same [database connection].
     */
    @inlinable public func columnBytes(at index: Int32) -> Int32 {
        sqlite3_column_bytes(rawValue, index)
    }

    /**
     CAPI3REF: Result Values From A Query
     KEYWORDS: {column access functions}
     METHOD: sqlite3_stmt

     <b>Summary:</b>
     <blockquote><table border=0 cellpadding=0 cellspacing=0>
     <tr><td><b>sqlite3_column_blob</b><td>&rarr;<td>BLOB result
     <tr><td><b>sqlite3_column_double</b><td>&rarr;<td>REAL result
     <tr><td><b>sqlite3_column_int</b><td>&rarr;<td>32-bit INTEGER result
     <tr><td><b>sqlite3_column_int64</b><td>&rarr;<td>64-bit INTEGER result
     <tr><td><b>sqlite3_column_text</b><td>&rarr;<td>UTF-8 TEXT result
     <tr><td><b>sqlite3_column_text16</b><td>&rarr;<td>UTF-16 TEXT result
     <tr><td><b>sqlite3_column_value</b><td>&rarr;<td>The result as an
     [sqlite3_value|unprotected sqlite3_value] object.
     <tr><td>&nbsp;<td>&nbsp;<td>&nbsp;
     <tr><td><b>sqlite3_column_bytes</b><td>&rarr;<td>Size of a BLOB
     or a UTF-8 TEXT result in bytes
     <tr><td><b>sqlite3_column_bytes16&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>Size of UTF-16
     TEXT in bytes
     <tr><td><b>sqlite3_column_type</b><td>&rarr;<td>Default
     datatype of the result
     </table></blockquote>

     <b>Details:</b>

     ^These routines return information about a single column of the current
     result row of a query.  ^In every case the first argument is a pointer
     to the [prepared statement] that is being evaluated (the [sqlite3_stmt*]
     that was returned from [sqlite3_prepare_v2()] or one of its variants)
     and the second argument is the index of the column for which information
     should be returned. ^The leftmost column of the result set has the index 0.
     ^The number of columns in the result can be determined using
     [sqlite3_column_count()].

     If the SQL statement does not currently point to a valid row, or if the
     column index is out of range, the result is undefined.
     These routines may only be called when the most recent call to
     [sqlite3_step()] has returned [SQLITE_ROW] and neither
     [sqlite3_reset()] nor [sqlite3_finalize()] have been called subsequently.
     If any of these routines are called after [sqlite3_reset()] or
     [sqlite3_finalize()] or after [sqlite3_step()] has returned
     something other than [SQLITE_ROW], the results are undefined.
     If [sqlite3_step()] or [sqlite3_reset()] or [sqlite3_finalize()]
     are called from a different thread while any of these routines
     are pending, then the results are undefined.

     The first six interfaces (_blob, _double, _int, _int64, _text, and _text16)
     each return the value of a result column in a specific data format.  If
     the result column is not initially in the requested format (for example,
     if the query returns an integer but the sqlite3_column_text() interface
     is used to extract the value) then an automatic type conversion is performed.

     ^The sqlite3_column_type() routine returns the
     [SQLITE_INTEGER | datatype code] for the initial data type
     of the result column.  ^The returned value is one of [SQLITE_INTEGER],
     [SQLITE_FLOAT], [SQLITE_TEXT], [SQLITE_BLOB], or [SQLITE_NULL].
     The return value of sqlite3_column_type() can be used to decide which
     of the first six interface should be used to extract the column value.
     The value returned by sqlite3_column_type() is only meaningful if no
     automatic type conversions have occurred for the value in question.
     After a type conversion, the result of calling sqlite3_column_type()
     is undefined, though harmless.  Future
     versions of SQLite may change the behavior of sqlite3_column_type()
     following a type conversion.

     If the result is a BLOB or a TEXT string, then the sqlite3_column_bytes()
     or sqlite3_column_bytes16() interfaces can be used to determine the size
     of that BLOB or string.

     ^If the result is a BLOB or UTF-8 string then the sqlite3_column_bytes()
     routine returns the number of bytes in that BLOB or string.
     ^If the result is a UTF-16 string, then sqlite3_column_bytes() converts
     the string to UTF-8 and then returns the number of bytes.
     ^If the result is a numeric value then sqlite3_column_bytes() uses
     [sqlite3_snprintf()] to convert that value to a UTF-8 string and returns
     the number of bytes in that string.
     ^If the result is NULL, then sqlite3_column_bytes() returns zero.

     ^If the result is a BLOB or UTF-16 string then the sqlite3_column_bytes16()
     routine returns the number of bytes in that BLOB or string.
     ^If the result is a UTF-8 string, then sqlite3_column_bytes16() converts
     the string to UTF-16 and then returns the number of bytes.
     ^If the result is a numeric value then sqlite3_column_bytes16() uses
     [sqlite3_snprintf()] to convert that value to a UTF-16 string and returns
     the number of bytes in that string.
     ^If the result is NULL, then sqlite3_column_bytes16() returns zero.

     ^The values returned by [sqlite3_column_bytes()] and
     [sqlite3_column_bytes16()] do not include the zero terminators at the end
     of the string.  ^For clarity: the values returned by
     [sqlite3_column_bytes()] and [sqlite3_column_bytes16()] are the number of
     bytes in the string, not the number of characters.

     ^Strings returned by sqlite3_column_text() and sqlite3_column_text16(),
     even empty strings, are always zero-terminated.  ^The return
     value from sqlite3_column_blob() for a zero-length BLOB is a NULL pointer.

     <b>Warning:</b> ^The object returned by [sqlite3_column_value()] is an
     [unprotected sqlite3_value] object.  In a multithreaded environment,
     an unprotected sqlite3_value object may only be used safely with
     [sqlite3_bind_value()] and [sqlite3_result_value()].
     If the [unprotected sqlite3_value] object returned by
     [sqlite3_column_value()] is used in any other way, including calls
     to routines like [sqlite3_value_int()], [sqlite3_value_text()],
     or [sqlite3_value_bytes()], the behavior is not threadsafe.
     Hence, the sqlite3_column_value() interface
     is normally only useful within the implementation of
     [application-defined SQL functions] or [virtual tables], not within
     top-level application code.

     The these routines may attempt to convert the datatype of the result.
     ^For example, if the internal representation is FLOAT and a text result
     is requested, [sqlite3_snprintf()] is used internally to perform the
     conversion automatically.  ^(The following table details the conversions
     that are applied:

     <blockquote>
     <table border="1">
     <tr><th> Internal<br>Type <th> Requested<br>Type <th>  Conversion

     <tr><td>  NULL    <td> INTEGER   <td> Result is 0
     <tr><td>  NULL    <td>  FLOAT    <td> Result is 0.0
     <tr><td>  NULL    <td>   TEXT    <td> Result is a NULL pointer
     <tr><td>  NULL    <td>   BLOB    <td> Result is a NULL pointer
     <tr><td> INTEGER  <td>  FLOAT    <td> Convert from integer to float
     <tr><td> INTEGER  <td>   TEXT    <td> ASCII rendering of the integer
     <tr><td> INTEGER  <td>   BLOB    <td> Same as INTEGER->TEXT
     <tr><td>  FLOAT   <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  FLOAT   <td>   TEXT    <td> ASCII rendering of the float
     <tr><td>  FLOAT   <td>   BLOB    <td> [CAST] to BLOB
     <tr><td>  TEXT    <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  TEXT    <td>  FLOAT    <td> [CAST] to REAL
     <tr><td>  TEXT    <td>   BLOB    <td> No change
     <tr><td>  BLOB    <td> INTEGER   <td> [CAST] to INTEGER
     <tr><td>  BLOB    <td>  FLOAT    <td> [CAST] to REAL
     <tr><td>  BLOB    <td>   TEXT    <td> Add a zero terminator if needed
     </table>
     </blockquote>)^

     Note that when type conversions occur, pointers returned by prior
     calls to sqlite3_column_blob(), sqlite3_column_text(), and/or
     sqlite3_column_text16() may be invalidated.
     Type conversions and pointer invalidations might occur
     in the following cases:

     <ul>
     <li> The initial content is a BLOB and sqlite3_column_text() or
     sqlite3_column_text16() is called.  A zero-terminator might
     need to be added to the string.</li>
     <li> The initial content is UTF-8 text and sqlite3_column_bytes16() or
     sqlite3_column_text16() is called.  The content must be converted
     to UTF-16.</li>
     <li> The initial content is UTF-16 text and sqlite3_column_bytes() or
     sqlite3_column_text() is called.  The content must be converted
     to UTF-8.</li>
     </ul>

     ^Conversions between UTF-16be and UTF-16le are always done in place and do
     not invalidate a prior pointer, though of course the content of the buffer
     that the prior pointer references will have been modified.  Other kinds
     of conversion are done in place when it is possible, but sometimes they
     are not possible and in those cases prior pointers are invalidated.

     The safest policy is to invoke these routines
     in one of the following ways:

     <ul>
     <li>sqlite3_column_text() followed by sqlite3_column_bytes()</li>
     <li>sqlite3_column_blob() followed by sqlite3_column_bytes()</li>
     <li>sqlite3_column_text16() followed by sqlite3_column_bytes16()</li>
     </ul>

     In other words, you should call sqlite3_column_text(),
     sqlite3_column_blob(), or sqlite3_column_text16() first to force the result
     into the desired format, then invoke sqlite3_column_bytes() or
     sqlite3_column_bytes16() to find the size of the result.  Do not mix calls
     to sqlite3_column_text() or sqlite3_column_blob() with calls to
     sqlite3_column_bytes16(), and do not mix calls to sqlite3_column_text16()
     with calls to sqlite3_column_bytes().

     ^The pointers returned are valid until a type conversion occurs as
     described above, or until [sqlite3_step()] or [sqlite3_reset()] or
     [sqlite3_finalize()] is called.  ^The memory space used to hold strings
     and BLOBs is freed automatically.  Do not pass the pointers returned
     from [sqlite3_column_blob()], [sqlite3_column_text()], etc. into
     [sqlite3_free()].

     As long as the input parameters are correct, these routines will only
     fail if an out-of-memory error occurs during a format conversion.
     Only the following subset of interfaces are subject to out-of-memory
     errors:

     <ul>
     <li> sqlite3_column_blob()
     <li> sqlite3_column_text()
     <li> sqlite3_column_text16()
     <li> sqlite3_column_bytes()
     <li> sqlite3_column_bytes16()
     </ul>

     If an out-of-memory error occurs, then the return value from these
     routines is the same as if the column had contained an SQL NULL value.
     Valid SQL NULL returns can be distinguished from out-of-memory errors
     by invoking the [sqlite3_errcode()] immediately after the suspect
     return value is obtained and before any
     other SQLite interface is called on the same [database connection].
     */
    @inlinable public func columnType(at index: Int32) -> Datatype {
        Datatype(rawValue: sqlite3_column_type(rawValue, index))
    }
}
