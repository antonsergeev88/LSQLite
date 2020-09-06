import MissedSwiftSQLite
import MissedSwiftSQLite

extension Statement {
    public typealias BindBlobDestructor = @convention(c) (_ blob: UnsafeMutableRawPointer?) -> Void
    public typealias BindTextDestructor = @convention(c) (_ text: UnsafeMutableRawPointer?) -> Void

    /**
     CAPI3REF: Binding Values To Prepared Statements
     KEYWORDS: {host parameter} {host parameters} {host parameter name}
     KEYWORDS: {SQL parameter} {SQL parameters} {parameter binding}
     METHOD: sqlite3_stmt

     ^(In the SQL statement text input to [sqlite3_prepare_v2()] and its variants,
     literals may be replaced by a [parameter] that matches one of following
     templates:

     <ul>
     <li>  ?
     <li>  ?NNN
     <li>  :VVV
     <li>  @VVV
     <li>  $VVV
     </ul>

     In the templates above, NNN represents an integer literal,
     and VVV represents an alphanumeric identifier.)^  ^The values of these
     parameters (also called "host parameter names" or "SQL parameters")
     can be set using the sqlite3_bind_*() routines defined here.

     ^The first argument to the sqlite3_bind_*() routines is always
     a pointer to the [sqlite3_stmt] object returned from
     [sqlite3_prepare_v2()] or its variants.

     ^The second argument is the index of the SQL parameter to be set.
     ^The leftmost SQL parameter has an index of 1.  ^When the same named
     SQL parameter is used more than once, second and subsequent
     occurrences have the same index as the first occurrence.
     ^The index for named parameters can be looked up using the
     [sqlite3_bind_parameter_index()] API if desired.  ^The index
     for "?NNN" parameters is the value of NNN.
     ^The NNN value must be between 1 and the [sqlite3_limit()]
     parameter [SQLITE_LIMIT_VARIABLE_NUMBER] (default value: 999).

     ^The third argument is the value to bind to the parameter.
     ^If the third parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     or sqlite3_bind_blob() is a NULL pointer then the fourth parameter
     is ignored and the end result is the same as sqlite3_bind_null().

     ^(In those routines that have a fourth argument, its value is the
     number of bytes in the parameter.  To be clear: the value is the
     number of <u>bytes</u> in the value, not the number of characters.)^
     ^If the fourth parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     is negative, then the length of the string is
     the number of bytes up to the first zero terminator.
     If the fourth parameter to sqlite3_bind_blob() is negative, then
     the behavior is undefined.
     If a non-negative fourth parameter is provided to sqlite3_bind_text()
     or sqlite3_bind_text16() or sqlite3_bind_text64() then
     that parameter must be the byte offset
     where the NUL terminator would occur assuming the string were NUL
     terminated.  If any NUL characters occur at byte offsets less than
     the value of the fourth parameter then the resulting string value will
     contain embedded NULs.  The result of expressions involving strings
     with embedded NULs is undefined.

     ^The fifth argument to the BLOB and string binding interfaces
     is a destructor used to dispose of the BLOB or
     string after SQLite has finished with it.  ^The destructor is called
     to dispose of the BLOB or string even if the call to the bind API fails,
     except the destructor is not called if the third parameter is a NULL
     pointer or the fourth parameter is negative.
     ^If the fifth argument is
     the special value [SQLITE_STATIC], then SQLite assumes that the
     information is in static, unmanaged space and does not need to be freed.
     ^If the fifth argument has the value [SQLITE_TRANSIENT], then
     SQLite makes its own private copy of the data immediately, before
     the sqlite3_bind_*() routine returns.

     ^The sixth argument to sqlite3_bind_text64() must be one of
     [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE]
     to specify the encoding of the text in the third parameter.  If
     the sixth argument to sqlite3_bind_text64() is not one of the
     allowed values shown above, or if the text encoding is different
     from the encoding specified by the sixth parameter, then the behavior
     is undefined.

     ^The sqlite3_bind_zeroblob() routine binds a BLOB of length N that
     is filled with zeroes.  ^A zeroblob uses a fixed amount of memory
     (just an integer to hold its size) while it is being processed.
     Zeroblobs are intended to serve as placeholders for BLOBs whose
     content is later written using
     [sqlite3_blob_open | incremental BLOB I/O] routines.
     ^A negative value for the zeroblob results in a zero-length BLOB.

     ^The sqlite3_bind_pointer(S,I,P,T,D) routine causes the I-th parameter in
     [prepared statement] S to have an SQL value of NULL, but to also be
     associated with the pointer P of type T.  ^D is either a NULL pointer or
     a pointer to a destructor function for P. ^SQLite will invoke the
     destructor D with a single argument of P when it is finished using
     P.  The T parameter should be a static string, preferably a string
     literal. The sqlite3_bind_pointer() routine is part of the
     [pointer passing interface] added for SQLite 3.20.0.

     ^If any of the sqlite3_bind_*() routines are called with a NULL pointer
     for the [prepared statement] or with a prepared statement for which
     [sqlite3_step()] has been called more recently than [sqlite3_reset()],
     then the call will return [SQLITE_MISUSE].  If any sqlite3_bind_()
     routine is passed a [prepared statement] that has been finalized, the
     result is undefined and probably harmful.

     ^Bindings are not cleared by the [sqlite3_reset()] routine.
     ^Unbound parameters are interpreted as NULL.

     ^The sqlite3_bind_* routines return [SQLITE_OK] on success or an
     [error code] if anything goes wrong.
     ^[SQLITE_TOOBIG] might be returned if the size of a string or BLOB
     exceeds limits imposed by [sqlite3_limit]([SQLITE_LIMIT_LENGTH]) or
     [SQLITE_MAX_LENGTH].
     ^[SQLITE_RANGE] is returned if the parameter
     index is out of range.  ^[SQLITE_NOMEM] is returned if malloc() fails.

     See also: [sqlite3_bind_parameter_count()],
     [sqlite3_bind_parameter_name()], and [sqlite3_bind_parameter_index()].
     */
    @inlinable public func bindBlob(_ blob: UnsafeRawPointer, length: Int32, at index: Int32, destructor: BindBlobDestructor? = nil) -> ResultCode {
        sqlite3_bind_blob(rawValue, index, blob, length, destructor).resultCode
    }

    /**
     CAPI3REF: Binding Values To Prepared Statements
     KEYWORDS: {host parameter} {host parameters} {host parameter name}
     KEYWORDS: {SQL parameter} {SQL parameters} {parameter binding}
     METHOD: sqlite3_stmt

     ^(In the SQL statement text input to [sqlite3_prepare_v2()] and its variants,
     literals may be replaced by a [parameter] that matches one of following
     templates:

     <ul>
     <li>  ?
     <li>  ?NNN
     <li>  :VVV
     <li>  @VVV
     <li>  $VVV
     </ul>

     In the templates above, NNN represents an integer literal,
     and VVV represents an alphanumeric identifier.)^  ^The values of these
     parameters (also called "host parameter names" or "SQL parameters")
     can be set using the sqlite3_bind_*() routines defined here.

     ^The first argument to the sqlite3_bind_*() routines is always
     a pointer to the [sqlite3_stmt] object returned from
     [sqlite3_prepare_v2()] or its variants.

     ^The second argument is the index of the SQL parameter to be set.
     ^The leftmost SQL parameter has an index of 1.  ^When the same named
     SQL parameter is used more than once, second and subsequent
     occurrences have the same index as the first occurrence.
     ^The index for named parameters can be looked up using the
     [sqlite3_bind_parameter_index()] API if desired.  ^The index
     for "?NNN" parameters is the value of NNN.
     ^The NNN value must be between 1 and the [sqlite3_limit()]
     parameter [SQLITE_LIMIT_VARIABLE_NUMBER] (default value: 999).

     ^The third argument is the value to bind to the parameter.
     ^If the third parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     or sqlite3_bind_blob() is a NULL pointer then the fourth parameter
     is ignored and the end result is the same as sqlite3_bind_null().

     ^(In those routines that have a fourth argument, its value is the
     number of bytes in the parameter.  To be clear: the value is the
     number of <u>bytes</u> in the value, not the number of characters.)^
     ^If the fourth parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     is negative, then the length of the string is
     the number of bytes up to the first zero terminator.
     If the fourth parameter to sqlite3_bind_blob() is negative, then
     the behavior is undefined.
     If a non-negative fourth parameter is provided to sqlite3_bind_text()
     or sqlite3_bind_text16() or sqlite3_bind_text64() then
     that parameter must be the byte offset
     where the NUL terminator would occur assuming the string were NUL
     terminated.  If any NUL characters occur at byte offsets less than
     the value of the fourth parameter then the resulting string value will
     contain embedded NULs.  The result of expressions involving strings
     with embedded NULs is undefined.

     ^The fifth argument to the BLOB and string binding interfaces
     is a destructor used to dispose of the BLOB or
     string after SQLite has finished with it.  ^The destructor is called
     to dispose of the BLOB or string even if the call to the bind API fails,
     except the destructor is not called if the third parameter is a NULL
     pointer or the fourth parameter is negative.
     ^If the fifth argument is
     the special value [SQLITE_STATIC], then SQLite assumes that the
     information is in static, unmanaged space and does not need to be freed.
     ^If the fifth argument has the value [SQLITE_TRANSIENT], then
     SQLite makes its own private copy of the data immediately, before
     the sqlite3_bind_*() routine returns.

     ^The sixth argument to sqlite3_bind_text64() must be one of
     [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE]
     to specify the encoding of the text in the third parameter.  If
     the sixth argument to sqlite3_bind_text64() is not one of the
     allowed values shown above, or if the text encoding is different
     from the encoding specified by the sixth parameter, then the behavior
     is undefined.

     ^The sqlite3_bind_zeroblob() routine binds a BLOB of length N that
     is filled with zeroes.  ^A zeroblob uses a fixed amount of memory
     (just an integer to hold its size) while it is being processed.
     Zeroblobs are intended to serve as placeholders for BLOBs whose
     content is later written using
     [sqlite3_blob_open | incremental BLOB I/O] routines.
     ^A negative value for the zeroblob results in a zero-length BLOB.

     ^The sqlite3_bind_pointer(S,I,P,T,D) routine causes the I-th parameter in
     [prepared statement] S to have an SQL value of NULL, but to also be
     associated with the pointer P of type T.  ^D is either a NULL pointer or
     a pointer to a destructor function for P. ^SQLite will invoke the
     destructor D with a single argument of P when it is finished using
     P.  The T parameter should be a static string, preferably a string
     literal. The sqlite3_bind_pointer() routine is part of the
     [pointer passing interface] added for SQLite 3.20.0.

     ^If any of the sqlite3_bind_*() routines are called with a NULL pointer
     for the [prepared statement] or with a prepared statement for which
     [sqlite3_step()] has been called more recently than [sqlite3_reset()],
     then the call will return [SQLITE_MISUSE].  If any sqlite3_bind_()
     routine is passed a [prepared statement] that has been finalized, the
     result is undefined and probably harmful.

     ^Bindings are not cleared by the [sqlite3_reset()] routine.
     ^Unbound parameters are interpreted as NULL.

     ^The sqlite3_bind_* routines return [SQLITE_OK] on success or an
     [error code] if anything goes wrong.
     ^[SQLITE_TOOBIG] might be returned if the size of a string or BLOB
     exceeds limits imposed by [sqlite3_limit]([SQLITE_LIMIT_LENGTH]) or
     [SQLITE_MAX_LENGTH].
     ^[SQLITE_RANGE] is returned if the parameter
     index is out of range.  ^[SQLITE_NOMEM] is returned if malloc() fails.

     See also: [sqlite3_bind_parameter_count()],
     [sqlite3_bind_parameter_name()], and [sqlite3_bind_parameter_index()].
     */
    @inlinable public func bindTransientBlob(_ blob: UnsafeRawPointer, length: Int32, at index: Int32) -> ResultCode {
        lsqlite3_bind_transient_blob(rawValue, index, blob, length).resultCode
    }

    /**
     CAPI3REF: Binding Values To Prepared Statements
     KEYWORDS: {host parameter} {host parameters} {host parameter name}
     KEYWORDS: {SQL parameter} {SQL parameters} {parameter binding}
     METHOD: sqlite3_stmt

     ^(In the SQL statement text input to [sqlite3_prepare_v2()] and its variants,
     literals may be replaced by a [parameter] that matches one of following
     templates:

     <ul>
     <li>  ?
     <li>  ?NNN
     <li>  :VVV
     <li>  @VVV
     <li>  $VVV
     </ul>

     In the templates above, NNN represents an integer literal,
     and VVV represents an alphanumeric identifier.)^  ^The values of these
     parameters (also called "host parameter names" or "SQL parameters")
     can be set using the sqlite3_bind_*() routines defined here.

     ^The first argument to the sqlite3_bind_*() routines is always
     a pointer to the [sqlite3_stmt] object returned from
     [sqlite3_prepare_v2()] or its variants.

     ^The second argument is the index of the SQL parameter to be set.
     ^The leftmost SQL parameter has an index of 1.  ^When the same named
     SQL parameter is used more than once, second and subsequent
     occurrences have the same index as the first occurrence.
     ^The index for named parameters can be looked up using the
     [sqlite3_bind_parameter_index()] API if desired.  ^The index
     for "?NNN" parameters is the value of NNN.
     ^The NNN value must be between 1 and the [sqlite3_limit()]
     parameter [SQLITE_LIMIT_VARIABLE_NUMBER] (default value: 999).

     ^The third argument is the value to bind to the parameter.
     ^If the third parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     or sqlite3_bind_blob() is a NULL pointer then the fourth parameter
     is ignored and the end result is the same as sqlite3_bind_null().

     ^(In those routines that have a fourth argument, its value is the
     number of bytes in the parameter.  To be clear: the value is the
     number of <u>bytes</u> in the value, not the number of characters.)^
     ^If the fourth parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     is negative, then the length of the string is
     the number of bytes up to the first zero terminator.
     If the fourth parameter to sqlite3_bind_blob() is negative, then
     the behavior is undefined.
     If a non-negative fourth parameter is provided to sqlite3_bind_text()
     or sqlite3_bind_text16() or sqlite3_bind_text64() then
     that parameter must be the byte offset
     where the NUL terminator would occur assuming the string were NUL
     terminated.  If any NUL characters occur at byte offsets less than
     the value of the fourth parameter then the resulting string value will
     contain embedded NULs.  The result of expressions involving strings
     with embedded NULs is undefined.

     ^The fifth argument to the BLOB and string binding interfaces
     is a destructor used to dispose of the BLOB or
     string after SQLite has finished with it.  ^The destructor is called
     to dispose of the BLOB or string even if the call to the bind API fails,
     except the destructor is not called if the third parameter is a NULL
     pointer or the fourth parameter is negative.
     ^If the fifth argument is
     the special value [SQLITE_STATIC], then SQLite assumes that the
     information is in static, unmanaged space and does not need to be freed.
     ^If the fifth argument has the value [SQLITE_TRANSIENT], then
     SQLite makes its own private copy of the data immediately, before
     the sqlite3_bind_*() routine returns.

     ^The sixth argument to sqlite3_bind_text64() must be one of
     [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE]
     to specify the encoding of the text in the third parameter.  If
     the sixth argument to sqlite3_bind_text64() is not one of the
     allowed values shown above, or if the text encoding is different
     from the encoding specified by the sixth parameter, then the behavior
     is undefined.

     ^The sqlite3_bind_zeroblob() routine binds a BLOB of length N that
     is filled with zeroes.  ^A zeroblob uses a fixed amount of memory
     (just an integer to hold its size) while it is being processed.
     Zeroblobs are intended to serve as placeholders for BLOBs whose
     content is later written using
     [sqlite3_blob_open | incremental BLOB I/O] routines.
     ^A negative value for the zeroblob results in a zero-length BLOB.

     ^The sqlite3_bind_pointer(S,I,P,T,D) routine causes the I-th parameter in
     [prepared statement] S to have an SQL value of NULL, but to also be
     associated with the pointer P of type T.  ^D is either a NULL pointer or
     a pointer to a destructor function for P. ^SQLite will invoke the
     destructor D with a single argument of P when it is finished using
     P.  The T parameter should be a static string, preferably a string
     literal. The sqlite3_bind_pointer() routine is part of the
     [pointer passing interface] added for SQLite 3.20.0.

     ^If any of the sqlite3_bind_*() routines are called with a NULL pointer
     for the [prepared statement] or with a prepared statement for which
     [sqlite3_step()] has been called more recently than [sqlite3_reset()],
     then the call will return [SQLITE_MISUSE].  If any sqlite3_bind_()
     routine is passed a [prepared statement] that has been finalized, the
     result is undefined and probably harmful.

     ^Bindings are not cleared by the [sqlite3_reset()] routine.
     ^Unbound parameters are interpreted as NULL.

     ^The sqlite3_bind_* routines return [SQLITE_OK] on success or an
     [error code] if anything goes wrong.
     ^[SQLITE_TOOBIG] might be returned if the size of a string or BLOB
     exceeds limits imposed by [sqlite3_limit]([SQLITE_LIMIT_LENGTH]) or
     [SQLITE_MAX_LENGTH].
     ^[SQLITE_RANGE] is returned if the parameter
     index is out of range.  ^[SQLITE_NOMEM] is returned if malloc() fails.

     See also: [sqlite3_bind_parameter_count()],
     [sqlite3_bind_parameter_name()], and [sqlite3_bind_parameter_index()].
     */
    @inlinable public func bindStaticBlob(_ blob: UnsafeRawPointer, length: Int32, at index: Int32) -> ResultCode {
        lsqlite3_bind_static_blob(rawValue, index, blob, length).resultCode
    }

    /**
     CAPI3REF: Binding Values To Prepared Statements
     KEYWORDS: {host parameter} {host parameters} {host parameter name}
     KEYWORDS: {SQL parameter} {SQL parameters} {parameter binding}
     METHOD: sqlite3_stmt

     ^(In the SQL statement text input to [sqlite3_prepare_v2()] and its variants,
     literals may be replaced by a [parameter] that matches one of following
     templates:

     <ul>
     <li>  ?
     <li>  ?NNN
     <li>  :VVV
     <li>  @VVV
     <li>  $VVV
     </ul>

     In the templates above, NNN represents an integer literal,
     and VVV represents an alphanumeric identifier.)^  ^The values of these
     parameters (also called "host parameter names" or "SQL parameters")
     can be set using the sqlite3_bind_*() routines defined here.

     ^The first argument to the sqlite3_bind_*() routines is always
     a pointer to the [sqlite3_stmt] object returned from
     [sqlite3_prepare_v2()] or its variants.

     ^The second argument is the index of the SQL parameter to be set.
     ^The leftmost SQL parameter has an index of 1.  ^When the same named
     SQL parameter is used more than once, second and subsequent
     occurrences have the same index as the first occurrence.
     ^The index for named parameters can be looked up using the
     [sqlite3_bind_parameter_index()] API if desired.  ^The index
     for "?NNN" parameters is the value of NNN.
     ^The NNN value must be between 1 and the [sqlite3_limit()]
     parameter [SQLITE_LIMIT_VARIABLE_NUMBER] (default value: 999).

     ^The third argument is the value to bind to the parameter.
     ^If the third parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     or sqlite3_bind_blob() is a NULL pointer then the fourth parameter
     is ignored and the end result is the same as sqlite3_bind_null().

     ^(In those routines that have a fourth argument, its value is the
     number of bytes in the parameter.  To be clear: the value is the
     number of <u>bytes</u> in the value, not the number of characters.)^
     ^If the fourth parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     is negative, then the length of the string is
     the number of bytes up to the first zero terminator.
     If the fourth parameter to sqlite3_bind_blob() is negative, then
     the behavior is undefined.
     If a non-negative fourth parameter is provided to sqlite3_bind_text()
     or sqlite3_bind_text16() or sqlite3_bind_text64() then
     that parameter must be the byte offset
     where the NUL terminator would occur assuming the string were NUL
     terminated.  If any NUL characters occur at byte offsets less than
     the value of the fourth parameter then the resulting string value will
     contain embedded NULs.  The result of expressions involving strings
     with embedded NULs is undefined.

     ^The fifth argument to the BLOB and string binding interfaces
     is a destructor used to dispose of the BLOB or
     string after SQLite has finished with it.  ^The destructor is called
     to dispose of the BLOB or string even if the call to the bind API fails,
     except the destructor is not called if the third parameter is a NULL
     pointer or the fourth parameter is negative.
     ^If the fifth argument is
     the special value [SQLITE_STATIC], then SQLite assumes that the
     information is in static, unmanaged space and does not need to be freed.
     ^If the fifth argument has the value [SQLITE_TRANSIENT], then
     SQLite makes its own private copy of the data immediately, before
     the sqlite3_bind_*() routine returns.

     ^The sixth argument to sqlite3_bind_text64() must be one of
     [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE]
     to specify the encoding of the text in the third parameter.  If
     the sixth argument to sqlite3_bind_text64() is not one of the
     allowed values shown above, or if the text encoding is different
     from the encoding specified by the sixth parameter, then the behavior
     is undefined.

     ^The sqlite3_bind_zeroblob() routine binds a BLOB of length N that
     is filled with zeroes.  ^A zeroblob uses a fixed amount of memory
     (just an integer to hold its size) while it is being processed.
     Zeroblobs are intended to serve as placeholders for BLOBs whose
     content is later written using
     [sqlite3_blob_open | incremental BLOB I/O] routines.
     ^A negative value for the zeroblob results in a zero-length BLOB.

     ^The sqlite3_bind_pointer(S,I,P,T,D) routine causes the I-th parameter in
     [prepared statement] S to have an SQL value of NULL, but to also be
     associated with the pointer P of type T.  ^D is either a NULL pointer or
     a pointer to a destructor function for P. ^SQLite will invoke the
     destructor D with a single argument of P when it is finished using
     P.  The T parameter should be a static string, preferably a string
     literal. The sqlite3_bind_pointer() routine is part of the
     [pointer passing interface] added for SQLite 3.20.0.

     ^If any of the sqlite3_bind_*() routines are called with a NULL pointer
     for the [prepared statement] or with a prepared statement for which
     [sqlite3_step()] has been called more recently than [sqlite3_reset()],
     then the call will return [SQLITE_MISUSE].  If any sqlite3_bind_()
     routine is passed a [prepared statement] that has been finalized, the
     result is undefined and probably harmful.

     ^Bindings are not cleared by the [sqlite3_reset()] routine.
     ^Unbound parameters are interpreted as NULL.

     ^The sqlite3_bind_* routines return [SQLITE_OK] on success or an
     [error code] if anything goes wrong.
     ^[SQLITE_TOOBIG] might be returned if the size of a string or BLOB
     exceeds limits imposed by [sqlite3_limit]([SQLITE_LIMIT_LENGTH]) or
     [SQLITE_MAX_LENGTH].
     ^[SQLITE_RANGE] is returned if the parameter
     index is out of range.  ^[SQLITE_NOMEM] is returned if malloc() fails.

     See also: [sqlite3_bind_parameter_count()],
     [sqlite3_bind_parameter_name()], and [sqlite3_bind_parameter_index()].
     */
    @inlinable public func bindDouble(_ double: Double, at index: Int32) -> ResultCode {
        sqlite3_bind_double(rawValue, index, double).resultCode
    }

    /**
     CAPI3REF: Binding Values To Prepared Statements
     KEYWORDS: {host parameter} {host parameters} {host parameter name}
     KEYWORDS: {SQL parameter} {SQL parameters} {parameter binding}
     METHOD: sqlite3_stmt

     ^(In the SQL statement text input to [sqlite3_prepare_v2()] and its variants,
     literals may be replaced by a [parameter] that matches one of following
     templates:

     <ul>
     <li>  ?
     <li>  ?NNN
     <li>  :VVV
     <li>  @VVV
     <li>  $VVV
     </ul>

     In the templates above, NNN represents an integer literal,
     and VVV represents an alphanumeric identifier.)^  ^The values of these
     parameters (also called "host parameter names" or "SQL parameters")
     can be set using the sqlite3_bind_*() routines defined here.

     ^The first argument to the sqlite3_bind_*() routines is always
     a pointer to the [sqlite3_stmt] object returned from
     [sqlite3_prepare_v2()] or its variants.

     ^The second argument is the index of the SQL parameter to be set.
     ^The leftmost SQL parameter has an index of 1.  ^When the same named
     SQL parameter is used more than once, second and subsequent
     occurrences have the same index as the first occurrence.
     ^The index for named parameters can be looked up using the
     [sqlite3_bind_parameter_index()] API if desired.  ^The index
     for "?NNN" parameters is the value of NNN.
     ^The NNN value must be between 1 and the [sqlite3_limit()]
     parameter [SQLITE_LIMIT_VARIABLE_NUMBER] (default value: 999).

     ^The third argument is the value to bind to the parameter.
     ^If the third parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     or sqlite3_bind_blob() is a NULL pointer then the fourth parameter
     is ignored and the end result is the same as sqlite3_bind_null().

     ^(In those routines that have a fourth argument, its value is the
     number of bytes in the parameter.  To be clear: the value is the
     number of <u>bytes</u> in the value, not the number of characters.)^
     ^If the fourth parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     is negative, then the length of the string is
     the number of bytes up to the first zero terminator.
     If the fourth parameter to sqlite3_bind_blob() is negative, then
     the behavior is undefined.
     If a non-negative fourth parameter is provided to sqlite3_bind_text()
     or sqlite3_bind_text16() or sqlite3_bind_text64() then
     that parameter must be the byte offset
     where the NUL terminator would occur assuming the string were NUL
     terminated.  If any NUL characters occur at byte offsets less than
     the value of the fourth parameter then the resulting string value will
     contain embedded NULs.  The result of expressions involving strings
     with embedded NULs is undefined.

     ^The fifth argument to the BLOB and string binding interfaces
     is a destructor used to dispose of the BLOB or
     string after SQLite has finished with it.  ^The destructor is called
     to dispose of the BLOB or string even if the call to the bind API fails,
     except the destructor is not called if the third parameter is a NULL
     pointer or the fourth parameter is negative.
     ^If the fifth argument is
     the special value [SQLITE_STATIC], then SQLite assumes that the
     information is in static, unmanaged space and does not need to be freed.
     ^If the fifth argument has the value [SQLITE_TRANSIENT], then
     SQLite makes its own private copy of the data immediately, before
     the sqlite3_bind_*() routine returns.

     ^The sixth argument to sqlite3_bind_text64() must be one of
     [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE]
     to specify the encoding of the text in the third parameter.  If
     the sixth argument to sqlite3_bind_text64() is not one of the
     allowed values shown above, or if the text encoding is different
     from the encoding specified by the sixth parameter, then the behavior
     is undefined.

     ^The sqlite3_bind_zeroblob() routine binds a BLOB of length N that
     is filled with zeroes.  ^A zeroblob uses a fixed amount of memory
     (just an integer to hold its size) while it is being processed.
     Zeroblobs are intended to serve as placeholders for BLOBs whose
     content is later written using
     [sqlite3_blob_open | incremental BLOB I/O] routines.
     ^A negative value for the zeroblob results in a zero-length BLOB.

     ^The sqlite3_bind_pointer(S,I,P,T,D) routine causes the I-th parameter in
     [prepared statement] S to have an SQL value of NULL, but to also be
     associated with the pointer P of type T.  ^D is either a NULL pointer or
     a pointer to a destructor function for P. ^SQLite will invoke the
     destructor D with a single argument of P when it is finished using
     P.  The T parameter should be a static string, preferably a string
     literal. The sqlite3_bind_pointer() routine is part of the
     [pointer passing interface] added for SQLite 3.20.0.

     ^If any of the sqlite3_bind_*() routines are called with a NULL pointer
     for the [prepared statement] or with a prepared statement for which
     [sqlite3_step()] has been called more recently than [sqlite3_reset()],
     then the call will return [SQLITE_MISUSE].  If any sqlite3_bind_()
     routine is passed a [prepared statement] that has been finalized, the
     result is undefined and probably harmful.

     ^Bindings are not cleared by the [sqlite3_reset()] routine.
     ^Unbound parameters are interpreted as NULL.

     ^The sqlite3_bind_* routines return [SQLITE_OK] on success or an
     [error code] if anything goes wrong.
     ^[SQLITE_TOOBIG] might be returned if the size of a string or BLOB
     exceeds limits imposed by [sqlite3_limit]([SQLITE_LIMIT_LENGTH]) or
     [SQLITE_MAX_LENGTH].
     ^[SQLITE_RANGE] is returned if the parameter
     index is out of range.  ^[SQLITE_NOMEM] is returned if malloc() fails.

     See also: [sqlite3_bind_parameter_count()],
     [sqlite3_bind_parameter_name()], and [sqlite3_bind_parameter_index()].
     */
    @inlinable public func bindInt(_ int: Int32, at index: Int32) -> ResultCode {
        sqlite3_bind_int(rawValue, index, int).resultCode
    }

    /**
     CAPI3REF: Binding Values To Prepared Statements
     KEYWORDS: {host parameter} {host parameters} {host parameter name}
     KEYWORDS: {SQL parameter} {SQL parameters} {parameter binding}
     METHOD: sqlite3_stmt

     ^(In the SQL statement text input to [sqlite3_prepare_v2()] and its variants,
     literals may be replaced by a [parameter] that matches one of following
     templates:

     <ul>
     <li>  ?
     <li>  ?NNN
     <li>  :VVV
     <li>  @VVV
     <li>  $VVV
     </ul>

     In the templates above, NNN represents an integer literal,
     and VVV represents an alphanumeric identifier.)^  ^The values of these
     parameters (also called "host parameter names" or "SQL parameters")
     can be set using the sqlite3_bind_*() routines defined here.

     ^The first argument to the sqlite3_bind_*() routines is always
     a pointer to the [sqlite3_stmt] object returned from
     [sqlite3_prepare_v2()] or its variants.

     ^The second argument is the index of the SQL parameter to be set.
     ^The leftmost SQL parameter has an index of 1.  ^When the same named
     SQL parameter is used more than once, second and subsequent
     occurrences have the same index as the first occurrence.
     ^The index for named parameters can be looked up using the
     [sqlite3_bind_parameter_index()] API if desired.  ^The index
     for "?NNN" parameters is the value of NNN.
     ^The NNN value must be between 1 and the [sqlite3_limit()]
     parameter [SQLITE_LIMIT_VARIABLE_NUMBER] (default value: 999).

     ^The third argument is the value to bind to the parameter.
     ^If the third parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     or sqlite3_bind_blob() is a NULL pointer then the fourth parameter
     is ignored and the end result is the same as sqlite3_bind_null().

     ^(In those routines that have a fourth argument, its value is the
     number of bytes in the parameter.  To be clear: the value is the
     number of <u>bytes</u> in the value, not the number of characters.)^
     ^If the fourth parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     is negative, then the length of the string is
     the number of bytes up to the first zero terminator.
     If the fourth parameter to sqlite3_bind_blob() is negative, then
     the behavior is undefined.
     If a non-negative fourth parameter is provided to sqlite3_bind_text()
     or sqlite3_bind_text16() or sqlite3_bind_text64() then
     that parameter must be the byte offset
     where the NUL terminator would occur assuming the string were NUL
     terminated.  If any NUL characters occur at byte offsets less than
     the value of the fourth parameter then the resulting string value will
     contain embedded NULs.  The result of expressions involving strings
     with embedded NULs is undefined.

     ^The fifth argument to the BLOB and string binding interfaces
     is a destructor used to dispose of the BLOB or
     string after SQLite has finished with it.  ^The destructor is called
     to dispose of the BLOB or string even if the call to the bind API fails,
     except the destructor is not called if the third parameter is a NULL
     pointer or the fourth parameter is negative.
     ^If the fifth argument is
     the special value [SQLITE_STATIC], then SQLite assumes that the
     information is in static, unmanaged space and does not need to be freed.
     ^If the fifth argument has the value [SQLITE_TRANSIENT], then
     SQLite makes its own private copy of the data immediately, before
     the sqlite3_bind_*() routine returns.

     ^The sixth argument to sqlite3_bind_text64() must be one of
     [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE]
     to specify the encoding of the text in the third parameter.  If
     the sixth argument to sqlite3_bind_text64() is not one of the
     allowed values shown above, or if the text encoding is different
     from the encoding specified by the sixth parameter, then the behavior
     is undefined.

     ^The sqlite3_bind_zeroblob() routine binds a BLOB of length N that
     is filled with zeroes.  ^A zeroblob uses a fixed amount of memory
     (just an integer to hold its size) while it is being processed.
     Zeroblobs are intended to serve as placeholders for BLOBs whose
     content is later written using
     [sqlite3_blob_open | incremental BLOB I/O] routines.
     ^A negative value for the zeroblob results in a zero-length BLOB.

     ^The sqlite3_bind_pointer(S,I,P,T,D) routine causes the I-th parameter in
     [prepared statement] S to have an SQL value of NULL, but to also be
     associated with the pointer P of type T.  ^D is either a NULL pointer or
     a pointer to a destructor function for P. ^SQLite will invoke the
     destructor D with a single argument of P when it is finished using
     P.  The T parameter should be a static string, preferably a string
     literal. The sqlite3_bind_pointer() routine is part of the
     [pointer passing interface] added for SQLite 3.20.0.

     ^If any of the sqlite3_bind_*() routines are called with a NULL pointer
     for the [prepared statement] or with a prepared statement for which
     [sqlite3_step()] has been called more recently than [sqlite3_reset()],
     then the call will return [SQLITE_MISUSE].  If any sqlite3_bind_()
     routine is passed a [prepared statement] that has been finalized, the
     result is undefined and probably harmful.

     ^Bindings are not cleared by the [sqlite3_reset()] routine.
     ^Unbound parameters are interpreted as NULL.

     ^The sqlite3_bind_* routines return [SQLITE_OK] on success or an
     [error code] if anything goes wrong.
     ^[SQLITE_TOOBIG] might be returned if the size of a string or BLOB
     exceeds limits imposed by [sqlite3_limit]([SQLITE_LIMIT_LENGTH]) or
     [SQLITE_MAX_LENGTH].
     ^[SQLITE_RANGE] is returned if the parameter
     index is out of range.  ^[SQLITE_NOMEM] is returned if malloc() fails.

     See also: [sqlite3_bind_parameter_count()],
     [sqlite3_bind_parameter_name()], and [sqlite3_bind_parameter_index()].
     */
    @inlinable public func bindInt64(_ int: sqlite3_int64, at index: Int32) -> ResultCode {
        sqlite3_bind_int64(rawValue, index, int).resultCode
    }

    /**
     CAPI3REF: Binding Values To Prepared Statements
     KEYWORDS: {host parameter} {host parameters} {host parameter name}
     KEYWORDS: {SQL parameter} {SQL parameters} {parameter binding}
     METHOD: sqlite3_stmt

     ^(In the SQL statement text input to [sqlite3_prepare_v2()] and its variants,
     literals may be replaced by a [parameter] that matches one of following
     templates:

     <ul>
     <li>  ?
     <li>  ?NNN
     <li>  :VVV
     <li>  @VVV
     <li>  $VVV
     </ul>

     In the templates above, NNN represents an integer literal,
     and VVV represents an alphanumeric identifier.)^  ^The values of these
     parameters (also called "host parameter names" or "SQL parameters")
     can be set using the sqlite3_bind_*() routines defined here.

     ^The first argument to the sqlite3_bind_*() routines is always
     a pointer to the [sqlite3_stmt] object returned from
     [sqlite3_prepare_v2()] or its variants.

     ^The second argument is the index of the SQL parameter to be set.
     ^The leftmost SQL parameter has an index of 1.  ^When the same named
     SQL parameter is used more than once, second and subsequent
     occurrences have the same index as the first occurrence.
     ^The index for named parameters can be looked up using the
     [sqlite3_bind_parameter_index()] API if desired.  ^The index
     for "?NNN" parameters is the value of NNN.
     ^The NNN value must be between 1 and the [sqlite3_limit()]
     parameter [SQLITE_LIMIT_VARIABLE_NUMBER] (default value: 999).

     ^The third argument is the value to bind to the parameter.
     ^If the third parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     or sqlite3_bind_blob() is a NULL pointer then the fourth parameter
     is ignored and the end result is the same as sqlite3_bind_null().

     ^(In those routines that have a fourth argument, its value is the
     number of bytes in the parameter.  To be clear: the value is the
     number of <u>bytes</u> in the value, not the number of characters.)^
     ^If the fourth parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     is negative, then the length of the string is
     the number of bytes up to the first zero terminator.
     If the fourth parameter to sqlite3_bind_blob() is negative, then
     the behavior is undefined.
     If a non-negative fourth parameter is provided to sqlite3_bind_text()
     or sqlite3_bind_text16() or sqlite3_bind_text64() then
     that parameter must be the byte offset
     where the NUL terminator would occur assuming the string were NUL
     terminated.  If any NUL characters occur at byte offsets less than
     the value of the fourth parameter then the resulting string value will
     contain embedded NULs.  The result of expressions involving strings
     with embedded NULs is undefined.

     ^The fifth argument to the BLOB and string binding interfaces
     is a destructor used to dispose of the BLOB or
     string after SQLite has finished with it.  ^The destructor is called
     to dispose of the BLOB or string even if the call to the bind API fails,
     except the destructor is not called if the third parameter is a NULL
     pointer or the fourth parameter is negative.
     ^If the fifth argument is
     the special value [SQLITE_STATIC], then SQLite assumes that the
     information is in static, unmanaged space and does not need to be freed.
     ^If the fifth argument has the value [SQLITE_TRANSIENT], then
     SQLite makes its own private copy of the data immediately, before
     the sqlite3_bind_*() routine returns.

     ^The sixth argument to sqlite3_bind_text64() must be one of
     [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE]
     to specify the encoding of the text in the third parameter.  If
     the sixth argument to sqlite3_bind_text64() is not one of the
     allowed values shown above, or if the text encoding is different
     from the encoding specified by the sixth parameter, then the behavior
     is undefined.

     ^The sqlite3_bind_zeroblob() routine binds a BLOB of length N that
     is filled with zeroes.  ^A zeroblob uses a fixed amount of memory
     (just an integer to hold its size) while it is being processed.
     Zeroblobs are intended to serve as placeholders for BLOBs whose
     content is later written using
     [sqlite3_blob_open | incremental BLOB I/O] routines.
     ^A negative value for the zeroblob results in a zero-length BLOB.

     ^The sqlite3_bind_pointer(S,I,P,T,D) routine causes the I-th parameter in
     [prepared statement] S to have an SQL value of NULL, but to also be
     associated with the pointer P of type T.  ^D is either a NULL pointer or
     a pointer to a destructor function for P. ^SQLite will invoke the
     destructor D with a single argument of P when it is finished using
     P.  The T parameter should be a static string, preferably a string
     literal. The sqlite3_bind_pointer() routine is part of the
     [pointer passing interface] added for SQLite 3.20.0.

     ^If any of the sqlite3_bind_*() routines are called with a NULL pointer
     for the [prepared statement] or with a prepared statement for which
     [sqlite3_step()] has been called more recently than [sqlite3_reset()],
     then the call will return [SQLITE_MISUSE].  If any sqlite3_bind_()
     routine is passed a [prepared statement] that has been finalized, the
     result is undefined and probably harmful.

     ^Bindings are not cleared by the [sqlite3_reset()] routine.
     ^Unbound parameters are interpreted as NULL.

     ^The sqlite3_bind_* routines return [SQLITE_OK] on success or an
     [error code] if anything goes wrong.
     ^[SQLITE_TOOBIG] might be returned if the size of a string or BLOB
     exceeds limits imposed by [sqlite3_limit]([SQLITE_LIMIT_LENGTH]) or
     [SQLITE_MAX_LENGTH].
     ^[SQLITE_RANGE] is returned if the parameter
     index is out of range.  ^[SQLITE_NOMEM] is returned if malloc() fails.

     See also: [sqlite3_bind_parameter_count()],
     [sqlite3_bind_parameter_name()], and [sqlite3_bind_parameter_index()].
     */
    @inlinable public func bindNull(at index: Int32) -> ResultCode {
        sqlite3_bind_null(rawValue, index).resultCode
    }

    /**
     CAPI3REF: Binding Values To Prepared Statements
     KEYWORDS: {host parameter} {host parameters} {host parameter name}
     KEYWORDS: {SQL parameter} {SQL parameters} {parameter binding}
     METHOD: sqlite3_stmt

     ^(In the SQL statement text input to [sqlite3_prepare_v2()] and its variants,
     literals may be replaced by a [parameter] that matches one of following
     templates:

     <ul>
     <li>  ?
     <li>  ?NNN
     <li>  :VVV
     <li>  @VVV
     <li>  $VVV
     </ul>

     In the templates above, NNN represents an integer literal,
     and VVV represents an alphanumeric identifier.)^  ^The values of these
     parameters (also called "host parameter names" or "SQL parameters")
     can be set using the sqlite3_bind_*() routines defined here.

     ^The first argument to the sqlite3_bind_*() routines is always
     a pointer to the [sqlite3_stmt] object returned from
     [sqlite3_prepare_v2()] or its variants.

     ^The second argument is the index of the SQL parameter to be set.
     ^The leftmost SQL parameter has an index of 1.  ^When the same named
     SQL parameter is used more than once, second and subsequent
     occurrences have the same index as the first occurrence.
     ^The index for named parameters can be looked up using the
     [sqlite3_bind_parameter_index()] API if desired.  ^The index
     for "?NNN" parameters is the value of NNN.
     ^The NNN value must be between 1 and the [sqlite3_limit()]
     parameter [SQLITE_LIMIT_VARIABLE_NUMBER] (default value: 999).

     ^The third argument is the value to bind to the parameter.
     ^If the third parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     or sqlite3_bind_blob() is a NULL pointer then the fourth parameter
     is ignored and the end result is the same as sqlite3_bind_null().

     ^(In those routines that have a fourth argument, its value is the
     number of bytes in the parameter.  To be clear: the value is the
     number of <u>bytes</u> in the value, not the number of characters.)^
     ^If the fourth parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     is negative, then the length of the string is
     the number of bytes up to the first zero terminator.
     If the fourth parameter to sqlite3_bind_blob() is negative, then
     the behavior is undefined.
     If a non-negative fourth parameter is provided to sqlite3_bind_text()
     or sqlite3_bind_text16() or sqlite3_bind_text64() then
     that parameter must be the byte offset
     where the NUL terminator would occur assuming the string were NUL
     terminated.  If any NUL characters occur at byte offsets less than
     the value of the fourth parameter then the resulting string value will
     contain embedded NULs.  The result of expressions involving strings
     with embedded NULs is undefined.

     ^The fifth argument to the BLOB and string binding interfaces
     is a destructor used to dispose of the BLOB or
     string after SQLite has finished with it.  ^The destructor is called
     to dispose of the BLOB or string even if the call to the bind API fails,
     except the destructor is not called if the third parameter is a NULL
     pointer or the fourth parameter is negative.
     ^If the fifth argument is
     the special value [SQLITE_STATIC], then SQLite assumes that the
     information is in static, unmanaged space and does not need to be freed.
     ^If the fifth argument has the value [SQLITE_TRANSIENT], then
     SQLite makes its own private copy of the data immediately, before
     the sqlite3_bind_*() routine returns.

     ^The sixth argument to sqlite3_bind_text64() must be one of
     [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE]
     to specify the encoding of the text in the third parameter.  If
     the sixth argument to sqlite3_bind_text64() is not one of the
     allowed values shown above, or if the text encoding is different
     from the encoding specified by the sixth parameter, then the behavior
     is undefined.

     ^The sqlite3_bind_zeroblob() routine binds a BLOB of length N that
     is filled with zeroes.  ^A zeroblob uses a fixed amount of memory
     (just an integer to hold its size) while it is being processed.
     Zeroblobs are intended to serve as placeholders for BLOBs whose
     content is later written using
     [sqlite3_blob_open | incremental BLOB I/O] routines.
     ^A negative value for the zeroblob results in a zero-length BLOB.

     ^The sqlite3_bind_pointer(S,I,P,T,D) routine causes the I-th parameter in
     [prepared statement] S to have an SQL value of NULL, but to also be
     associated with the pointer P of type T.  ^D is either a NULL pointer or
     a pointer to a destructor function for P. ^SQLite will invoke the
     destructor D with a single argument of P when it is finished using
     P.  The T parameter should be a static string, preferably a string
     literal. The sqlite3_bind_pointer() routine is part of the
     [pointer passing interface] added for SQLite 3.20.0.

     ^If any of the sqlite3_bind_*() routines are called with a NULL pointer
     for the [prepared statement] or with a prepared statement for which
     [sqlite3_step()] has been called more recently than [sqlite3_reset()],
     then the call will return [SQLITE_MISUSE].  If any sqlite3_bind_()
     routine is passed a [prepared statement] that has been finalized, the
     result is undefined and probably harmful.

     ^Bindings are not cleared by the [sqlite3_reset()] routine.
     ^Unbound parameters are interpreted as NULL.

     ^The sqlite3_bind_* routines return [SQLITE_OK] on success or an
     [error code] if anything goes wrong.
     ^[SQLITE_TOOBIG] might be returned if the size of a string or BLOB
     exceeds limits imposed by [sqlite3_limit]([SQLITE_LIMIT_LENGTH]) or
     [SQLITE_MAX_LENGTH].
     ^[SQLITE_RANGE] is returned if the parameter
     index is out of range.  ^[SQLITE_NOMEM] is returned if malloc() fails.

     See also: [sqlite3_bind_parameter_count()],
     [sqlite3_bind_parameter_name()], and [sqlite3_bind_parameter_index()].
     */
    @inlinable public func bindText(_ text: UnsafePointer<Int8>, length: Int32 = -1, at index: Int32, destructor: BindTextDestructor? = nil) -> ResultCode {
        sqlite3_bind_text(rawValue, index, text, length, destructor).resultCode
    }

    /**
     CAPI3REF: Binding Values To Prepared Statements
     KEYWORDS: {host parameter} {host parameters} {host parameter name}
     KEYWORDS: {SQL parameter} {SQL parameters} {parameter binding}
     METHOD: sqlite3_stmt

     ^(In the SQL statement text input to [sqlite3_prepare_v2()] and its variants,
     literals may be replaced by a [parameter] that matches one of following
     templates:

     <ul>
     <li>  ?
     <li>  ?NNN
     <li>  :VVV
     <li>  @VVV
     <li>  $VVV
     </ul>

     In the templates above, NNN represents an integer literal,
     and VVV represents an alphanumeric identifier.)^  ^The values of these
     parameters (also called "host parameter names" or "SQL parameters")
     can be set using the sqlite3_bind_*() routines defined here.

     ^The first argument to the sqlite3_bind_*() routines is always
     a pointer to the [sqlite3_stmt] object returned from
     [sqlite3_prepare_v2()] or its variants.

     ^The second argument is the index of the SQL parameter to be set.
     ^The leftmost SQL parameter has an index of 1.  ^When the same named
     SQL parameter is used more than once, second and subsequent
     occurrences have the same index as the first occurrence.
     ^The index for named parameters can be looked up using the
     [sqlite3_bind_parameter_index()] API if desired.  ^The index
     for "?NNN" parameters is the value of NNN.
     ^The NNN value must be between 1 and the [sqlite3_limit()]
     parameter [SQLITE_LIMIT_VARIABLE_NUMBER] (default value: 999).

     ^The third argument is the value to bind to the parameter.
     ^If the third parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     or sqlite3_bind_blob() is a NULL pointer then the fourth parameter
     is ignored and the end result is the same as sqlite3_bind_null().

     ^(In those routines that have a fourth argument, its value is the
     number of bytes in the parameter.  To be clear: the value is the
     number of <u>bytes</u> in the value, not the number of characters.)^
     ^If the fourth parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     is negative, then the length of the string is
     the number of bytes up to the first zero terminator.
     If the fourth parameter to sqlite3_bind_blob() is negative, then
     the behavior is undefined.
     If a non-negative fourth parameter is provided to sqlite3_bind_text()
     or sqlite3_bind_text16() or sqlite3_bind_text64() then
     that parameter must be the byte offset
     where the NUL terminator would occur assuming the string were NUL
     terminated.  If any NUL characters occur at byte offsets less than
     the value of the fourth parameter then the resulting string value will
     contain embedded NULs.  The result of expressions involving strings
     with embedded NULs is undefined.

     ^The fifth argument to the BLOB and string binding interfaces
     is a destructor used to dispose of the BLOB or
     string after SQLite has finished with it.  ^The destructor is called
     to dispose of the BLOB or string even if the call to the bind API fails,
     except the destructor is not called if the third parameter is a NULL
     pointer or the fourth parameter is negative.
     ^If the fifth argument is
     the special value [SQLITE_STATIC], then SQLite assumes that the
     information is in static, unmanaged space and does not need to be freed.
     ^If the fifth argument has the value [SQLITE_TRANSIENT], then
     SQLite makes its own private copy of the data immediately, before
     the sqlite3_bind_*() routine returns.

     ^The sixth argument to sqlite3_bind_text64() must be one of
     [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE]
     to specify the encoding of the text in the third parameter.  If
     the sixth argument to sqlite3_bind_text64() is not one of the
     allowed values shown above, or if the text encoding is different
     from the encoding specified by the sixth parameter, then the behavior
     is undefined.

     ^The sqlite3_bind_zeroblob() routine binds a BLOB of length N that
     is filled with zeroes.  ^A zeroblob uses a fixed amount of memory
     (just an integer to hold its size) while it is being processed.
     Zeroblobs are intended to serve as placeholders for BLOBs whose
     content is later written using
     [sqlite3_blob_open | incremental BLOB I/O] routines.
     ^A negative value for the zeroblob results in a zero-length BLOB.

     ^The sqlite3_bind_pointer(S,I,P,T,D) routine causes the I-th parameter in
     [prepared statement] S to have an SQL value of NULL, but to also be
     associated with the pointer P of type T.  ^D is either a NULL pointer or
     a pointer to a destructor function for P. ^SQLite will invoke the
     destructor D with a single argument of P when it is finished using
     P.  The T parameter should be a static string, preferably a string
     literal. The sqlite3_bind_pointer() routine is part of the
     [pointer passing interface] added for SQLite 3.20.0.

     ^If any of the sqlite3_bind_*() routines are called with a NULL pointer
     for the [prepared statement] or with a prepared statement for which
     [sqlite3_step()] has been called more recently than [sqlite3_reset()],
     then the call will return [SQLITE_MISUSE].  If any sqlite3_bind_()
     routine is passed a [prepared statement] that has been finalized, the
     result is undefined and probably harmful.

     ^Bindings are not cleared by the [sqlite3_reset()] routine.
     ^Unbound parameters are interpreted as NULL.

     ^The sqlite3_bind_* routines return [SQLITE_OK] on success or an
     [error code] if anything goes wrong.
     ^[SQLITE_TOOBIG] might be returned if the size of a string or BLOB
     exceeds limits imposed by [sqlite3_limit]([SQLITE_LIMIT_LENGTH]) or
     [SQLITE_MAX_LENGTH].
     ^[SQLITE_RANGE] is returned if the parameter
     index is out of range.  ^[SQLITE_NOMEM] is returned if malloc() fails.

     See also: [sqlite3_bind_parameter_count()],
     [sqlite3_bind_parameter_name()], and [sqlite3_bind_parameter_index()].
     */
    @inlinable public func bindTransientText(_ text: UnsafePointer<Int8>, length: Int32 = -1, at index: Int32) -> ResultCode {
        sqlite3_bind_transient_text(rawValue, index, text, length).resultCode
    }

    /**
     CAPI3REF: Binding Values To Prepared Statements
     KEYWORDS: {host parameter} {host parameters} {host parameter name}
     KEYWORDS: {SQL parameter} {SQL parameters} {parameter binding}
     METHOD: sqlite3_stmt

     ^(In the SQL statement text input to [sqlite3_prepare_v2()] and its variants,
     literals may be replaced by a [parameter] that matches one of following
     templates:

     <ul>
     <li>  ?
     <li>  ?NNN
     <li>  :VVV
     <li>  @VVV
     <li>  $VVV
     </ul>

     In the templates above, NNN represents an integer literal,
     and VVV represents an alphanumeric identifier.)^  ^The values of these
     parameters (also called "host parameter names" or "SQL parameters")
     can be set using the sqlite3_bind_*() routines defined here.

     ^The first argument to the sqlite3_bind_*() routines is always
     a pointer to the [sqlite3_stmt] object returned from
     [sqlite3_prepare_v2()] or its variants.

     ^The second argument is the index of the SQL parameter to be set.
     ^The leftmost SQL parameter has an index of 1.  ^When the same named
     SQL parameter is used more than once, second and subsequent
     occurrences have the same index as the first occurrence.
     ^The index for named parameters can be looked up using the
     [sqlite3_bind_parameter_index()] API if desired.  ^The index
     for "?NNN" parameters is the value of NNN.
     ^The NNN value must be between 1 and the [sqlite3_limit()]
     parameter [SQLITE_LIMIT_VARIABLE_NUMBER] (default value: 999).

     ^The third argument is the value to bind to the parameter.
     ^If the third parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     or sqlite3_bind_blob() is a NULL pointer then the fourth parameter
     is ignored and the end result is the same as sqlite3_bind_null().

     ^(In those routines that have a fourth argument, its value is the
     number of bytes in the parameter.  To be clear: the value is the
     number of <u>bytes</u> in the value, not the number of characters.)^
     ^If the fourth parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     is negative, then the length of the string is
     the number of bytes up to the first zero terminator.
     If the fourth parameter to sqlite3_bind_blob() is negative, then
     the behavior is undefined.
     If a non-negative fourth parameter is provided to sqlite3_bind_text()
     or sqlite3_bind_text16() or sqlite3_bind_text64() then
     that parameter must be the byte offset
     where the NUL terminator would occur assuming the string were NUL
     terminated.  If any NUL characters occur at byte offsets less than
     the value of the fourth parameter then the resulting string value will
     contain embedded NULs.  The result of expressions involving strings
     with embedded NULs is undefined.

     ^The fifth argument to the BLOB and string binding interfaces
     is a destructor used to dispose of the BLOB or
     string after SQLite has finished with it.  ^The destructor is called
     to dispose of the BLOB or string even if the call to the bind API fails,
     except the destructor is not called if the third parameter is a NULL
     pointer or the fourth parameter is negative.
     ^If the fifth argument is
     the special value [SQLITE_STATIC], then SQLite assumes that the
     information is in static, unmanaged space and does not need to be freed.
     ^If the fifth argument has the value [SQLITE_TRANSIENT], then
     SQLite makes its own private copy of the data immediately, before
     the sqlite3_bind_*() routine returns.

     ^The sixth argument to sqlite3_bind_text64() must be one of
     [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE]
     to specify the encoding of the text in the third parameter.  If
     the sixth argument to sqlite3_bind_text64() is not one of the
     allowed values shown above, or if the text encoding is different
     from the encoding specified by the sixth parameter, then the behavior
     is undefined.

     ^The sqlite3_bind_zeroblob() routine binds a BLOB of length N that
     is filled with zeroes.  ^A zeroblob uses a fixed amount of memory
     (just an integer to hold its size) while it is being processed.
     Zeroblobs are intended to serve as placeholders for BLOBs whose
     content is later written using
     [sqlite3_blob_open | incremental BLOB I/O] routines.
     ^A negative value for the zeroblob results in a zero-length BLOB.

     ^The sqlite3_bind_pointer(S,I,P,T,D) routine causes the I-th parameter in
     [prepared statement] S to have an SQL value of NULL, but to also be
     associated with the pointer P of type T.  ^D is either a NULL pointer or
     a pointer to a destructor function for P. ^SQLite will invoke the
     destructor D with a single argument of P when it is finished using
     P.  The T parameter should be a static string, preferably a string
     literal. The sqlite3_bind_pointer() routine is part of the
     [pointer passing interface] added for SQLite 3.20.0.

     ^If any of the sqlite3_bind_*() routines are called with a NULL pointer
     for the [prepared statement] or with a prepared statement for which
     [sqlite3_step()] has been called more recently than [sqlite3_reset()],
     then the call will return [SQLITE_MISUSE].  If any sqlite3_bind_()
     routine is passed a [prepared statement] that has been finalized, the
     result is undefined and probably harmful.

     ^Bindings are not cleared by the [sqlite3_reset()] routine.
     ^Unbound parameters are interpreted as NULL.

     ^The sqlite3_bind_* routines return [SQLITE_OK] on success or an
     [error code] if anything goes wrong.
     ^[SQLITE_TOOBIG] might be returned if the size of a string or BLOB
     exceeds limits imposed by [sqlite3_limit]([SQLITE_LIMIT_LENGTH]) or
     [SQLITE_MAX_LENGTH].
     ^[SQLITE_RANGE] is returned if the parameter
     index is out of range.  ^[SQLITE_NOMEM] is returned if malloc() fails.

     See also: [sqlite3_bind_parameter_count()],
     [sqlite3_bind_parameter_name()], and [sqlite3_bind_parameter_index()].
     */
    @inlinable public func bindStaticText(_ text: UnsafePointer<Int8>, length: Int32 = -1, at index: Int32) -> ResultCode {
        sqlite3_bind_static_text(rawValue, index, text, length).resultCode
    }

    /**
     CAPI3REF: Binding Values To Prepared Statements
     KEYWORDS: {host parameter} {host parameters} {host parameter name}
     KEYWORDS: {SQL parameter} {SQL parameters} {parameter binding}
     METHOD: sqlite3_stmt

     ^(In the SQL statement text input to [sqlite3_prepare_v2()] and its variants,
     literals may be replaced by a [parameter] that matches one of following
     templates:

     <ul>
     <li>  ?
     <li>  ?NNN
     <li>  :VVV
     <li>  @VVV
     <li>  $VVV
     </ul>

     In the templates above, NNN represents an integer literal,
     and VVV represents an alphanumeric identifier.)^  ^The values of these
     parameters (also called "host parameter names" or "SQL parameters")
     can be set using the sqlite3_bind_*() routines defined here.

     ^The first argument to the sqlite3_bind_*() routines is always
     a pointer to the [sqlite3_stmt] object returned from
     [sqlite3_prepare_v2()] or its variants.

     ^The second argument is the index of the SQL parameter to be set.
     ^The leftmost SQL parameter has an index of 1.  ^When the same named
     SQL parameter is used more than once, second and subsequent
     occurrences have the same index as the first occurrence.
     ^The index for named parameters can be looked up using the
     [sqlite3_bind_parameter_index()] API if desired.  ^The index
     for "?NNN" parameters is the value of NNN.
     ^The NNN value must be between 1 and the [sqlite3_limit()]
     parameter [SQLITE_LIMIT_VARIABLE_NUMBER] (default value: 999).

     ^The third argument is the value to bind to the parameter.
     ^If the third parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     or sqlite3_bind_blob() is a NULL pointer then the fourth parameter
     is ignored and the end result is the same as sqlite3_bind_null().

     ^(In those routines that have a fourth argument, its value is the
     number of bytes in the parameter.  To be clear: the value is the
     number of <u>bytes</u> in the value, not the number of characters.)^
     ^If the fourth parameter to sqlite3_bind_text() or sqlite3_bind_text16()
     is negative, then the length of the string is
     the number of bytes up to the first zero terminator.
     If the fourth parameter to sqlite3_bind_blob() is negative, then
     the behavior is undefined.
     If a non-negative fourth parameter is provided to sqlite3_bind_text()
     or sqlite3_bind_text16() or sqlite3_bind_text64() then
     that parameter must be the byte offset
     where the NUL terminator would occur assuming the string were NUL
     terminated.  If any NUL characters occur at byte offsets less than
     the value of the fourth parameter then the resulting string value will
     contain embedded NULs.  The result of expressions involving strings
     with embedded NULs is undefined.

     ^The fifth argument to the BLOB and string binding interfaces
     is a destructor used to dispose of the BLOB or
     string after SQLite has finished with it.  ^The destructor is called
     to dispose of the BLOB or string even if the call to the bind API fails,
     except the destructor is not called if the third parameter is a NULL
     pointer or the fourth parameter is negative.
     ^If the fifth argument is
     the special value [SQLITE_STATIC], then SQLite assumes that the
     information is in static, unmanaged space and does not need to be freed.
     ^If the fifth argument has the value [SQLITE_TRANSIENT], then
     SQLite makes its own private copy of the data immediately, before
     the sqlite3_bind_*() routine returns.

     ^The sixth argument to sqlite3_bind_text64() must be one of
     [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE]
     to specify the encoding of the text in the third parameter.  If
     the sixth argument to sqlite3_bind_text64() is not one of the
     allowed values shown above, or if the text encoding is different
     from the encoding specified by the sixth parameter, then the behavior
     is undefined.

     ^The sqlite3_bind_zeroblob() routine binds a BLOB of length N that
     is filled with zeroes.  ^A zeroblob uses a fixed amount of memory
     (just an integer to hold its size) while it is being processed.
     Zeroblobs are intended to serve as placeholders for BLOBs whose
     content is later written using
     [sqlite3_blob_open | incremental BLOB I/O] routines.
     ^A negative value for the zeroblob results in a zero-length BLOB.

     ^The sqlite3_bind_pointer(S,I,P,T,D) routine causes the I-th parameter in
     [prepared statement] S to have an SQL value of NULL, but to also be
     associated with the pointer P of type T.  ^D is either a NULL pointer or
     a pointer to a destructor function for P. ^SQLite will invoke the
     destructor D with a single argument of P when it is finished using
     P.  The T parameter should be a static string, preferably a string
     literal. The sqlite3_bind_pointer() routine is part of the
     [pointer passing interface] added for SQLite 3.20.0.

     ^If any of the sqlite3_bind_*() routines are called with a NULL pointer
     for the [prepared statement] or with a prepared statement for which
     [sqlite3_step()] has been called more recently than [sqlite3_reset()],
     then the call will return [SQLITE_MISUSE].  If any sqlite3_bind_()
     routine is passed a [prepared statement] that has been finalized, the
     result is undefined and probably harmful.

     ^Bindings are not cleared by the [sqlite3_reset()] routine.
     ^Unbound parameters are interpreted as NULL.

     ^The sqlite3_bind_* routines return [SQLITE_OK] on success or an
     [error code] if anything goes wrong.
     ^[SQLITE_TOOBIG] might be returned if the size of a string or BLOB
     exceeds limits imposed by [sqlite3_limit]([SQLITE_LIMIT_LENGTH]) or
     [SQLITE_MAX_LENGTH].
     ^[SQLITE_RANGE] is returned if the parameter
     index is out of range.  ^[SQLITE_NOMEM] is returned if malloc() fails.

     See also: [sqlite3_bind_parameter_count()],
     [sqlite3_bind_parameter_name()], and [sqlite3_bind_parameter_index()].
     */
    @inlinable public func bindZeroBlob(length: Int32, at index: Int32) -> ResultCode {
        sqlite3_bind_zeroblob(rawValue, index, length).resultCode
    }

    /**
     CAPI3REF: Number Of SQL Parameters
     METHOD: sqlite3_stmt

     ^This routine can be used to find the number of [SQL parameters]
     in a [prepared statement].  SQL parameters are tokens of the
     form "?", "?NNN", ":AAA", "$AAA", or "@AAA" that serve as
     placeholders for values that are [sqlite3_bind_blob | bound]
     to the parameters at a later time.

     ^(This routine actually returns the index of the largest (rightmost)
     parameter. For all forms except ?NNN, this will correspond to the
     number of unique parameters.  If parameters of the ?NNN form are used,
     there may be gaps in the list.)^

     See also: [sqlite3_bind_blob|sqlite3_bind()],
     [sqlite3_bind_parameter_name()], and
     [sqlite3_bind_parameter_index()].
     */
    @inlinable public var bindingCount: Int32 {
        sqlite3_bind_parameter_count(rawValue)
    }

    /**
     CAPI3REF: Name Of A Host Parameter
     METHOD: sqlite3_stmt

     ^The sqlite3_bind_parameter_name(P,N) interface returns
     the name of the N-th [SQL parameter] in the [prepared statement] P.
     ^(SQL parameters of the form "?NNN" or ":AAA" or "@AAA" or "$AAA"
     have a name which is the string "?NNN" or ":AAA" or "@AAA" or "$AAA"
     respectively.
     In other words, the initial ":" or "$" or "@" or "?"
     is included as part of the name.)^
     ^Parameters of the form "?" without a following integer have no name
     and are referred to as "nameless" or "anonymous parameters".

     ^The first host parameter has an index of 1, not 0.

     ^If the value N is out of range or if the N-th parameter is
     nameless, then NULL is returned.  ^The returned string is
     always in UTF-8 encoding even if the named parameter was
     originally specified as UTF-16 in [sqlite3_prepare16()],
     [sqlite3_prepare16_v2()], or [sqlite3_prepare16_v3()].

     See also: [sqlite3_bind_blob|sqlite3_bind()],
     [sqlite3_bind_parameter_count()], and
     [sqlite3_bind_parameter_index()].
     */
    @inlinable public func bindingName(at index: Int32) -> UnsafePointer<Int8>? {
        sqlite3_bind_parameter_name(rawValue, index)
    }

    /**
     CAPI3REF: Index Of A Parameter With A Given Name
     METHOD: sqlite3_stmt

     ^Return the index of an SQL parameter given its name.  ^The
     index value returned is suitable for use as the second
     parameter to [sqlite3_bind_blob|sqlite3_bind()].  ^A zero
     is returned if no matching parameter is found.  ^The parameter
     name must be given in UTF-8 even if the original statement
     was prepared from UTF-16 text using [sqlite3_prepare16_v2()] or
     [sqlite3_prepare16_v3()].

     See also: [sqlite3_bind_blob|sqlite3_bind()],
     [sqlite3_bind_parameter_count()], and
     [sqlite3_bind_parameter_name()].
     */
    @inlinable public func bindingIndex(with name: UnsafePointer<Int8>) -> Int32 {
        sqlite3_bind_parameter_index(rawValue, name)
    }

    /**
     CAPI3REF: Reset All Bindings On A Prepared Statement
     METHOD: sqlite3_stmt

     ^Contrary to the intuition of many, [sqlite3_reset()] does not reset
     the [sqlite3_bind_blob | bindings] on a [prepared statement].
     ^Use this routine to reset all host parameters to NULL.
     */
    @inlinable public func clearBindings() -> ResultCode {
        sqlite3_clear_bindings(rawValue).resultCode
    }
}
