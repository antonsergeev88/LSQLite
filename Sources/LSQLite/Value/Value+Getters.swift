import MissedSwiftSQLite

extension Value {
    /**
     CAPI3REF: Obtaining SQL Values
     METHOD: sqlite3_value

     <b>Summary:</b>
     <blockquote><table border=0 cellpadding=0 cellspacing=0>
     <tr><td><b>sqlite3_value_blob</b><td>&rarr;<td>BLOB value
     <tr><td><b>sqlite3_value_double</b><td>&rarr;<td>REAL value
     <tr><td><b>sqlite3_value_int</b><td>&rarr;<td>32-bit INTEGER value
     <tr><td><b>sqlite3_value_int64</b><td>&rarr;<td>64-bit INTEGER value
     <tr><td><b>sqlite3_value_pointer</b><td>&rarr;<td>Pointer value
     <tr><td><b>sqlite3_value_text</b><td>&rarr;<td>UTF-8 TEXT value
     <tr><td><b>sqlite3_value_text16</b><td>&rarr;<td>UTF-16 TEXT value in
     the native byteorder
     <tr><td><b>sqlite3_value_text16be</b><td>&rarr;<td>UTF-16be TEXT value
     <tr><td><b>sqlite3_value_text16le</b><td>&rarr;<td>UTF-16le TEXT value
     <tr><td>&nbsp;<td>&nbsp;<td>&nbsp;
     <tr><td><b>sqlite3_value_bytes</b><td>&rarr;<td>Size of a BLOB
     or a UTF-8 TEXT in bytes
     <tr><td><b>sqlite3_value_bytes16&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>Size of UTF-16
     TEXT in bytes
     <tr><td><b>sqlite3_value_type</b><td>&rarr;<td>Default
     datatype of the value
     <tr><td><b>sqlite3_value_numeric_type&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>Best numeric datatype of the value
     <tr><td><b>sqlite3_value_nochange&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>True if the column is unchanged in an UPDATE
     against a virtual table.
     <tr><td><b>sqlite3_value_frombind&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>True if value originated from a [bound parameter]
     </table></blockquote>

     <b>Details:</b>

     These routines extract type, size, and content information from
     [protected sqlite3_value] objects.  Protected sqlite3_value objects
     are used to pass parameter information into implementation of
     [application-defined SQL functions] and [virtual tables].

     These routines work only with [protected sqlite3_value] objects.
     Any attempt to use these routines on an [unprotected sqlite3_value]
     is not threadsafe.

     ^These routines work just like the corresponding [column access functions]
     except that these routines take a single [protected sqlite3_value] object
     pointer instead of a [sqlite3_stmt*] pointer and an integer column number.

     ^The sqlite3_value_text16() interface extracts a UTF-16 string
     in the native byte-order of the host machine.  ^The
     sqlite3_value_text16be() and sqlite3_value_text16le() interfaces
     extract UTF-16 strings as big-endian and little-endian respectively.

     ^If [sqlite3_value] object V was initialized
     using [sqlite3_bind_pointer(S,I,P,X,D)] or [sqlite3_result_pointer(C,P,X,D)]
     and if X and Y are strings that compare equal according to strcmp(X,Y),
     then sqlite3_value_pointer(V,Y) will return the pointer P.  ^Otherwise,
     sqlite3_value_pointer(V,Y) returns a NULL. The sqlite3_bind_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     ^(The sqlite3_value_type(V) interface returns the
     [SQLITE_INTEGER | datatype code] for the initial datatype of the
     [sqlite3_value] object V. The returned value is one of [SQLITE_INTEGER],
     [SQLITE_FLOAT], [SQLITE_TEXT], [SQLITE_BLOB], or [SQLITE_NULL].)^
     Other interfaces might change the datatype for an sqlite3_value object.
     For example, if the datatype is initially SQLITE_INTEGER and
     sqlite3_value_text(V) is called to extract a text value for that
     integer, then subsequent calls to sqlite3_value_type(V) might return
     SQLITE_TEXT.  Whether or not a persistent internal datatype conversion
     occurs is undefined and may change from one release of SQLite to the next.

     ^(The sqlite3_value_numeric_type() interface attempts to apply
     numeric affinity to the value.  This means that an attempt is
     made to convert the value to an integer or floating point.  If
     such a conversion is possible without loss of information (in other
     words, if the value is a string that looks like a number)
     then the conversion is performed.  Otherwise no conversion occurs.
     The [SQLITE_INTEGER | datatype] after conversion is returned.)^

     ^Within the [xUpdate] method of a [virtual table], the
     sqlite3_value_nochange(X) interface returns true if and only if
     the column corresponding to X is unchanged by the UPDATE operation
     that the xUpdate method call was invoked to implement and if
     and the prior [xColumn] method call that was invoked to extracted
     the value for that column returned without setting a result (probably
     because it queried [sqlite3_vtab_nochange()] and found that the column
     was unchanging).  ^Within an [xUpdate] method, any value for which
     sqlite3_value_nochange(X) is true will in all other respects appear
     to be a NULL value.  If sqlite3_value_nochange(X) is invoked anywhere other
     than within an [xUpdate] method call for an UPDATE statement, then
     the return value is arbitrary and meaningless.

     ^The sqlite3_value_frombind(X) interface returns non-zero if the
     value X originated from one of the [sqlite3_bind_int|sqlite3_bind()]
     interfaces.  ^If X comes from an SQL literal value, or a table column,
     and expression, then sqlite3_value_frombind(X) returns zero.

     Please pay particular attention to the fact that the pointer returned
     from [sqlite3_value_blob()], [sqlite3_value_text()], or
     [sqlite3_value_text16()] can be invalidated by a subsequent call to
     [sqlite3_value_bytes()], [sqlite3_value_bytes16()], [sqlite3_value_text()],
     or [sqlite3_value_text16()].

     These routines must be called from the same thread as
     the SQL function that supplied the [sqlite3_value*] parameters.

     As long as the input parameter is correct, these routines can only
     fail if an out-of-memory error occurs during a format conversion.
     Only the following subset of interfaces are subject to out-of-memory
     errors:

     <ul>
     <li> sqlite3_value_blob()
     <li> sqlite3_value_text()
     <li> sqlite3_value_text16()
     <li> sqlite3_value_text16le()
     <li> sqlite3_value_text16be()
     <li> sqlite3_value_bytes()
     <li> sqlite3_value_bytes16()
     </ul>

     If an out-of-memory error occurs, then the return value from these
     routines is the same as if the column had contained an SQL NULL value.
     Valid SQL NULL returns can be distinguished from out-of-memory errors
     by invoking the [sqlite3_errcode()] immediately after the suspect
     return value is obtained and before any
     other SQLite interface is called on the same [database connection].
    */
    @inlinable public var blob: UnsafeRawPointer? {
        sqlite3_value_blob(rawValue)
    }

    /**
     CAPI3REF: Obtaining SQL Values
     METHOD: sqlite3_value

     <b>Summary:</b>
     <blockquote><table border=0 cellpadding=0 cellspacing=0>
     <tr><td><b>sqlite3_value_blob</b><td>&rarr;<td>BLOB value
     <tr><td><b>sqlite3_value_double</b><td>&rarr;<td>REAL value
     <tr><td><b>sqlite3_value_int</b><td>&rarr;<td>32-bit INTEGER value
     <tr><td><b>sqlite3_value_int64</b><td>&rarr;<td>64-bit INTEGER value
     <tr><td><b>sqlite3_value_pointer</b><td>&rarr;<td>Pointer value
     <tr><td><b>sqlite3_value_text</b><td>&rarr;<td>UTF-8 TEXT value
     <tr><td><b>sqlite3_value_text16</b><td>&rarr;<td>UTF-16 TEXT value in
     the native byteorder
     <tr><td><b>sqlite3_value_text16be</b><td>&rarr;<td>UTF-16be TEXT value
     <tr><td><b>sqlite3_value_text16le</b><td>&rarr;<td>UTF-16le TEXT value
     <tr><td>&nbsp;<td>&nbsp;<td>&nbsp;
     <tr><td><b>sqlite3_value_bytes</b><td>&rarr;<td>Size of a BLOB
     or a UTF-8 TEXT in bytes
     <tr><td><b>sqlite3_value_bytes16&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>Size of UTF-16
     TEXT in bytes
     <tr><td><b>sqlite3_value_type</b><td>&rarr;<td>Default
     datatype of the value
     <tr><td><b>sqlite3_value_numeric_type&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>Best numeric datatype of the value
     <tr><td><b>sqlite3_value_nochange&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>True if the column is unchanged in an UPDATE
     against a virtual table.
     <tr><td><b>sqlite3_value_frombind&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>True if value originated from a [bound parameter]
     </table></blockquote>

     <b>Details:</b>

     These routines extract type, size, and content information from
     [protected sqlite3_value] objects.  Protected sqlite3_value objects
     are used to pass parameter information into implementation of
     [application-defined SQL functions] and [virtual tables].

     These routines work only with [protected sqlite3_value] objects.
     Any attempt to use these routines on an [unprotected sqlite3_value]
     is not threadsafe.

     ^These routines work just like the corresponding [column access functions]
     except that these routines take a single [protected sqlite3_value] object
     pointer instead of a [sqlite3_stmt*] pointer and an integer column number.

     ^The sqlite3_value_text16() interface extracts a UTF-16 string
     in the native byte-order of the host machine.  ^The
     sqlite3_value_text16be() and sqlite3_value_text16le() interfaces
     extract UTF-16 strings as big-endian and little-endian respectively.

     ^If [sqlite3_value] object V was initialized
     using [sqlite3_bind_pointer(S,I,P,X,D)] or [sqlite3_result_pointer(C,P,X,D)]
     and if X and Y are strings that compare equal according to strcmp(X,Y),
     then sqlite3_value_pointer(V,Y) will return the pointer P.  ^Otherwise,
     sqlite3_value_pointer(V,Y) returns a NULL. The sqlite3_bind_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     ^(The sqlite3_value_type(V) interface returns the
     [SQLITE_INTEGER | datatype code] for the initial datatype of the
     [sqlite3_value] object V. The returned value is one of [SQLITE_INTEGER],
     [SQLITE_FLOAT], [SQLITE_TEXT], [SQLITE_BLOB], or [SQLITE_NULL].)^
     Other interfaces might change the datatype for an sqlite3_value object.
     For example, if the datatype is initially SQLITE_INTEGER and
     sqlite3_value_text(V) is called to extract a text value for that
     integer, then subsequent calls to sqlite3_value_type(V) might return
     SQLITE_TEXT.  Whether or not a persistent internal datatype conversion
     occurs is undefined and may change from one release of SQLite to the next.

     ^(The sqlite3_value_numeric_type() interface attempts to apply
     numeric affinity to the value.  This means that an attempt is
     made to convert the value to an integer or floating point.  If
     such a conversion is possible without loss of information (in other
     words, if the value is a string that looks like a number)
     then the conversion is performed.  Otherwise no conversion occurs.
     The [SQLITE_INTEGER | datatype] after conversion is returned.)^

     ^Within the [xUpdate] method of a [virtual table], the
     sqlite3_value_nochange(X) interface returns true if and only if
     the column corresponding to X is unchanged by the UPDATE operation
     that the xUpdate method call was invoked to implement and if
     and the prior [xColumn] method call that was invoked to extracted
     the value for that column returned without setting a result (probably
     because it queried [sqlite3_vtab_nochange()] and found that the column
     was unchanging).  ^Within an [xUpdate] method, any value for which
     sqlite3_value_nochange(X) is true will in all other respects appear
     to be a NULL value.  If sqlite3_value_nochange(X) is invoked anywhere other
     than within an [xUpdate] method call for an UPDATE statement, then
     the return value is arbitrary and meaningless.

     ^The sqlite3_value_frombind(X) interface returns non-zero if the
     value X originated from one of the [sqlite3_bind_int|sqlite3_bind()]
     interfaces.  ^If X comes from an SQL literal value, or a table column,
     and expression, then sqlite3_value_frombind(X) returns zero.

     Please pay particular attention to the fact that the pointer returned
     from [sqlite3_value_blob()], [sqlite3_value_text()], or
     [sqlite3_value_text16()] can be invalidated by a subsequent call to
     [sqlite3_value_bytes()], [sqlite3_value_bytes16()], [sqlite3_value_text()],
     or [sqlite3_value_text16()].

     These routines must be called from the same thread as
     the SQL function that supplied the [sqlite3_value*] parameters.

     As long as the input parameter is correct, these routines can only
     fail if an out-of-memory error occurs during a format conversion.
     Only the following subset of interfaces are subject to out-of-memory
     errors:

     <ul>
     <li> sqlite3_value_blob()
     <li> sqlite3_value_text()
     <li> sqlite3_value_text16()
     <li> sqlite3_value_text16le()
     <li> sqlite3_value_text16be()
     <li> sqlite3_value_bytes()
     <li> sqlite3_value_bytes16()
     </ul>

     If an out-of-memory error occurs, then the return value from these
     routines is the same as if the column had contained an SQL NULL value.
     Valid SQL NULL returns can be distinguished from out-of-memory errors
     by invoking the [sqlite3_errcode()] immediately after the suspect
     return value is obtained and before any
     other SQLite interface is called on the same [database connection].
    */
    @inlinable public var double: Double {
        sqlite3_value_double(rawValue)
    }

    /**
     CAPI3REF: Obtaining SQL Values
     METHOD: sqlite3_value

     <b>Summary:</b>
     <blockquote><table border=0 cellpadding=0 cellspacing=0>
     <tr><td><b>sqlite3_value_blob</b><td>&rarr;<td>BLOB value
     <tr><td><b>sqlite3_value_double</b><td>&rarr;<td>REAL value
     <tr><td><b>sqlite3_value_int</b><td>&rarr;<td>32-bit INTEGER value
     <tr><td><b>sqlite3_value_int64</b><td>&rarr;<td>64-bit INTEGER value
     <tr><td><b>sqlite3_value_pointer</b><td>&rarr;<td>Pointer value
     <tr><td><b>sqlite3_value_text</b><td>&rarr;<td>UTF-8 TEXT value
     <tr><td><b>sqlite3_value_text16</b><td>&rarr;<td>UTF-16 TEXT value in
     the native byteorder
     <tr><td><b>sqlite3_value_text16be</b><td>&rarr;<td>UTF-16be TEXT value
     <tr><td><b>sqlite3_value_text16le</b><td>&rarr;<td>UTF-16le TEXT value
     <tr><td>&nbsp;<td>&nbsp;<td>&nbsp;
     <tr><td><b>sqlite3_value_bytes</b><td>&rarr;<td>Size of a BLOB
     or a UTF-8 TEXT in bytes
     <tr><td><b>sqlite3_value_bytes16&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>Size of UTF-16
     TEXT in bytes
     <tr><td><b>sqlite3_value_type</b><td>&rarr;<td>Default
     datatype of the value
     <tr><td><b>sqlite3_value_numeric_type&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>Best numeric datatype of the value
     <tr><td><b>sqlite3_value_nochange&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>True if the column is unchanged in an UPDATE
     against a virtual table.
     <tr><td><b>sqlite3_value_frombind&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>True if value originated from a [bound parameter]
     </table></blockquote>

     <b>Details:</b>

     These routines extract type, size, and content information from
     [protected sqlite3_value] objects.  Protected sqlite3_value objects
     are used to pass parameter information into implementation of
     [application-defined SQL functions] and [virtual tables].

     These routines work only with [protected sqlite3_value] objects.
     Any attempt to use these routines on an [unprotected sqlite3_value]
     is not threadsafe.

     ^These routines work just like the corresponding [column access functions]
     except that these routines take a single [protected sqlite3_value] object
     pointer instead of a [sqlite3_stmt*] pointer and an integer column number.

     ^The sqlite3_value_text16() interface extracts a UTF-16 string
     in the native byte-order of the host machine.  ^The
     sqlite3_value_text16be() and sqlite3_value_text16le() interfaces
     extract UTF-16 strings as big-endian and little-endian respectively.

     ^If [sqlite3_value] object V was initialized
     using [sqlite3_bind_pointer(S,I,P,X,D)] or [sqlite3_result_pointer(C,P,X,D)]
     and if X and Y are strings that compare equal according to strcmp(X,Y),
     then sqlite3_value_pointer(V,Y) will return the pointer P.  ^Otherwise,
     sqlite3_value_pointer(V,Y) returns a NULL. The sqlite3_bind_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     ^(The sqlite3_value_type(V) interface returns the
     [SQLITE_INTEGER | datatype code] for the initial datatype of the
     [sqlite3_value] object V. The returned value is one of [SQLITE_INTEGER],
     [SQLITE_FLOAT], [SQLITE_TEXT], [SQLITE_BLOB], or [SQLITE_NULL].)^
     Other interfaces might change the datatype for an sqlite3_value object.
     For example, if the datatype is initially SQLITE_INTEGER and
     sqlite3_value_text(V) is called to extract a text value for that
     integer, then subsequent calls to sqlite3_value_type(V) might return
     SQLITE_TEXT.  Whether or not a persistent internal datatype conversion
     occurs is undefined and may change from one release of SQLite to the next.

     ^(The sqlite3_value_numeric_type() interface attempts to apply
     numeric affinity to the value.  This means that an attempt is
     made to convert the value to an integer or floating point.  If
     such a conversion is possible without loss of information (in other
     words, if the value is a string that looks like a number)
     then the conversion is performed.  Otherwise no conversion occurs.
     The [SQLITE_INTEGER | datatype] after conversion is returned.)^

     ^Within the [xUpdate] method of a [virtual table], the
     sqlite3_value_nochange(X) interface returns true if and only if
     the column corresponding to X is unchanged by the UPDATE operation
     that the xUpdate method call was invoked to implement and if
     and the prior [xColumn] method call that was invoked to extracted
     the value for that column returned without setting a result (probably
     because it queried [sqlite3_vtab_nochange()] and found that the column
     was unchanging).  ^Within an [xUpdate] method, any value for which
     sqlite3_value_nochange(X) is true will in all other respects appear
     to be a NULL value.  If sqlite3_value_nochange(X) is invoked anywhere other
     than within an [xUpdate] method call for an UPDATE statement, then
     the return value is arbitrary and meaningless.

     ^The sqlite3_value_frombind(X) interface returns non-zero if the
     value X originated from one of the [sqlite3_bind_int|sqlite3_bind()]
     interfaces.  ^If X comes from an SQL literal value, or a table column,
     and expression, then sqlite3_value_frombind(X) returns zero.

     Please pay particular attention to the fact that the pointer returned
     from [sqlite3_value_blob()], [sqlite3_value_text()], or
     [sqlite3_value_text16()] can be invalidated by a subsequent call to
     [sqlite3_value_bytes()], [sqlite3_value_bytes16()], [sqlite3_value_text()],
     or [sqlite3_value_text16()].

     These routines must be called from the same thread as
     the SQL function that supplied the [sqlite3_value*] parameters.

     As long as the input parameter is correct, these routines can only
     fail if an out-of-memory error occurs during a format conversion.
     Only the following subset of interfaces are subject to out-of-memory
     errors:

     <ul>
     <li> sqlite3_value_blob()
     <li> sqlite3_value_text()
     <li> sqlite3_value_text16()
     <li> sqlite3_value_text16le()
     <li> sqlite3_value_text16be()
     <li> sqlite3_value_bytes()
     <li> sqlite3_value_bytes16()
     </ul>

     If an out-of-memory error occurs, then the return value from these
     routines is the same as if the column had contained an SQL NULL value.
     Valid SQL NULL returns can be distinguished from out-of-memory errors
     by invoking the [sqlite3_errcode()] immediately after the suspect
     return value is obtained and before any
     other SQLite interface is called on the same [database connection].
    */
    @inlinable public var int: Int32 {
        sqlite3_value_int(rawValue)
    }

    /**
     CAPI3REF: Obtaining SQL Values
     METHOD: sqlite3_value

     <b>Summary:</b>
     <blockquote><table border=0 cellpadding=0 cellspacing=0>
     <tr><td><b>sqlite3_value_blob</b><td>&rarr;<td>BLOB value
     <tr><td><b>sqlite3_value_double</b><td>&rarr;<td>REAL value
     <tr><td><b>sqlite3_value_int</b><td>&rarr;<td>32-bit INTEGER value
     <tr><td><b>sqlite3_value_int64</b><td>&rarr;<td>64-bit INTEGER value
     <tr><td><b>sqlite3_value_pointer</b><td>&rarr;<td>Pointer value
     <tr><td><b>sqlite3_value_text</b><td>&rarr;<td>UTF-8 TEXT value
     <tr><td><b>sqlite3_value_text16</b><td>&rarr;<td>UTF-16 TEXT value in
     the native byteorder
     <tr><td><b>sqlite3_value_text16be</b><td>&rarr;<td>UTF-16be TEXT value
     <tr><td><b>sqlite3_value_text16le</b><td>&rarr;<td>UTF-16le TEXT value
     <tr><td>&nbsp;<td>&nbsp;<td>&nbsp;
     <tr><td><b>sqlite3_value_bytes</b><td>&rarr;<td>Size of a BLOB
     or a UTF-8 TEXT in bytes
     <tr><td><b>sqlite3_value_bytes16&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>Size of UTF-16
     TEXT in bytes
     <tr><td><b>sqlite3_value_type</b><td>&rarr;<td>Default
     datatype of the value
     <tr><td><b>sqlite3_value_numeric_type&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>Best numeric datatype of the value
     <tr><td><b>sqlite3_value_nochange&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>True if the column is unchanged in an UPDATE
     against a virtual table.
     <tr><td><b>sqlite3_value_frombind&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>True if value originated from a [bound parameter]
     </table></blockquote>

     <b>Details:</b>

     These routines extract type, size, and content information from
     [protected sqlite3_value] objects.  Protected sqlite3_value objects
     are used to pass parameter information into implementation of
     [application-defined SQL functions] and [virtual tables].

     These routines work only with [protected sqlite3_value] objects.
     Any attempt to use these routines on an [unprotected sqlite3_value]
     is not threadsafe.

     ^These routines work just like the corresponding [column access functions]
     except that these routines take a single [protected sqlite3_value] object
     pointer instead of a [sqlite3_stmt*] pointer and an integer column number.

     ^The sqlite3_value_text16() interface extracts a UTF-16 string
     in the native byte-order of the host machine.  ^The
     sqlite3_value_text16be() and sqlite3_value_text16le() interfaces
     extract UTF-16 strings as big-endian and little-endian respectively.

     ^If [sqlite3_value] object V was initialized
     using [sqlite3_bind_pointer(S,I,P,X,D)] or [sqlite3_result_pointer(C,P,X,D)]
     and if X and Y are strings that compare equal according to strcmp(X,Y),
     then sqlite3_value_pointer(V,Y) will return the pointer P.  ^Otherwise,
     sqlite3_value_pointer(V,Y) returns a NULL. The sqlite3_bind_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     ^(The sqlite3_value_type(V) interface returns the
     [SQLITE_INTEGER | datatype code] for the initial datatype of the
     [sqlite3_value] object V. The returned value is one of [SQLITE_INTEGER],
     [SQLITE_FLOAT], [SQLITE_TEXT], [SQLITE_BLOB], or [SQLITE_NULL].)^
     Other interfaces might change the datatype for an sqlite3_value object.
     For example, if the datatype is initially SQLITE_INTEGER and
     sqlite3_value_text(V) is called to extract a text value for that
     integer, then subsequent calls to sqlite3_value_type(V) might return
     SQLITE_TEXT.  Whether or not a persistent internal datatype conversion
     occurs is undefined and may change from one release of SQLite to the next.

     ^(The sqlite3_value_numeric_type() interface attempts to apply
     numeric affinity to the value.  This means that an attempt is
     made to convert the value to an integer or floating point.  If
     such a conversion is possible without loss of information (in other
     words, if the value is a string that looks like a number)
     then the conversion is performed.  Otherwise no conversion occurs.
     The [SQLITE_INTEGER | datatype] after conversion is returned.)^

     ^Within the [xUpdate] method of a [virtual table], the
     sqlite3_value_nochange(X) interface returns true if and only if
     the column corresponding to X is unchanged by the UPDATE operation
     that the xUpdate method call was invoked to implement and if
     and the prior [xColumn] method call that was invoked to extracted
     the value for that column returned without setting a result (probably
     because it queried [sqlite3_vtab_nochange()] and found that the column
     was unchanging).  ^Within an [xUpdate] method, any value for which
     sqlite3_value_nochange(X) is true will in all other respects appear
     to be a NULL value.  If sqlite3_value_nochange(X) is invoked anywhere other
     than within an [xUpdate] method call for an UPDATE statement, then
     the return value is arbitrary and meaningless.

     ^The sqlite3_value_frombind(X) interface returns non-zero if the
     value X originated from one of the [sqlite3_bind_int|sqlite3_bind()]
     interfaces.  ^If X comes from an SQL literal value, or a table column,
     and expression, then sqlite3_value_frombind(X) returns zero.

     Please pay particular attention to the fact that the pointer returned
     from [sqlite3_value_blob()], [sqlite3_value_text()], or
     [sqlite3_value_text16()] can be invalidated by a subsequent call to
     [sqlite3_value_bytes()], [sqlite3_value_bytes16()], [sqlite3_value_text()],
     or [sqlite3_value_text16()].

     These routines must be called from the same thread as
     the SQL function that supplied the [sqlite3_value*] parameters.

     As long as the input parameter is correct, these routines can only
     fail if an out-of-memory error occurs during a format conversion.
     Only the following subset of interfaces are subject to out-of-memory
     errors:

     <ul>
     <li> sqlite3_value_blob()
     <li> sqlite3_value_text()
     <li> sqlite3_value_text16()
     <li> sqlite3_value_text16le()
     <li> sqlite3_value_text16be()
     <li> sqlite3_value_bytes()
     <li> sqlite3_value_bytes16()
     </ul>

     If an out-of-memory error occurs, then the return value from these
     routines is the same as if the column had contained an SQL NULL value.
     Valid SQL NULL returns can be distinguished from out-of-memory errors
     by invoking the [sqlite3_errcode()] immediately after the suspect
     return value is obtained and before any
     other SQLite interface is called on the same [database connection].
    */
    @inlinable public var int64: sqlite3_int64 {
        sqlite3_value_int64(rawValue)
    }

    /**
     CAPI3REF: Obtaining SQL Values
     METHOD: sqlite3_value

     <b>Summary:</b>
     <blockquote><table border=0 cellpadding=0 cellspacing=0>
     <tr><td><b>sqlite3_value_blob</b><td>&rarr;<td>BLOB value
     <tr><td><b>sqlite3_value_double</b><td>&rarr;<td>REAL value
     <tr><td><b>sqlite3_value_int</b><td>&rarr;<td>32-bit INTEGER value
     <tr><td><b>sqlite3_value_int64</b><td>&rarr;<td>64-bit INTEGER value
     <tr><td><b>sqlite3_value_pointer</b><td>&rarr;<td>Pointer value
     <tr><td><b>sqlite3_value_text</b><td>&rarr;<td>UTF-8 TEXT value
     <tr><td><b>sqlite3_value_text16</b><td>&rarr;<td>UTF-16 TEXT value in
     the native byteorder
     <tr><td><b>sqlite3_value_text16be</b><td>&rarr;<td>UTF-16be TEXT value
     <tr><td><b>sqlite3_value_text16le</b><td>&rarr;<td>UTF-16le TEXT value
     <tr><td>&nbsp;<td>&nbsp;<td>&nbsp;
     <tr><td><b>sqlite3_value_bytes</b><td>&rarr;<td>Size of a BLOB
     or a UTF-8 TEXT in bytes
     <tr><td><b>sqlite3_value_bytes16&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>Size of UTF-16
     TEXT in bytes
     <tr><td><b>sqlite3_value_type</b><td>&rarr;<td>Default
     datatype of the value
     <tr><td><b>sqlite3_value_numeric_type&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>Best numeric datatype of the value
     <tr><td><b>sqlite3_value_nochange&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>True if the column is unchanged in an UPDATE
     against a virtual table.
     <tr><td><b>sqlite3_value_frombind&nbsp;&nbsp;</b>
     <td>&rarr;&nbsp;&nbsp;<td>True if value originated from a [bound parameter]
     </table></blockquote>

     <b>Details:</b>

     These routines extract type, size, and content information from
     [protected sqlite3_value] objects.  Protected sqlite3_value objects
     are used to pass parameter information into implementation of
     [application-defined SQL functions] and [virtual tables].

     These routines work only with [protected sqlite3_value] objects.
     Any attempt to use these routines on an [unprotected sqlite3_value]
     is not threadsafe.

     ^These routines work just like the corresponding [column access functions]
     except that these routines take a single [protected sqlite3_value] object
     pointer instead of a [sqlite3_stmt*] pointer and an integer column number.

     ^The sqlite3_value_text16() interface extracts a UTF-16 string
     in the native byte-order of the host machine.  ^The
     sqlite3_value_text16be() and sqlite3_value_text16le() interfaces
     extract UTF-16 strings as big-endian and little-endian respectively.

     ^If [sqlite3_value] object V was initialized
     using [sqlite3_bind_pointer(S,I,P,X,D)] or [sqlite3_result_pointer(C,P,X,D)]
     and if X and Y are strings that compare equal according to strcmp(X,Y),
     then sqlite3_value_pointer(V,Y) will return the pointer P.  ^Otherwise,
     sqlite3_value_pointer(V,Y) returns a NULL. The sqlite3_bind_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     ^(The sqlite3_value_type(V) interface returns the
     [SQLITE_INTEGER | datatype code] for the initial datatype of the
     [sqlite3_value] object V. The returned value is one of [SQLITE_INTEGER],
     [SQLITE_FLOAT], [SQLITE_TEXT], [SQLITE_BLOB], or [SQLITE_NULL].)^
     Other interfaces might change the datatype for an sqlite3_value object.
     For example, if the datatype is initially SQLITE_INTEGER and
     sqlite3_value_text(V) is called to extract a text value for that
     integer, then subsequent calls to sqlite3_value_type(V) might return
     SQLITE_TEXT.  Whether or not a persistent internal datatype conversion
     occurs is undefined and may change from one release of SQLite to the next.

     ^(The sqlite3_value_numeric_type() interface attempts to apply
     numeric affinity to the value.  This means that an attempt is
     made to convert the value to an integer or floating point.  If
     such a conversion is possible without loss of information (in other
     words, if the value is a string that looks like a number)
     then the conversion is performed.  Otherwise no conversion occurs.
     The [SQLITE_INTEGER | datatype] after conversion is returned.)^

     ^Within the [xUpdate] method of a [virtual table], the
     sqlite3_value_nochange(X) interface returns true if and only if
     the column corresponding to X is unchanged by the UPDATE operation
     that the xUpdate method call was invoked to implement and if
     and the prior [xColumn] method call that was invoked to extracted
     the value for that column returned without setting a result (probably
     because it queried [sqlite3_vtab_nochange()] and found that the column
     was unchanging).  ^Within an [xUpdate] method, any value for which
     sqlite3_value_nochange(X) is true will in all other respects appear
     to be a NULL value.  If sqlite3_value_nochange(X) is invoked anywhere other
     than within an [xUpdate] method call for an UPDATE statement, then
     the return value is arbitrary and meaningless.

     ^The sqlite3_value_frombind(X) interface returns non-zero if the
     value X originated from one of the [sqlite3_bind_int|sqlite3_bind()]
     interfaces.  ^If X comes from an SQL literal value, or a table column,
     and expression, then sqlite3_value_frombind(X) returns zero.

     Please pay particular attention to the fact that the pointer returned
     from [sqlite3_value_blob()], [sqlite3_value_text()], or
     [sqlite3_value_text16()] can be invalidated by a subsequent call to
     [sqlite3_value_bytes()], [sqlite3_value_bytes16()], [sqlite3_value_text()],
     or [sqlite3_value_text16()].

     These routines must be called from the same thread as
     the SQL function that supplied the [sqlite3_value*] parameters.

     As long as the input parameter is correct, these routines can only
     fail if an out-of-memory error occurs during a format conversion.
     Only the following subset of interfaces are subject to out-of-memory
     errors:

     <ul>
     <li> sqlite3_value_blob()
     <li> sqlite3_value_text()
     <li> sqlite3_value_text16()
     <li> sqlite3_value_text16le()
     <li> sqlite3_value_text16be()
     <li> sqlite3_value_bytes()
     <li> sqlite3_value_bytes16()
     </ul>

     If an out-of-memory error occurs, then the return value from these
     routines is the same as if the column had contained an SQL NULL value.
     Valid SQL NULL returns can be distinguished from out-of-memory errors
     by invoking the [sqlite3_errcode()] immediately after the suspect
     return value is obtained and before any
     other SQLite interface is called on the same [database connection].
    */
    @inlinable public var text: UnsafePointer<UInt8>? {
        sqlite3_value_text(rawValue)
    }
}
