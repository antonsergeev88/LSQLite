import MissedSwiftSQLite

extension Context {
    public typealias ResultBlobDestructor = @convention(c) (_ blob: UnsafeMutableRawPointer?) -> Void
    public typealias ResultTextDestructor = @convention(c) (_ blob: UnsafeMutableRawPointer?) -> Void

    /**
     CAPI3REF: Setting The Result Of An SQL Function
     METHOD: sqlite3_context

     These routines are used by the xFunc or xFinal callbacks that
     implement SQL functions and aggregates.  See
     [sqlite3_create_function()] and [sqlite3_create_function16()]
     for additional information.

     These functions work very much like the [parameter binding] family of
     functions used to bind values to host parameters in prepared statements.
     Refer to the [SQL parameter] documentation for additional information.

     ^The sqlite3_result_blob() interface sets the result from
     an application-defined function to be the BLOB whose content is pointed
     to by the second parameter and which is N bytes long where N is the
     third parameter.

     ^The sqlite3_result_zeroblob(C,N) and sqlite3_result_zeroblob64(C,N)
     interfaces set the result of the application-defined function to be
     a BLOB containing all zero bytes and N bytes in size.

     ^The sqlite3_result_double() interface sets the result from
     an application-defined function to be a floating point value specified
     by its 2nd argument.

     ^The sqlite3_result_error() and sqlite3_result_error16() functions
     cause the implemented SQL function to throw an exception.
     ^SQLite uses the string pointed to by the
     2nd parameter of sqlite3_result_error() or sqlite3_result_error16()
     as the text of an error message.  ^SQLite interprets the error
     message string from sqlite3_result_error() as UTF-8. ^SQLite
     interprets the string from sqlite3_result_error16() as UTF-16 in native
     byte order.  ^If the third parameter to sqlite3_result_error()
     or sqlite3_result_error16() is negative then SQLite takes as the error
     message all text up through the first zero character.
     ^If the third parameter to sqlite3_result_error() or
     sqlite3_result_error16() is non-negative then SQLite takes that many
     bytes (not characters) from the 2nd parameter as the error message.
     ^The sqlite3_result_error() and sqlite3_result_error16()
     routines make a private copy of the error message text before
     they return.  Hence, the calling function can deallocate or
     modify the text after they return without harm.
     ^The sqlite3_result_error_code() function changes the error code
     returned by SQLite as a result of an error in a function.  ^By default,
     the error code is SQLITE_ERROR.  ^A subsequent call to sqlite3_result_error()
     or sqlite3_result_error16() resets the error code to SQLITE_ERROR.

     ^The sqlite3_result_error_toobig() interface causes SQLite to throw an
     error indicating that a string or BLOB is too long to represent.

     ^The sqlite3_result_error_nomem() interface causes SQLite to throw an
     error indicating that a memory allocation failed.

     ^The sqlite3_result_int() interface sets the return value
     of the application-defined function to be the 32-bit signed integer
     value given in the 2nd argument.
     ^The sqlite3_result_int64() interface sets the return value
     of the application-defined function to be the 64-bit signed integer
     value given in the 2nd argument.

     ^The sqlite3_result_null() interface sets the return value
     of the application-defined function to be NULL.

     ^The sqlite3_result_text(), sqlite3_result_text16(),
     sqlite3_result_text16le(), and sqlite3_result_text16be() interfaces
     set the return value of the application-defined function to be
     a text string which is represented as UTF-8, UTF-16 native byte order,
     UTF-16 little endian, or UTF-16 big endian, respectively.
     ^The sqlite3_result_text64() interface sets the return value of an
     application-defined function to be a text string in an encoding
     specified by the fifth (and last) parameter, which must be one
     of [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE].
     ^SQLite takes the text result from the application from
     the 2nd parameter of the sqlite3_result_text* interfaces.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is negative, then SQLite takes result text from the 2nd parameter
     through the first zero character.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is non-negative, then as many bytes (not characters) of the text
     pointed to by the 2nd parameter are taken as the application-defined
     function result.  If the 3rd parameter is non-negative, then it
     must be the byte offset into the string where the NUL terminator would
     appear if the string where NUL terminated.  If any NUL characters occur
     in the string at a byte offset that is less than the value of the 3rd
     parameter, then the resulting string will contain embedded NULs and the
     result of expressions operating on strings with embedded NULs is undefined.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is a non-NULL pointer, then SQLite calls that
     function as the destructor on the text or BLOB result when it has
     finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces or to
     sqlite3_result_blob is the special constant SQLITE_STATIC, then SQLite
     assumes that the text or BLOB result is in constant space and does not
     copy the content of the parameter nor call a destructor on the content
     when it has finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is the special constant SQLITE_TRANSIENT
     then SQLite makes a copy of the result into space obtained
     from [sqlite3_malloc()] before it returns.

     ^The sqlite3_result_value() interface sets the result of
     the application-defined function to be a copy of the
     [unprotected sqlite3_value] object specified by the 2nd parameter.  ^The
     sqlite3_result_value() interface makes a copy of the [sqlite3_value]
     so that the [sqlite3_value] specified in the parameter may change or
     be deallocated after sqlite3_result_value() returns without harm.
     ^A [protected sqlite3_value] object may always be used where an
     [unprotected sqlite3_value] object is required, so either
     kind of [sqlite3_value] object can be used with this interface.

     ^The sqlite3_result_pointer(C,P,T,D) interface sets the result to an
     SQL NULL value, just like [sqlite3_result_null(C)], except that it
     also associates the host-language pointer P or type T with that
     NULL value such that the pointer can be retrieved within an
     [application-defined SQL function] using [sqlite3_value_pointer()].
     ^If the D parameter is not NULL, then it is a pointer to a destructor
     for the P parameter.  ^SQLite invokes D with P as its only argument
     when SQLite is finished with P.  The T parameter should be a static
     string and preferably a string literal. The sqlite3_result_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     If these routines are called from within the different thread
     than the one containing the application-defined function that received
     the [sqlite3_context] pointer, the results are undefined.
     */
    @inlinable public func resultBlob(_ blob: UnsafeRawPointer, length: Int32, destructor: ResultBlobDestructor? = nil) {
        sqlite3_result_blob(rawValue, blob, length, destructor)
    }

    /**
     CAPI3REF: Setting The Result Of An SQL Function
     METHOD: sqlite3_context

     These routines are used by the xFunc or xFinal callbacks that
     implement SQL functions and aggregates.  See
     [sqlite3_create_function()] and [sqlite3_create_function16()]
     for additional information.

     These functions work very much like the [parameter binding] family of
     functions used to bind values to host parameters in prepared statements.
     Refer to the [SQL parameter] documentation for additional information.

     ^The sqlite3_result_blob() interface sets the result from
     an application-defined function to be the BLOB whose content is pointed
     to by the second parameter and which is N bytes long where N is the
     third parameter.

     ^The sqlite3_result_zeroblob(C,N) and sqlite3_result_zeroblob64(C,N)
     interfaces set the result of the application-defined function to be
     a BLOB containing all zero bytes and N bytes in size.

     ^The sqlite3_result_double() interface sets the result from
     an application-defined function to be a floating point value specified
     by its 2nd argument.

     ^The sqlite3_result_error() and sqlite3_result_error16() functions
     cause the implemented SQL function to throw an exception.
     ^SQLite uses the string pointed to by the
     2nd parameter of sqlite3_result_error() or sqlite3_result_error16()
     as the text of an error message.  ^SQLite interprets the error
     message string from sqlite3_result_error() as UTF-8. ^SQLite
     interprets the string from sqlite3_result_error16() as UTF-16 in native
     byte order.  ^If the third parameter to sqlite3_result_error()
     or sqlite3_result_error16() is negative then SQLite takes as the error
     message all text up through the first zero character.
     ^If the third parameter to sqlite3_result_error() or
     sqlite3_result_error16() is non-negative then SQLite takes that many
     bytes (not characters) from the 2nd parameter as the error message.
     ^The sqlite3_result_error() and sqlite3_result_error16()
     routines make a private copy of the error message text before
     they return.  Hence, the calling function can deallocate or
     modify the text after they return without harm.
     ^The sqlite3_result_error_code() function changes the error code
     returned by SQLite as a result of an error in a function.  ^By default,
     the error code is SQLITE_ERROR.  ^A subsequent call to sqlite3_result_error()
     or sqlite3_result_error16() resets the error code to SQLITE_ERROR.

     ^The sqlite3_result_error_toobig() interface causes SQLite to throw an
     error indicating that a string or BLOB is too long to represent.

     ^The sqlite3_result_error_nomem() interface causes SQLite to throw an
     error indicating that a memory allocation failed.

     ^The sqlite3_result_int() interface sets the return value
     of the application-defined function to be the 32-bit signed integer
     value given in the 2nd argument.
     ^The sqlite3_result_int64() interface sets the return value
     of the application-defined function to be the 64-bit signed integer
     value given in the 2nd argument.

     ^The sqlite3_result_null() interface sets the return value
     of the application-defined function to be NULL.

     ^The sqlite3_result_text(), sqlite3_result_text16(),
     sqlite3_result_text16le(), and sqlite3_result_text16be() interfaces
     set the return value of the application-defined function to be
     a text string which is represented as UTF-8, UTF-16 native byte order,
     UTF-16 little endian, or UTF-16 big endian, respectively.
     ^The sqlite3_result_text64() interface sets the return value of an
     application-defined function to be a text string in an encoding
     specified by the fifth (and last) parameter, which must be one
     of [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE].
     ^SQLite takes the text result from the application from
     the 2nd parameter of the sqlite3_result_text* interfaces.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is negative, then SQLite takes result text from the 2nd parameter
     through the first zero character.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is non-negative, then as many bytes (not characters) of the text
     pointed to by the 2nd parameter are taken as the application-defined
     function result.  If the 3rd parameter is non-negative, then it
     must be the byte offset into the string where the NUL terminator would
     appear if the string where NUL terminated.  If any NUL characters occur
     in the string at a byte offset that is less than the value of the 3rd
     parameter, then the resulting string will contain embedded NULs and the
     result of expressions operating on strings with embedded NULs is undefined.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is a non-NULL pointer, then SQLite calls that
     function as the destructor on the text or BLOB result when it has
     finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces or to
     sqlite3_result_blob is the special constant SQLITE_STATIC, then SQLite
     assumes that the text or BLOB result is in constant space and does not
     copy the content of the parameter nor call a destructor on the content
     when it has finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is the special constant SQLITE_TRANSIENT
     then SQLite makes a copy of the result into space obtained
     from [sqlite3_malloc()] before it returns.

     ^The sqlite3_result_value() interface sets the result of
     the application-defined function to be a copy of the
     [unprotected sqlite3_value] object specified by the 2nd parameter.  ^The
     sqlite3_result_value() interface makes a copy of the [sqlite3_value]
     so that the [sqlite3_value] specified in the parameter may change or
     be deallocated after sqlite3_result_value() returns without harm.
     ^A [protected sqlite3_value] object may always be used where an
     [unprotected sqlite3_value] object is required, so either
     kind of [sqlite3_value] object can be used with this interface.

     ^The sqlite3_result_pointer(C,P,T,D) interface sets the result to an
     SQL NULL value, just like [sqlite3_result_null(C)], except that it
     also associates the host-language pointer P or type T with that
     NULL value such that the pointer can be retrieved within an
     [application-defined SQL function] using [sqlite3_value_pointer()].
     ^If the D parameter is not NULL, then it is a pointer to a destructor
     for the P parameter.  ^SQLite invokes D with P as its only argument
     when SQLite is finished with P.  The T parameter should be a static
     string and preferably a string literal. The sqlite3_result_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     If these routines are called from within the different thread
     than the one containing the application-defined function that received
     the [sqlite3_context] pointer, the results are undefined.
     */
    @inlinable public func resultTransientBlob(_ blob: UnsafeRawPointer, length: Int32) {
        lsqlite3_result_transient_blob(rawValue, blob, length)
    }

    /**
     CAPI3REF: Setting The Result Of An SQL Function
     METHOD: sqlite3_context

     These routines are used by the xFunc or xFinal callbacks that
     implement SQL functions and aggregates.  See
     [sqlite3_create_function()] and [sqlite3_create_function16()]
     for additional information.

     These functions work very much like the [parameter binding] family of
     functions used to bind values to host parameters in prepared statements.
     Refer to the [SQL parameter] documentation for additional information.

     ^The sqlite3_result_blob() interface sets the result from
     an application-defined function to be the BLOB whose content is pointed
     to by the second parameter and which is N bytes long where N is the
     third parameter.

     ^The sqlite3_result_zeroblob(C,N) and sqlite3_result_zeroblob64(C,N)
     interfaces set the result of the application-defined function to be
     a BLOB containing all zero bytes and N bytes in size.

     ^The sqlite3_result_double() interface sets the result from
     an application-defined function to be a floating point value specified
     by its 2nd argument.

     ^The sqlite3_result_error() and sqlite3_result_error16() functions
     cause the implemented SQL function to throw an exception.
     ^SQLite uses the string pointed to by the
     2nd parameter of sqlite3_result_error() or sqlite3_result_error16()
     as the text of an error message.  ^SQLite interprets the error
     message string from sqlite3_result_error() as UTF-8. ^SQLite
     interprets the string from sqlite3_result_error16() as UTF-16 in native
     byte order.  ^If the third parameter to sqlite3_result_error()
     or sqlite3_result_error16() is negative then SQLite takes as the error
     message all text up through the first zero character.
     ^If the third parameter to sqlite3_result_error() or
     sqlite3_result_error16() is non-negative then SQLite takes that many
     bytes (not characters) from the 2nd parameter as the error message.
     ^The sqlite3_result_error() and sqlite3_result_error16()
     routines make a private copy of the error message text before
     they return.  Hence, the calling function can deallocate or
     modify the text after they return without harm.
     ^The sqlite3_result_error_code() function changes the error code
     returned by SQLite as a result of an error in a function.  ^By default,
     the error code is SQLITE_ERROR.  ^A subsequent call to sqlite3_result_error()
     or sqlite3_result_error16() resets the error code to SQLITE_ERROR.

     ^The sqlite3_result_error_toobig() interface causes SQLite to throw an
     error indicating that a string or BLOB is too long to represent.

     ^The sqlite3_result_error_nomem() interface causes SQLite to throw an
     error indicating that a memory allocation failed.

     ^The sqlite3_result_int() interface sets the return value
     of the application-defined function to be the 32-bit signed integer
     value given in the 2nd argument.
     ^The sqlite3_result_int64() interface sets the return value
     of the application-defined function to be the 64-bit signed integer
     value given in the 2nd argument.

     ^The sqlite3_result_null() interface sets the return value
     of the application-defined function to be NULL.

     ^The sqlite3_result_text(), sqlite3_result_text16(),
     sqlite3_result_text16le(), and sqlite3_result_text16be() interfaces
     set the return value of the application-defined function to be
     a text string which is represented as UTF-8, UTF-16 native byte order,
     UTF-16 little endian, or UTF-16 big endian, respectively.
     ^The sqlite3_result_text64() interface sets the return value of an
     application-defined function to be a text string in an encoding
     specified by the fifth (and last) parameter, which must be one
     of [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE].
     ^SQLite takes the text result from the application from
     the 2nd parameter of the sqlite3_result_text* interfaces.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is negative, then SQLite takes result text from the 2nd parameter
     through the first zero character.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is non-negative, then as many bytes (not characters) of the text
     pointed to by the 2nd parameter are taken as the application-defined
     function result.  If the 3rd parameter is non-negative, then it
     must be the byte offset into the string where the NUL terminator would
     appear if the string where NUL terminated.  If any NUL characters occur
     in the string at a byte offset that is less than the value of the 3rd
     parameter, then the resulting string will contain embedded NULs and the
     result of expressions operating on strings with embedded NULs is undefined.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is a non-NULL pointer, then SQLite calls that
     function as the destructor on the text or BLOB result when it has
     finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces or to
     sqlite3_result_blob is the special constant SQLITE_STATIC, then SQLite
     assumes that the text or BLOB result is in constant space and does not
     copy the content of the parameter nor call a destructor on the content
     when it has finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is the special constant SQLITE_TRANSIENT
     then SQLite makes a copy of the result into space obtained
     from [sqlite3_malloc()] before it returns.

     ^The sqlite3_result_value() interface sets the result of
     the application-defined function to be a copy of the
     [unprotected sqlite3_value] object specified by the 2nd parameter.  ^The
     sqlite3_result_value() interface makes a copy of the [sqlite3_value]
     so that the [sqlite3_value] specified in the parameter may change or
     be deallocated after sqlite3_result_value() returns without harm.
     ^A [protected sqlite3_value] object may always be used where an
     [unprotected sqlite3_value] object is required, so either
     kind of [sqlite3_value] object can be used with this interface.

     ^The sqlite3_result_pointer(C,P,T,D) interface sets the result to an
     SQL NULL value, just like [sqlite3_result_null(C)], except that it
     also associates the host-language pointer P or type T with that
     NULL value such that the pointer can be retrieved within an
     [application-defined SQL function] using [sqlite3_value_pointer()].
     ^If the D parameter is not NULL, then it is a pointer to a destructor
     for the P parameter.  ^SQLite invokes D with P as its only argument
     when SQLite is finished with P.  The T parameter should be a static
     string and preferably a string literal. The sqlite3_result_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     If these routines are called from within the different thread
     than the one containing the application-defined function that received
     the [sqlite3_context] pointer, the results are undefined.
     */
    @inlinable public func resultStaticBlob(_ blob: UnsafeRawPointer, length: Int32) {
        lsqlite3_result_static_blob(rawValue, blob, length)
    }

    /**
     CAPI3REF: Setting The Result Of An SQL Function
     METHOD: sqlite3_context

     These routines are used by the xFunc or xFinal callbacks that
     implement SQL functions and aggregates.  See
     [sqlite3_create_function()] and [sqlite3_create_function16()]
     for additional information.

     These functions work very much like the [parameter binding] family of
     functions used to bind values to host parameters in prepared statements.
     Refer to the [SQL parameter] documentation for additional information.

     ^The sqlite3_result_blob() interface sets the result from
     an application-defined function to be the BLOB whose content is pointed
     to by the second parameter and which is N bytes long where N is the
     third parameter.

     ^The sqlite3_result_zeroblob(C,N) and sqlite3_result_zeroblob64(C,N)
     interfaces set the result of the application-defined function to be
     a BLOB containing all zero bytes and N bytes in size.

     ^The sqlite3_result_double() interface sets the result from
     an application-defined function to be a floating point value specified
     by its 2nd argument.

     ^The sqlite3_result_error() and sqlite3_result_error16() functions
     cause the implemented SQL function to throw an exception.
     ^SQLite uses the string pointed to by the
     2nd parameter of sqlite3_result_error() or sqlite3_result_error16()
     as the text of an error message.  ^SQLite interprets the error
     message string from sqlite3_result_error() as UTF-8. ^SQLite
     interprets the string from sqlite3_result_error16() as UTF-16 in native
     byte order.  ^If the third parameter to sqlite3_result_error()
     or sqlite3_result_error16() is negative then SQLite takes as the error
     message all text up through the first zero character.
     ^If the third parameter to sqlite3_result_error() or
     sqlite3_result_error16() is non-negative then SQLite takes that many
     bytes (not characters) from the 2nd parameter as the error message.
     ^The sqlite3_result_error() and sqlite3_result_error16()
     routines make a private copy of the error message text before
     they return.  Hence, the calling function can deallocate or
     modify the text after they return without harm.
     ^The sqlite3_result_error_code() function changes the error code
     returned by SQLite as a result of an error in a function.  ^By default,
     the error code is SQLITE_ERROR.  ^A subsequent call to sqlite3_result_error()
     or sqlite3_result_error16() resets the error code to SQLITE_ERROR.

     ^The sqlite3_result_error_toobig() interface causes SQLite to throw an
     error indicating that a string or BLOB is too long to represent.

     ^The sqlite3_result_error_nomem() interface causes SQLite to throw an
     error indicating that a memory allocation failed.

     ^The sqlite3_result_int() interface sets the return value
     of the application-defined function to be the 32-bit signed integer
     value given in the 2nd argument.
     ^The sqlite3_result_int64() interface sets the return value
     of the application-defined function to be the 64-bit signed integer
     value given in the 2nd argument.

     ^The sqlite3_result_null() interface sets the return value
     of the application-defined function to be NULL.

     ^The sqlite3_result_text(), sqlite3_result_text16(),
     sqlite3_result_text16le(), and sqlite3_result_text16be() interfaces
     set the return value of the application-defined function to be
     a text string which is represented as UTF-8, UTF-16 native byte order,
     UTF-16 little endian, or UTF-16 big endian, respectively.
     ^The sqlite3_result_text64() interface sets the return value of an
     application-defined function to be a text string in an encoding
     specified by the fifth (and last) parameter, which must be one
     of [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE].
     ^SQLite takes the text result from the application from
     the 2nd parameter of the sqlite3_result_text* interfaces.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is negative, then SQLite takes result text from the 2nd parameter
     through the first zero character.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is non-negative, then as many bytes (not characters) of the text
     pointed to by the 2nd parameter are taken as the application-defined
     function result.  If the 3rd parameter is non-negative, then it
     must be the byte offset into the string where the NUL terminator would
     appear if the string where NUL terminated.  If any NUL characters occur
     in the string at a byte offset that is less than the value of the 3rd
     parameter, then the resulting string will contain embedded NULs and the
     result of expressions operating on strings with embedded NULs is undefined.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is a non-NULL pointer, then SQLite calls that
     function as the destructor on the text or BLOB result when it has
     finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces or to
     sqlite3_result_blob is the special constant SQLITE_STATIC, then SQLite
     assumes that the text or BLOB result is in constant space and does not
     copy the content of the parameter nor call a destructor on the content
     when it has finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is the special constant SQLITE_TRANSIENT
     then SQLite makes a copy of the result into space obtained
     from [sqlite3_malloc()] before it returns.

     ^The sqlite3_result_value() interface sets the result of
     the application-defined function to be a copy of the
     [unprotected sqlite3_value] object specified by the 2nd parameter.  ^The
     sqlite3_result_value() interface makes a copy of the [sqlite3_value]
     so that the [sqlite3_value] specified in the parameter may change or
     be deallocated after sqlite3_result_value() returns without harm.
     ^A [protected sqlite3_value] object may always be used where an
     [unprotected sqlite3_value] object is required, so either
     kind of [sqlite3_value] object can be used with this interface.

     ^The sqlite3_result_pointer(C,P,T,D) interface sets the result to an
     SQL NULL value, just like [sqlite3_result_null(C)], except that it
     also associates the host-language pointer P or type T with that
     NULL value such that the pointer can be retrieved within an
     [application-defined SQL function] using [sqlite3_value_pointer()].
     ^If the D parameter is not NULL, then it is a pointer to a destructor
     for the P parameter.  ^SQLite invokes D with P as its only argument
     when SQLite is finished with P.  The T parameter should be a static
     string and preferably a string literal. The sqlite3_result_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     If these routines are called from within the different thread
     than the one containing the application-defined function that received
     the [sqlite3_context] pointer, the results are undefined.
     */
    @inlinable public func resultDouble(_ double: Double) {
        sqlite3_result_double(rawValue, double)
    }

    /**
     CAPI3REF: Setting The Result Of An SQL Function
     METHOD: sqlite3_context

     These routines are used by the xFunc or xFinal callbacks that
     implement SQL functions and aggregates.  See
     [sqlite3_create_function()] and [sqlite3_create_function16()]
     for additional information.

     These functions work very much like the [parameter binding] family of
     functions used to bind values to host parameters in prepared statements.
     Refer to the [SQL parameter] documentation for additional information.

     ^The sqlite3_result_blob() interface sets the result from
     an application-defined function to be the BLOB whose content is pointed
     to by the second parameter and which is N bytes long where N is the
     third parameter.

     ^The sqlite3_result_zeroblob(C,N) and sqlite3_result_zeroblob64(C,N)
     interfaces set the result of the application-defined function to be
     a BLOB containing all zero bytes and N bytes in size.

     ^The sqlite3_result_double() interface sets the result from
     an application-defined function to be a floating point value specified
     by its 2nd argument.

     ^The sqlite3_result_error() and sqlite3_result_error16() functions
     cause the implemented SQL function to throw an exception.
     ^SQLite uses the string pointed to by the
     2nd parameter of sqlite3_result_error() or sqlite3_result_error16()
     as the text of an error message.  ^SQLite interprets the error
     message string from sqlite3_result_error() as UTF-8. ^SQLite
     interprets the string from sqlite3_result_error16() as UTF-16 in native
     byte order.  ^If the third parameter to sqlite3_result_error()
     or sqlite3_result_error16() is negative then SQLite takes as the error
     message all text up through the first zero character.
     ^If the third parameter to sqlite3_result_error() or
     sqlite3_result_error16() is non-negative then SQLite takes that many
     bytes (not characters) from the 2nd parameter as the error message.
     ^The sqlite3_result_error() and sqlite3_result_error16()
     routines make a private copy of the error message text before
     they return.  Hence, the calling function can deallocate or
     modify the text after they return without harm.
     ^The sqlite3_result_error_code() function changes the error code
     returned by SQLite as a result of an error in a function.  ^By default,
     the error code is SQLITE_ERROR.  ^A subsequent call to sqlite3_result_error()
     or sqlite3_result_error16() resets the error code to SQLITE_ERROR.

     ^The sqlite3_result_error_toobig() interface causes SQLite to throw an
     error indicating that a string or BLOB is too long to represent.

     ^The sqlite3_result_error_nomem() interface causes SQLite to throw an
     error indicating that a memory allocation failed.

     ^The sqlite3_result_int() interface sets the return value
     of the application-defined function to be the 32-bit signed integer
     value given in the 2nd argument.
     ^The sqlite3_result_int64() interface sets the return value
     of the application-defined function to be the 64-bit signed integer
     value given in the 2nd argument.

     ^The sqlite3_result_null() interface sets the return value
     of the application-defined function to be NULL.

     ^The sqlite3_result_text(), sqlite3_result_text16(),
     sqlite3_result_text16le(), and sqlite3_result_text16be() interfaces
     set the return value of the application-defined function to be
     a text string which is represented as UTF-8, UTF-16 native byte order,
     UTF-16 little endian, or UTF-16 big endian, respectively.
     ^The sqlite3_result_text64() interface sets the return value of an
     application-defined function to be a text string in an encoding
     specified by the fifth (and last) parameter, which must be one
     of [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE].
     ^SQLite takes the text result from the application from
     the 2nd parameter of the sqlite3_result_text* interfaces.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is negative, then SQLite takes result text from the 2nd parameter
     through the first zero character.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is non-negative, then as many bytes (not characters) of the text
     pointed to by the 2nd parameter are taken as the application-defined
     function result.  If the 3rd parameter is non-negative, then it
     must be the byte offset into the string where the NUL terminator would
     appear if the string where NUL terminated.  If any NUL characters occur
     in the string at a byte offset that is less than the value of the 3rd
     parameter, then the resulting string will contain embedded NULs and the
     result of expressions operating on strings with embedded NULs is undefined.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is a non-NULL pointer, then SQLite calls that
     function as the destructor on the text or BLOB result when it has
     finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces or to
     sqlite3_result_blob is the special constant SQLITE_STATIC, then SQLite
     assumes that the text or BLOB result is in constant space and does not
     copy the content of the parameter nor call a destructor on the content
     when it has finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is the special constant SQLITE_TRANSIENT
     then SQLite makes a copy of the result into space obtained
     from [sqlite3_malloc()] before it returns.

     ^The sqlite3_result_value() interface sets the result of
     the application-defined function to be a copy of the
     [unprotected sqlite3_value] object specified by the 2nd parameter.  ^The
     sqlite3_result_value() interface makes a copy of the [sqlite3_value]
     so that the [sqlite3_value] specified in the parameter may change or
     be deallocated after sqlite3_result_value() returns without harm.
     ^A [protected sqlite3_value] object may always be used where an
     [unprotected sqlite3_value] object is required, so either
     kind of [sqlite3_value] object can be used with this interface.

     ^The sqlite3_result_pointer(C,P,T,D) interface sets the result to an
     SQL NULL value, just like [sqlite3_result_null(C)], except that it
     also associates the host-language pointer P or type T with that
     NULL value such that the pointer can be retrieved within an
     [application-defined SQL function] using [sqlite3_value_pointer()].
     ^If the D parameter is not NULL, then it is a pointer to a destructor
     for the P parameter.  ^SQLite invokes D with P as its only argument
     when SQLite is finished with P.  The T parameter should be a static
     string and preferably a string literal. The sqlite3_result_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     If these routines are called from within the different thread
     than the one containing the application-defined function that received
     the [sqlite3_context] pointer, the results are undefined.
     */
    @inlinable public func resultError(_ message: UnsafePointer<Int8>, length: Int32) {
        sqlite3_result_error(rawValue, message, length)
    }

    /**
     CAPI3REF: Setting The Result Of An SQL Function
     METHOD: sqlite3_context

     These routines are used by the xFunc or xFinal callbacks that
     implement SQL functions and aggregates.  See
     [sqlite3_create_function()] and [sqlite3_create_function16()]
     for additional information.

     These functions work very much like the [parameter binding] family of
     functions used to bind values to host parameters in prepared statements.
     Refer to the [SQL parameter] documentation for additional information.

     ^The sqlite3_result_blob() interface sets the result from
     an application-defined function to be the BLOB whose content is pointed
     to by the second parameter and which is N bytes long where N is the
     third parameter.

     ^The sqlite3_result_zeroblob(C,N) and sqlite3_result_zeroblob64(C,N)
     interfaces set the result of the application-defined function to be
     a BLOB containing all zero bytes and N bytes in size.

     ^The sqlite3_result_double() interface sets the result from
     an application-defined function to be a floating point value specified
     by its 2nd argument.

     ^The sqlite3_result_error() and sqlite3_result_error16() functions
     cause the implemented SQL function to throw an exception.
     ^SQLite uses the string pointed to by the
     2nd parameter of sqlite3_result_error() or sqlite3_result_error16()
     as the text of an error message.  ^SQLite interprets the error
     message string from sqlite3_result_error() as UTF-8. ^SQLite
     interprets the string from sqlite3_result_error16() as UTF-16 in native
     byte order.  ^If the third parameter to sqlite3_result_error()
     or sqlite3_result_error16() is negative then SQLite takes as the error
     message all text up through the first zero character.
     ^If the third parameter to sqlite3_result_error() or
     sqlite3_result_error16() is non-negative then SQLite takes that many
     bytes (not characters) from the 2nd parameter as the error message.
     ^The sqlite3_result_error() and sqlite3_result_error16()
     routines make a private copy of the error message text before
     they return.  Hence, the calling function can deallocate or
     modify the text after they return without harm.
     ^The sqlite3_result_error_code() function changes the error code
     returned by SQLite as a result of an error in a function.  ^By default,
     the error code is SQLITE_ERROR.  ^A subsequent call to sqlite3_result_error()
     or sqlite3_result_error16() resets the error code to SQLITE_ERROR.

     ^The sqlite3_result_error_toobig() interface causes SQLite to throw an
     error indicating that a string or BLOB is too long to represent.

     ^The sqlite3_result_error_nomem() interface causes SQLite to throw an
     error indicating that a memory allocation failed.

     ^The sqlite3_result_int() interface sets the return value
     of the application-defined function to be the 32-bit signed integer
     value given in the 2nd argument.
     ^The sqlite3_result_int64() interface sets the return value
     of the application-defined function to be the 64-bit signed integer
     value given in the 2nd argument.

     ^The sqlite3_result_null() interface sets the return value
     of the application-defined function to be NULL.

     ^The sqlite3_result_text(), sqlite3_result_text16(),
     sqlite3_result_text16le(), and sqlite3_result_text16be() interfaces
     set the return value of the application-defined function to be
     a text string which is represented as UTF-8, UTF-16 native byte order,
     UTF-16 little endian, or UTF-16 big endian, respectively.
     ^The sqlite3_result_text64() interface sets the return value of an
     application-defined function to be a text string in an encoding
     specified by the fifth (and last) parameter, which must be one
     of [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE].
     ^SQLite takes the text result from the application from
     the 2nd parameter of the sqlite3_result_text* interfaces.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is negative, then SQLite takes result text from the 2nd parameter
     through the first zero character.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is non-negative, then as many bytes (not characters) of the text
     pointed to by the 2nd parameter are taken as the application-defined
     function result.  If the 3rd parameter is non-negative, then it
     must be the byte offset into the string where the NUL terminator would
     appear if the string where NUL terminated.  If any NUL characters occur
     in the string at a byte offset that is less than the value of the 3rd
     parameter, then the resulting string will contain embedded NULs and the
     result of expressions operating on strings with embedded NULs is undefined.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is a non-NULL pointer, then SQLite calls that
     function as the destructor on the text or BLOB result when it has
     finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces or to
     sqlite3_result_blob is the special constant SQLITE_STATIC, then SQLite
     assumes that the text or BLOB result is in constant space and does not
     copy the content of the parameter nor call a destructor on the content
     when it has finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is the special constant SQLITE_TRANSIENT
     then SQLite makes a copy of the result into space obtained
     from [sqlite3_malloc()] before it returns.

     ^The sqlite3_result_value() interface sets the result of
     the application-defined function to be a copy of the
     [unprotected sqlite3_value] object specified by the 2nd parameter.  ^The
     sqlite3_result_value() interface makes a copy of the [sqlite3_value]
     so that the [sqlite3_value] specified in the parameter may change or
     be deallocated after sqlite3_result_value() returns without harm.
     ^A [protected sqlite3_value] object may always be used where an
     [unprotected sqlite3_value] object is required, so either
     kind of [sqlite3_value] object can be used with this interface.

     ^The sqlite3_result_pointer(C,P,T,D) interface sets the result to an
     SQL NULL value, just like [sqlite3_result_null(C)], except that it
     also associates the host-language pointer P or type T with that
     NULL value such that the pointer can be retrieved within an
     [application-defined SQL function] using [sqlite3_value_pointer()].
     ^If the D parameter is not NULL, then it is a pointer to a destructor
     for the P parameter.  ^SQLite invokes D with P as its only argument
     when SQLite is finished with P.  The T parameter should be a static
     string and preferably a string literal. The sqlite3_result_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     If these routines are called from within the different thread
     than the one containing the application-defined function that received
     the [sqlite3_context] pointer, the results are undefined.
     */
    @inlinable public func resultTooBigError() {
        sqlite3_result_error_toobig(rawValue)
    }

    /**
     CAPI3REF: Setting The Result Of An SQL Function
     METHOD: sqlite3_context

     These routines are used by the xFunc or xFinal callbacks that
     implement SQL functions and aggregates.  See
     [sqlite3_create_function()] and [sqlite3_create_function16()]
     for additional information.

     These functions work very much like the [parameter binding] family of
     functions used to bind values to host parameters in prepared statements.
     Refer to the [SQL parameter] documentation for additional information.

     ^The sqlite3_result_blob() interface sets the result from
     an application-defined function to be the BLOB whose content is pointed
     to by the second parameter and which is N bytes long where N is the
     third parameter.

     ^The sqlite3_result_zeroblob(C,N) and sqlite3_result_zeroblob64(C,N)
     interfaces set the result of the application-defined function to be
     a BLOB containing all zero bytes and N bytes in size.

     ^The sqlite3_result_double() interface sets the result from
     an application-defined function to be a floating point value specified
     by its 2nd argument.

     ^The sqlite3_result_error() and sqlite3_result_error16() functions
     cause the implemented SQL function to throw an exception.
     ^SQLite uses the string pointed to by the
     2nd parameter of sqlite3_result_error() or sqlite3_result_error16()
     as the text of an error message.  ^SQLite interprets the error
     message string from sqlite3_result_error() as UTF-8. ^SQLite
     interprets the string from sqlite3_result_error16() as UTF-16 in native
     byte order.  ^If the third parameter to sqlite3_result_error()
     or sqlite3_result_error16() is negative then SQLite takes as the error
     message all text up through the first zero character.
     ^If the third parameter to sqlite3_result_error() or
     sqlite3_result_error16() is non-negative then SQLite takes that many
     bytes (not characters) from the 2nd parameter as the error message.
     ^The sqlite3_result_error() and sqlite3_result_error16()
     routines make a private copy of the error message text before
     they return.  Hence, the calling function can deallocate or
     modify the text after they return without harm.
     ^The sqlite3_result_error_code() function changes the error code
     returned by SQLite as a result of an error in a function.  ^By default,
     the error code is SQLITE_ERROR.  ^A subsequent call to sqlite3_result_error()
     or sqlite3_result_error16() resets the error code to SQLITE_ERROR.

     ^The sqlite3_result_error_toobig() interface causes SQLite to throw an
     error indicating that a string or BLOB is too long to represent.

     ^The sqlite3_result_error_nomem() interface causes SQLite to throw an
     error indicating that a memory allocation failed.

     ^The sqlite3_result_int() interface sets the return value
     of the application-defined function to be the 32-bit signed integer
     value given in the 2nd argument.
     ^The sqlite3_result_int64() interface sets the return value
     of the application-defined function to be the 64-bit signed integer
     value given in the 2nd argument.

     ^The sqlite3_result_null() interface sets the return value
     of the application-defined function to be NULL.

     ^The sqlite3_result_text(), sqlite3_result_text16(),
     sqlite3_result_text16le(), and sqlite3_result_text16be() interfaces
     set the return value of the application-defined function to be
     a text string which is represented as UTF-8, UTF-16 native byte order,
     UTF-16 little endian, or UTF-16 big endian, respectively.
     ^The sqlite3_result_text64() interface sets the return value of an
     application-defined function to be a text string in an encoding
     specified by the fifth (and last) parameter, which must be one
     of [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE].
     ^SQLite takes the text result from the application from
     the 2nd parameter of the sqlite3_result_text* interfaces.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is negative, then SQLite takes result text from the 2nd parameter
     through the first zero character.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is non-negative, then as many bytes (not characters) of the text
     pointed to by the 2nd parameter are taken as the application-defined
     function result.  If the 3rd parameter is non-negative, then it
     must be the byte offset into the string where the NUL terminator would
     appear if the string where NUL terminated.  If any NUL characters occur
     in the string at a byte offset that is less than the value of the 3rd
     parameter, then the resulting string will contain embedded NULs and the
     result of expressions operating on strings with embedded NULs is undefined.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is a non-NULL pointer, then SQLite calls that
     function as the destructor on the text or BLOB result when it has
     finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces or to
     sqlite3_result_blob is the special constant SQLITE_STATIC, then SQLite
     assumes that the text or BLOB result is in constant space and does not
     copy the content of the parameter nor call a destructor on the content
     when it has finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is the special constant SQLITE_TRANSIENT
     then SQLite makes a copy of the result into space obtained
     from [sqlite3_malloc()] before it returns.

     ^The sqlite3_result_value() interface sets the result of
     the application-defined function to be a copy of the
     [unprotected sqlite3_value] object specified by the 2nd parameter.  ^The
     sqlite3_result_value() interface makes a copy of the [sqlite3_value]
     so that the [sqlite3_value] specified in the parameter may change or
     be deallocated after sqlite3_result_value() returns without harm.
     ^A [protected sqlite3_value] object may always be used where an
     [unprotected sqlite3_value] object is required, so either
     kind of [sqlite3_value] object can be used with this interface.

     ^The sqlite3_result_pointer(C,P,T,D) interface sets the result to an
     SQL NULL value, just like [sqlite3_result_null(C)], except that it
     also associates the host-language pointer P or type T with that
     NULL value such that the pointer can be retrieved within an
     [application-defined SQL function] using [sqlite3_value_pointer()].
     ^If the D parameter is not NULL, then it is a pointer to a destructor
     for the P parameter.  ^SQLite invokes D with P as its only argument
     when SQLite is finished with P.  The T parameter should be a static
     string and preferably a string literal. The sqlite3_result_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     If these routines are called from within the different thread
     than the one containing the application-defined function that received
     the [sqlite3_context] pointer, the results are undefined.
     */
    @inlinable public func resultNoMemoryError() {
        sqlite3_result_error_nomem(rawValue)
    }

    /**
     CAPI3REF: Setting The Result Of An SQL Function
     METHOD: sqlite3_context

     These routines are used by the xFunc or xFinal callbacks that
     implement SQL functions and aggregates.  See
     [sqlite3_create_function()] and [sqlite3_create_function16()]
     for additional information.

     These functions work very much like the [parameter binding] family of
     functions used to bind values to host parameters in prepared statements.
     Refer to the [SQL parameter] documentation for additional information.

     ^The sqlite3_result_blob() interface sets the result from
     an application-defined function to be the BLOB whose content is pointed
     to by the second parameter and which is N bytes long where N is the
     third parameter.

     ^The sqlite3_result_zeroblob(C,N) and sqlite3_result_zeroblob64(C,N)
     interfaces set the result of the application-defined function to be
     a BLOB containing all zero bytes and N bytes in size.

     ^The sqlite3_result_double() interface sets the result from
     an application-defined function to be a floating point value specified
     by its 2nd argument.

     ^The sqlite3_result_error() and sqlite3_result_error16() functions
     cause the implemented SQL function to throw an exception.
     ^SQLite uses the string pointed to by the
     2nd parameter of sqlite3_result_error() or sqlite3_result_error16()
     as the text of an error message.  ^SQLite interprets the error
     message string from sqlite3_result_error() as UTF-8. ^SQLite
     interprets the string from sqlite3_result_error16() as UTF-16 in native
     byte order.  ^If the third parameter to sqlite3_result_error()
     or sqlite3_result_error16() is negative then SQLite takes as the error
     message all text up through the first zero character.
     ^If the third parameter to sqlite3_result_error() or
     sqlite3_result_error16() is non-negative then SQLite takes that many
     bytes (not characters) from the 2nd parameter as the error message.
     ^The sqlite3_result_error() and sqlite3_result_error16()
     routines make a private copy of the error message text before
     they return.  Hence, the calling function can deallocate or
     modify the text after they return without harm.
     ^The sqlite3_result_error_code() function changes the error code
     returned by SQLite as a result of an error in a function.  ^By default,
     the error code is SQLITE_ERROR.  ^A subsequent call to sqlite3_result_error()
     or sqlite3_result_error16() resets the error code to SQLITE_ERROR.

     ^The sqlite3_result_error_toobig() interface causes SQLite to throw an
     error indicating that a string or BLOB is too long to represent.

     ^The sqlite3_result_error_nomem() interface causes SQLite to throw an
     error indicating that a memory allocation failed.

     ^The sqlite3_result_int() interface sets the return value
     of the application-defined function to be the 32-bit signed integer
     value given in the 2nd argument.
     ^The sqlite3_result_int64() interface sets the return value
     of the application-defined function to be the 64-bit signed integer
     value given in the 2nd argument.

     ^The sqlite3_result_null() interface sets the return value
     of the application-defined function to be NULL.

     ^The sqlite3_result_text(), sqlite3_result_text16(),
     sqlite3_result_text16le(), and sqlite3_result_text16be() interfaces
     set the return value of the application-defined function to be
     a text string which is represented as UTF-8, UTF-16 native byte order,
     UTF-16 little endian, or UTF-16 big endian, respectively.
     ^The sqlite3_result_text64() interface sets the return value of an
     application-defined function to be a text string in an encoding
     specified by the fifth (and last) parameter, which must be one
     of [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE].
     ^SQLite takes the text result from the application from
     the 2nd parameter of the sqlite3_result_text* interfaces.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is negative, then SQLite takes result text from the 2nd parameter
     through the first zero character.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is non-negative, then as many bytes (not characters) of the text
     pointed to by the 2nd parameter are taken as the application-defined
     function result.  If the 3rd parameter is non-negative, then it
     must be the byte offset into the string where the NUL terminator would
     appear if the string where NUL terminated.  If any NUL characters occur
     in the string at a byte offset that is less than the value of the 3rd
     parameter, then the resulting string will contain embedded NULs and the
     result of expressions operating on strings with embedded NULs is undefined.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is a non-NULL pointer, then SQLite calls that
     function as the destructor on the text or BLOB result when it has
     finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces or to
     sqlite3_result_blob is the special constant SQLITE_STATIC, then SQLite
     assumes that the text or BLOB result is in constant space and does not
     copy the content of the parameter nor call a destructor on the content
     when it has finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is the special constant SQLITE_TRANSIENT
     then SQLite makes a copy of the result into space obtained
     from [sqlite3_malloc()] before it returns.

     ^The sqlite3_result_value() interface sets the result of
     the application-defined function to be a copy of the
     [unprotected sqlite3_value] object specified by the 2nd parameter.  ^The
     sqlite3_result_value() interface makes a copy of the [sqlite3_value]
     so that the [sqlite3_value] specified in the parameter may change or
     be deallocated after sqlite3_result_value() returns without harm.
     ^A [protected sqlite3_value] object may always be used where an
     [unprotected sqlite3_value] object is required, so either
     kind of [sqlite3_value] object can be used with this interface.

     ^The sqlite3_result_pointer(C,P,T,D) interface sets the result to an
     SQL NULL value, just like [sqlite3_result_null(C)], except that it
     also associates the host-language pointer P or type T with that
     NULL value such that the pointer can be retrieved within an
     [application-defined SQL function] using [sqlite3_value_pointer()].
     ^If the D parameter is not NULL, then it is a pointer to a destructor
     for the P parameter.  ^SQLite invokes D with P as its only argument
     when SQLite is finished with P.  The T parameter should be a static
     string and preferably a string literal. The sqlite3_result_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     If these routines are called from within the different thread
     than the one containing the application-defined function that received
     the [sqlite3_context] pointer, the results are undefined.
     */
    @inlinable public func resultErrorCode(_ code: ResultCode) {
        sqlite3_result_error_code(rawValue, code.rawValue)
    }

    /**
     CAPI3REF: Setting The Result Of An SQL Function
     METHOD: sqlite3_context

     These routines are used by the xFunc or xFinal callbacks that
     implement SQL functions and aggregates.  See
     [sqlite3_create_function()] and [sqlite3_create_function16()]
     for additional information.

     These functions work very much like the [parameter binding] family of
     functions used to bind values to host parameters in prepared statements.
     Refer to the [SQL parameter] documentation for additional information.

     ^The sqlite3_result_blob() interface sets the result from
     an application-defined function to be the BLOB whose content is pointed
     to by the second parameter and which is N bytes long where N is the
     third parameter.

     ^The sqlite3_result_zeroblob(C,N) and sqlite3_result_zeroblob64(C,N)
     interfaces set the result of the application-defined function to be
     a BLOB containing all zero bytes and N bytes in size.

     ^The sqlite3_result_double() interface sets the result from
     an application-defined function to be a floating point value specified
     by its 2nd argument.

     ^The sqlite3_result_error() and sqlite3_result_error16() functions
     cause the implemented SQL function to throw an exception.
     ^SQLite uses the string pointed to by the
     2nd parameter of sqlite3_result_error() or sqlite3_result_error16()
     as the text of an error message.  ^SQLite interprets the error
     message string from sqlite3_result_error() as UTF-8. ^SQLite
     interprets the string from sqlite3_result_error16() as UTF-16 in native
     byte order.  ^If the third parameter to sqlite3_result_error()
     or sqlite3_result_error16() is negative then SQLite takes as the error
     message all text up through the first zero character.
     ^If the third parameter to sqlite3_result_error() or
     sqlite3_result_error16() is non-negative then SQLite takes that many
     bytes (not characters) from the 2nd parameter as the error message.
     ^The sqlite3_result_error() and sqlite3_result_error16()
     routines make a private copy of the error message text before
     they return.  Hence, the calling function can deallocate or
     modify the text after they return without harm.
     ^The sqlite3_result_error_code() function changes the error code
     returned by SQLite as a result of an error in a function.  ^By default,
     the error code is SQLITE_ERROR.  ^A subsequent call to sqlite3_result_error()
     or sqlite3_result_error16() resets the error code to SQLITE_ERROR.

     ^The sqlite3_result_error_toobig() interface causes SQLite to throw an
     error indicating that a string or BLOB is too long to represent.

     ^The sqlite3_result_error_nomem() interface causes SQLite to throw an
     error indicating that a memory allocation failed.

     ^The sqlite3_result_int() interface sets the return value
     of the application-defined function to be the 32-bit signed integer
     value given in the 2nd argument.
     ^The sqlite3_result_int64() interface sets the return value
     of the application-defined function to be the 64-bit signed integer
     value given in the 2nd argument.

     ^The sqlite3_result_null() interface sets the return value
     of the application-defined function to be NULL.

     ^The sqlite3_result_text(), sqlite3_result_text16(),
     sqlite3_result_text16le(), and sqlite3_result_text16be() interfaces
     set the return value of the application-defined function to be
     a text string which is represented as UTF-8, UTF-16 native byte order,
     UTF-16 little endian, or UTF-16 big endian, respectively.
     ^The sqlite3_result_text64() interface sets the return value of an
     application-defined function to be a text string in an encoding
     specified by the fifth (and last) parameter, which must be one
     of [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE].
     ^SQLite takes the text result from the application from
     the 2nd parameter of the sqlite3_result_text* interfaces.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is negative, then SQLite takes result text from the 2nd parameter
     through the first zero character.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is non-negative, then as many bytes (not characters) of the text
     pointed to by the 2nd parameter are taken as the application-defined
     function result.  If the 3rd parameter is non-negative, then it
     must be the byte offset into the string where the NUL terminator would
     appear if the string where NUL terminated.  If any NUL characters occur
     in the string at a byte offset that is less than the value of the 3rd
     parameter, then the resulting string will contain embedded NULs and the
     result of expressions operating on strings with embedded NULs is undefined.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is a non-NULL pointer, then SQLite calls that
     function as the destructor on the text or BLOB result when it has
     finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces or to
     sqlite3_result_blob is the special constant SQLITE_STATIC, then SQLite
     assumes that the text or BLOB result is in constant space and does not
     copy the content of the parameter nor call a destructor on the content
     when it has finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is the special constant SQLITE_TRANSIENT
     then SQLite makes a copy of the result into space obtained
     from [sqlite3_malloc()] before it returns.

     ^The sqlite3_result_value() interface sets the result of
     the application-defined function to be a copy of the
     [unprotected sqlite3_value] object specified by the 2nd parameter.  ^The
     sqlite3_result_value() interface makes a copy of the [sqlite3_value]
     so that the [sqlite3_value] specified in the parameter may change or
     be deallocated after sqlite3_result_value() returns without harm.
     ^A [protected sqlite3_value] object may always be used where an
     [unprotected sqlite3_value] object is required, so either
     kind of [sqlite3_value] object can be used with this interface.

     ^The sqlite3_result_pointer(C,P,T,D) interface sets the result to an
     SQL NULL value, just like [sqlite3_result_null(C)], except that it
     also associates the host-language pointer P or type T with that
     NULL value such that the pointer can be retrieved within an
     [application-defined SQL function] using [sqlite3_value_pointer()].
     ^If the D parameter is not NULL, then it is a pointer to a destructor
     for the P parameter.  ^SQLite invokes D with P as its only argument
     when SQLite is finished with P.  The T parameter should be a static
     string and preferably a string literal. The sqlite3_result_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     If these routines are called from within the different thread
     than the one containing the application-defined function that received
     the [sqlite3_context] pointer, the results are undefined.
     */
    @inlinable public func resultInt(_ int: Int32) {
        sqlite3_result_int(rawValue, int)
    }

    /**
     CAPI3REF: Setting The Result Of An SQL Function
     METHOD: sqlite3_context

     These routines are used by the xFunc or xFinal callbacks that
     implement SQL functions and aggregates.  See
     [sqlite3_create_function()] and [sqlite3_create_function16()]
     for additional information.

     These functions work very much like the [parameter binding] family of
     functions used to bind values to host parameters in prepared statements.
     Refer to the [SQL parameter] documentation for additional information.

     ^The sqlite3_result_blob() interface sets the result from
     an application-defined function to be the BLOB whose content is pointed
     to by the second parameter and which is N bytes long where N is the
     third parameter.

     ^The sqlite3_result_zeroblob(C,N) and sqlite3_result_zeroblob64(C,N)
     interfaces set the result of the application-defined function to be
     a BLOB containing all zero bytes and N bytes in size.

     ^The sqlite3_result_double() interface sets the result from
     an application-defined function to be a floating point value specified
     by its 2nd argument.

     ^The sqlite3_result_error() and sqlite3_result_error16() functions
     cause the implemented SQL function to throw an exception.
     ^SQLite uses the string pointed to by the
     2nd parameter of sqlite3_result_error() or sqlite3_result_error16()
     as the text of an error message.  ^SQLite interprets the error
     message string from sqlite3_result_error() as UTF-8. ^SQLite
     interprets the string from sqlite3_result_error16() as UTF-16 in native
     byte order.  ^If the third parameter to sqlite3_result_error()
     or sqlite3_result_error16() is negative then SQLite takes as the error
     message all text up through the first zero character.
     ^If the third parameter to sqlite3_result_error() or
     sqlite3_result_error16() is non-negative then SQLite takes that many
     bytes (not characters) from the 2nd parameter as the error message.
     ^The sqlite3_result_error() and sqlite3_result_error16()
     routines make a private copy of the error message text before
     they return.  Hence, the calling function can deallocate or
     modify the text after they return without harm.
     ^The sqlite3_result_error_code() function changes the error code
     returned by SQLite as a result of an error in a function.  ^By default,
     the error code is SQLITE_ERROR.  ^A subsequent call to sqlite3_result_error()
     or sqlite3_result_error16() resets the error code to SQLITE_ERROR.

     ^The sqlite3_result_error_toobig() interface causes SQLite to throw an
     error indicating that a string or BLOB is too long to represent.

     ^The sqlite3_result_error_nomem() interface causes SQLite to throw an
     error indicating that a memory allocation failed.

     ^The sqlite3_result_int() interface sets the return value
     of the application-defined function to be the 32-bit signed integer
     value given in the 2nd argument.
     ^The sqlite3_result_int64() interface sets the return value
     of the application-defined function to be the 64-bit signed integer
     value given in the 2nd argument.

     ^The sqlite3_result_null() interface sets the return value
     of the application-defined function to be NULL.

     ^The sqlite3_result_text(), sqlite3_result_text16(),
     sqlite3_result_text16le(), and sqlite3_result_text16be() interfaces
     set the return value of the application-defined function to be
     a text string which is represented as UTF-8, UTF-16 native byte order,
     UTF-16 little endian, or UTF-16 big endian, respectively.
     ^The sqlite3_result_text64() interface sets the return value of an
     application-defined function to be a text string in an encoding
     specified by the fifth (and last) parameter, which must be one
     of [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE].
     ^SQLite takes the text result from the application from
     the 2nd parameter of the sqlite3_result_text* interfaces.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is negative, then SQLite takes result text from the 2nd parameter
     through the first zero character.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is non-negative, then as many bytes (not characters) of the text
     pointed to by the 2nd parameter are taken as the application-defined
     function result.  If the 3rd parameter is non-negative, then it
     must be the byte offset into the string where the NUL terminator would
     appear if the string where NUL terminated.  If any NUL characters occur
     in the string at a byte offset that is less than the value of the 3rd
     parameter, then the resulting string will contain embedded NULs and the
     result of expressions operating on strings with embedded NULs is undefined.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is a non-NULL pointer, then SQLite calls that
     function as the destructor on the text or BLOB result when it has
     finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces or to
     sqlite3_result_blob is the special constant SQLITE_STATIC, then SQLite
     assumes that the text or BLOB result is in constant space and does not
     copy the content of the parameter nor call a destructor on the content
     when it has finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is the special constant SQLITE_TRANSIENT
     then SQLite makes a copy of the result into space obtained
     from [sqlite3_malloc()] before it returns.

     ^The sqlite3_result_value() interface sets the result of
     the application-defined function to be a copy of the
     [unprotected sqlite3_value] object specified by the 2nd parameter.  ^The
     sqlite3_result_value() interface makes a copy of the [sqlite3_value]
     so that the [sqlite3_value] specified in the parameter may change or
     be deallocated after sqlite3_result_value() returns without harm.
     ^A [protected sqlite3_value] object may always be used where an
     [unprotected sqlite3_value] object is required, so either
     kind of [sqlite3_value] object can be used with this interface.

     ^The sqlite3_result_pointer(C,P,T,D) interface sets the result to an
     SQL NULL value, just like [sqlite3_result_null(C)], except that it
     also associates the host-language pointer P or type T with that
     NULL value such that the pointer can be retrieved within an
     [application-defined SQL function] using [sqlite3_value_pointer()].
     ^If the D parameter is not NULL, then it is a pointer to a destructor
     for the P parameter.  ^SQLite invokes D with P as its only argument
     when SQLite is finished with P.  The T parameter should be a static
     string and preferably a string literal. The sqlite3_result_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     If these routines are called from within the different thread
     than the one containing the application-defined function that received
     the [sqlite3_context] pointer, the results are undefined.
     */
    @inlinable public func resultInt64(_ int64: sqlite3_int64) {
        sqlite3_result_int64(rawValue, int64)
    }

    /**
     CAPI3REF: Setting The Result Of An SQL Function
     METHOD: sqlite3_context

     These routines are used by the xFunc or xFinal callbacks that
     implement SQL functions and aggregates.  See
     [sqlite3_create_function()] and [sqlite3_create_function16()]
     for additional information.

     These functions work very much like the [parameter binding] family of
     functions used to bind values to host parameters in prepared statements.
     Refer to the [SQL parameter] documentation for additional information.

     ^The sqlite3_result_blob() interface sets the result from
     an application-defined function to be the BLOB whose content is pointed
     to by the second parameter and which is N bytes long where N is the
     third parameter.

     ^The sqlite3_result_zeroblob(C,N) and sqlite3_result_zeroblob64(C,N)
     interfaces set the result of the application-defined function to be
     a BLOB containing all zero bytes and N bytes in size.

     ^The sqlite3_result_double() interface sets the result from
     an application-defined function to be a floating point value specified
     by its 2nd argument.

     ^The sqlite3_result_error() and sqlite3_result_error16() functions
     cause the implemented SQL function to throw an exception.
     ^SQLite uses the string pointed to by the
     2nd parameter of sqlite3_result_error() or sqlite3_result_error16()
     as the text of an error message.  ^SQLite interprets the error
     message string from sqlite3_result_error() as UTF-8. ^SQLite
     interprets the string from sqlite3_result_error16() as UTF-16 in native
     byte order.  ^If the third parameter to sqlite3_result_error()
     or sqlite3_result_error16() is negative then SQLite takes as the error
     message all text up through the first zero character.
     ^If the third parameter to sqlite3_result_error() or
     sqlite3_result_error16() is non-negative then SQLite takes that many
     bytes (not characters) from the 2nd parameter as the error message.
     ^The sqlite3_result_error() and sqlite3_result_error16()
     routines make a private copy of the error message text before
     they return.  Hence, the calling function can deallocate or
     modify the text after they return without harm.
     ^The sqlite3_result_error_code() function changes the error code
     returned by SQLite as a result of an error in a function.  ^By default,
     the error code is SQLITE_ERROR.  ^A subsequent call to sqlite3_result_error()
     or sqlite3_result_error16() resets the error code to SQLITE_ERROR.

     ^The sqlite3_result_error_toobig() interface causes SQLite to throw an
     error indicating that a string or BLOB is too long to represent.

     ^The sqlite3_result_error_nomem() interface causes SQLite to throw an
     error indicating that a memory allocation failed.

     ^The sqlite3_result_int() interface sets the return value
     of the application-defined function to be the 32-bit signed integer
     value given in the 2nd argument.
     ^The sqlite3_result_int64() interface sets the return value
     of the application-defined function to be the 64-bit signed integer
     value given in the 2nd argument.

     ^The sqlite3_result_null() interface sets the return value
     of the application-defined function to be NULL.

     ^The sqlite3_result_text(), sqlite3_result_text16(),
     sqlite3_result_text16le(), and sqlite3_result_text16be() interfaces
     set the return value of the application-defined function to be
     a text string which is represented as UTF-8, UTF-16 native byte order,
     UTF-16 little endian, or UTF-16 big endian, respectively.
     ^The sqlite3_result_text64() interface sets the return value of an
     application-defined function to be a text string in an encoding
     specified by the fifth (and last) parameter, which must be one
     of [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE].
     ^SQLite takes the text result from the application from
     the 2nd parameter of the sqlite3_result_text* interfaces.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is negative, then SQLite takes result text from the 2nd parameter
     through the first zero character.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is non-negative, then as many bytes (not characters) of the text
     pointed to by the 2nd parameter are taken as the application-defined
     function result.  If the 3rd parameter is non-negative, then it
     must be the byte offset into the string where the NUL terminator would
     appear if the string where NUL terminated.  If any NUL characters occur
     in the string at a byte offset that is less than the value of the 3rd
     parameter, then the resulting string will contain embedded NULs and the
     result of expressions operating on strings with embedded NULs is undefined.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is a non-NULL pointer, then SQLite calls that
     function as the destructor on the text or BLOB result when it has
     finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces or to
     sqlite3_result_blob is the special constant SQLITE_STATIC, then SQLite
     assumes that the text or BLOB result is in constant space and does not
     copy the content of the parameter nor call a destructor on the content
     when it has finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is the special constant SQLITE_TRANSIENT
     then SQLite makes a copy of the result into space obtained
     from [sqlite3_malloc()] before it returns.

     ^The sqlite3_result_value() interface sets the result of
     the application-defined function to be a copy of the
     [unprotected sqlite3_value] object specified by the 2nd parameter.  ^The
     sqlite3_result_value() interface makes a copy of the [sqlite3_value]
     so that the [sqlite3_value] specified in the parameter may change or
     be deallocated after sqlite3_result_value() returns without harm.
     ^A [protected sqlite3_value] object may always be used where an
     [unprotected sqlite3_value] object is required, so either
     kind of [sqlite3_value] object can be used with this interface.

     ^The sqlite3_result_pointer(C,P,T,D) interface sets the result to an
     SQL NULL value, just like [sqlite3_result_null(C)], except that it
     also associates the host-language pointer P or type T with that
     NULL value such that the pointer can be retrieved within an
     [application-defined SQL function] using [sqlite3_value_pointer()].
     ^If the D parameter is not NULL, then it is a pointer to a destructor
     for the P parameter.  ^SQLite invokes D with P as its only argument
     when SQLite is finished with P.  The T parameter should be a static
     string and preferably a string literal. The sqlite3_result_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     If these routines are called from within the different thread
     than the one containing the application-defined function that received
     the [sqlite3_context] pointer, the results are undefined.
     */
    @inlinable public func resultNull() {
        sqlite3_result_null(rawValue)
    }

    /**
     CAPI3REF: Setting The Result Of An SQL Function
     METHOD: sqlite3_context

     These routines are used by the xFunc or xFinal callbacks that
     implement SQL functions and aggregates.  See
     [sqlite3_create_function()] and [sqlite3_create_function16()]
     for additional information.

     These functions work very much like the [parameter binding] family of
     functions used to bind values to host parameters in prepared statements.
     Refer to the [SQL parameter] documentation for additional information.

     ^The sqlite3_result_blob() interface sets the result from
     an application-defined function to be the BLOB whose content is pointed
     to by the second parameter and which is N bytes long where N is the
     third parameter.

     ^The sqlite3_result_zeroblob(C,N) and sqlite3_result_zeroblob64(C,N)
     interfaces set the result of the application-defined function to be
     a BLOB containing all zero bytes and N bytes in size.

     ^The sqlite3_result_double() interface sets the result from
     an application-defined function to be a floating point value specified
     by its 2nd argument.

     ^The sqlite3_result_error() and sqlite3_result_error16() functions
     cause the implemented SQL function to throw an exception.
     ^SQLite uses the string pointed to by the
     2nd parameter of sqlite3_result_error() or sqlite3_result_error16()
     as the text of an error message.  ^SQLite interprets the error
     message string from sqlite3_result_error() as UTF-8. ^SQLite
     interprets the string from sqlite3_result_error16() as UTF-16 in native
     byte order.  ^If the third parameter to sqlite3_result_error()
     or sqlite3_result_error16() is negative then SQLite takes as the error
     message all text up through the first zero character.
     ^If the third parameter to sqlite3_result_error() or
     sqlite3_result_error16() is non-negative then SQLite takes that many
     bytes (not characters) from the 2nd parameter as the error message.
     ^The sqlite3_result_error() and sqlite3_result_error16()
     routines make a private copy of the error message text before
     they return.  Hence, the calling function can deallocate or
     modify the text after they return without harm.
     ^The sqlite3_result_error_code() function changes the error code
     returned by SQLite as a result of an error in a function.  ^By default,
     the error code is SQLITE_ERROR.  ^A subsequent call to sqlite3_result_error()
     or sqlite3_result_error16() resets the error code to SQLITE_ERROR.

     ^The sqlite3_result_error_toobig() interface causes SQLite to throw an
     error indicating that a string or BLOB is too long to represent.

     ^The sqlite3_result_error_nomem() interface causes SQLite to throw an
     error indicating that a memory allocation failed.

     ^The sqlite3_result_int() interface sets the return value
     of the application-defined function to be the 32-bit signed integer
     value given in the 2nd argument.
     ^The sqlite3_result_int64() interface sets the return value
     of the application-defined function to be the 64-bit signed integer
     value given in the 2nd argument.

     ^The sqlite3_result_null() interface sets the return value
     of the application-defined function to be NULL.

     ^The sqlite3_result_text(), sqlite3_result_text16(),
     sqlite3_result_text16le(), and sqlite3_result_text16be() interfaces
     set the return value of the application-defined function to be
     a text string which is represented as UTF-8, UTF-16 native byte order,
     UTF-16 little endian, or UTF-16 big endian, respectively.
     ^The sqlite3_result_text64() interface sets the return value of an
     application-defined function to be a text string in an encoding
     specified by the fifth (and last) parameter, which must be one
     of [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE].
     ^SQLite takes the text result from the application from
     the 2nd parameter of the sqlite3_result_text* interfaces.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is negative, then SQLite takes result text from the 2nd parameter
     through the first zero character.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is non-negative, then as many bytes (not characters) of the text
     pointed to by the 2nd parameter are taken as the application-defined
     function result.  If the 3rd parameter is non-negative, then it
     must be the byte offset into the string where the NUL terminator would
     appear if the string where NUL terminated.  If any NUL characters occur
     in the string at a byte offset that is less than the value of the 3rd
     parameter, then the resulting string will contain embedded NULs and the
     result of expressions operating on strings with embedded NULs is undefined.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is a non-NULL pointer, then SQLite calls that
     function as the destructor on the text or BLOB result when it has
     finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces or to
     sqlite3_result_blob is the special constant SQLITE_STATIC, then SQLite
     assumes that the text or BLOB result is in constant space and does not
     copy the content of the parameter nor call a destructor on the content
     when it has finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is the special constant SQLITE_TRANSIENT
     then SQLite makes a copy of the result into space obtained
     from [sqlite3_malloc()] before it returns.

     ^The sqlite3_result_value() interface sets the result of
     the application-defined function to be a copy of the
     [unprotected sqlite3_value] object specified by the 2nd parameter.  ^The
     sqlite3_result_value() interface makes a copy of the [sqlite3_value]
     so that the [sqlite3_value] specified in the parameter may change or
     be deallocated after sqlite3_result_value() returns without harm.
     ^A [protected sqlite3_value] object may always be used where an
     [unprotected sqlite3_value] object is required, so either
     kind of [sqlite3_value] object can be used with this interface.

     ^The sqlite3_result_pointer(C,P,T,D) interface sets the result to an
     SQL NULL value, just like [sqlite3_result_null(C)], except that it
     also associates the host-language pointer P or type T with that
     NULL value such that the pointer can be retrieved within an
     [application-defined SQL function] using [sqlite3_value_pointer()].
     ^If the D parameter is not NULL, then it is a pointer to a destructor
     for the P parameter.  ^SQLite invokes D with P as its only argument
     when SQLite is finished with P.  The T parameter should be a static
     string and preferably a string literal. The sqlite3_result_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     If these routines are called from within the different thread
     than the one containing the application-defined function that received
     the [sqlite3_context] pointer, the results are undefined.
     */
    @inlinable public func resultText(_ text: UnsafePointer<Int8>, length: Int32, destructor: ResultTextDestructor? = nil) {
        sqlite3_result_text(rawValue, text, length, destructor)
    }

    /**
     CAPI3REF: Setting The Result Of An SQL Function
     METHOD: sqlite3_context

     These routines are used by the xFunc or xFinal callbacks that
     implement SQL functions and aggregates.  See
     [sqlite3_create_function()] and [sqlite3_create_function16()]
     for additional information.

     These functions work very much like the [parameter binding] family of
     functions used to bind values to host parameters in prepared statements.
     Refer to the [SQL parameter] documentation for additional information.

     ^The sqlite3_result_blob() interface sets the result from
     an application-defined function to be the BLOB whose content is pointed
     to by the second parameter and which is N bytes long where N is the
     third parameter.

     ^The sqlite3_result_zeroblob(C,N) and sqlite3_result_zeroblob64(C,N)
     interfaces set the result of the application-defined function to be
     a BLOB containing all zero bytes and N bytes in size.

     ^The sqlite3_result_double() interface sets the result from
     an application-defined function to be a floating point value specified
     by its 2nd argument.

     ^The sqlite3_result_error() and sqlite3_result_error16() functions
     cause the implemented SQL function to throw an exception.
     ^SQLite uses the string pointed to by the
     2nd parameter of sqlite3_result_error() or sqlite3_result_error16()
     as the text of an error message.  ^SQLite interprets the error
     message string from sqlite3_result_error() as UTF-8. ^SQLite
     interprets the string from sqlite3_result_error16() as UTF-16 in native
     byte order.  ^If the third parameter to sqlite3_result_error()
     or sqlite3_result_error16() is negative then SQLite takes as the error
     message all text up through the first zero character.
     ^If the third parameter to sqlite3_result_error() or
     sqlite3_result_error16() is non-negative then SQLite takes that many
     bytes (not characters) from the 2nd parameter as the error message.
     ^The sqlite3_result_error() and sqlite3_result_error16()
     routines make a private copy of the error message text before
     they return.  Hence, the calling function can deallocate or
     modify the text after they return without harm.
     ^The sqlite3_result_error_code() function changes the error code
     returned by SQLite as a result of an error in a function.  ^By default,
     the error code is SQLITE_ERROR.  ^A subsequent call to sqlite3_result_error()
     or sqlite3_result_error16() resets the error code to SQLITE_ERROR.

     ^The sqlite3_result_error_toobig() interface causes SQLite to throw an
     error indicating that a string or BLOB is too long to represent.

     ^The sqlite3_result_error_nomem() interface causes SQLite to throw an
     error indicating that a memory allocation failed.

     ^The sqlite3_result_int() interface sets the return value
     of the application-defined function to be the 32-bit signed integer
     value given in the 2nd argument.
     ^The sqlite3_result_int64() interface sets the return value
     of the application-defined function to be the 64-bit signed integer
     value given in the 2nd argument.

     ^The sqlite3_result_null() interface sets the return value
     of the application-defined function to be NULL.

     ^The sqlite3_result_text(), sqlite3_result_text16(),
     sqlite3_result_text16le(), and sqlite3_result_text16be() interfaces
     set the return value of the application-defined function to be
     a text string which is represented as UTF-8, UTF-16 native byte order,
     UTF-16 little endian, or UTF-16 big endian, respectively.
     ^The sqlite3_result_text64() interface sets the return value of an
     application-defined function to be a text string in an encoding
     specified by the fifth (and last) parameter, which must be one
     of [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE].
     ^SQLite takes the text result from the application from
     the 2nd parameter of the sqlite3_result_text* interfaces.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is negative, then SQLite takes result text from the 2nd parameter
     through the first zero character.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is non-negative, then as many bytes (not characters) of the text
     pointed to by the 2nd parameter are taken as the application-defined
     function result.  If the 3rd parameter is non-negative, then it
     must be the byte offset into the string where the NUL terminator would
     appear if the string where NUL terminated.  If any NUL characters occur
     in the string at a byte offset that is less than the value of the 3rd
     parameter, then the resulting string will contain embedded NULs and the
     result of expressions operating on strings with embedded NULs is undefined.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is a non-NULL pointer, then SQLite calls that
     function as the destructor on the text or BLOB result when it has
     finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces or to
     sqlite3_result_blob is the special constant SQLITE_STATIC, then SQLite
     assumes that the text or BLOB result is in constant space and does not
     copy the content of the parameter nor call a destructor on the content
     when it has finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is the special constant SQLITE_TRANSIENT
     then SQLite makes a copy of the result into space obtained
     from [sqlite3_malloc()] before it returns.

     ^The sqlite3_result_value() interface sets the result of
     the application-defined function to be a copy of the
     [unprotected sqlite3_value] object specified by the 2nd parameter.  ^The
     sqlite3_result_value() interface makes a copy of the [sqlite3_value]
     so that the [sqlite3_value] specified in the parameter may change or
     be deallocated after sqlite3_result_value() returns without harm.
     ^A [protected sqlite3_value] object may always be used where an
     [unprotected sqlite3_value] object is required, so either
     kind of [sqlite3_value] object can be used with this interface.

     ^The sqlite3_result_pointer(C,P,T,D) interface sets the result to an
     SQL NULL value, just like [sqlite3_result_null(C)], except that it
     also associates the host-language pointer P or type T with that
     NULL value such that the pointer can be retrieved within an
     [application-defined SQL function] using [sqlite3_value_pointer()].
     ^If the D parameter is not NULL, then it is a pointer to a destructor
     for the P parameter.  ^SQLite invokes D with P as its only argument
     when SQLite is finished with P.  The T parameter should be a static
     string and preferably a string literal. The sqlite3_result_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     If these routines are called from within the different thread
     than the one containing the application-defined function that received
     the [sqlite3_context] pointer, the results are undefined.
     */
    @inlinable public func resultTransientText(_ text: UnsafePointer<Int8>, length: Int32) {
        lsqlite3_result_transient_text(rawValue, text, length)
    }

    /**
     CAPI3REF: Setting The Result Of An SQL Function
     METHOD: sqlite3_context

     These routines are used by the xFunc or xFinal callbacks that
     implement SQL functions and aggregates.  See
     [sqlite3_create_function()] and [sqlite3_create_function16()]
     for additional information.

     These functions work very much like the [parameter binding] family of
     functions used to bind values to host parameters in prepared statements.
     Refer to the [SQL parameter] documentation for additional information.

     ^The sqlite3_result_blob() interface sets the result from
     an application-defined function to be the BLOB whose content is pointed
     to by the second parameter and which is N bytes long where N is the
     third parameter.

     ^The sqlite3_result_zeroblob(C,N) and sqlite3_result_zeroblob64(C,N)
     interfaces set the result of the application-defined function to be
     a BLOB containing all zero bytes and N bytes in size.

     ^The sqlite3_result_double() interface sets the result from
     an application-defined function to be a floating point value specified
     by its 2nd argument.

     ^The sqlite3_result_error() and sqlite3_result_error16() functions
     cause the implemented SQL function to throw an exception.
     ^SQLite uses the string pointed to by the
     2nd parameter of sqlite3_result_error() or sqlite3_result_error16()
     as the text of an error message.  ^SQLite interprets the error
     message string from sqlite3_result_error() as UTF-8. ^SQLite
     interprets the string from sqlite3_result_error16() as UTF-16 in native
     byte order.  ^If the third parameter to sqlite3_result_error()
     or sqlite3_result_error16() is negative then SQLite takes as the error
     message all text up through the first zero character.
     ^If the third parameter to sqlite3_result_error() or
     sqlite3_result_error16() is non-negative then SQLite takes that many
     bytes (not characters) from the 2nd parameter as the error message.
     ^The sqlite3_result_error() and sqlite3_result_error16()
     routines make a private copy of the error message text before
     they return.  Hence, the calling function can deallocate or
     modify the text after they return without harm.
     ^The sqlite3_result_error_code() function changes the error code
     returned by SQLite as a result of an error in a function.  ^By default,
     the error code is SQLITE_ERROR.  ^A subsequent call to sqlite3_result_error()
     or sqlite3_result_error16() resets the error code to SQLITE_ERROR.

     ^The sqlite3_result_error_toobig() interface causes SQLite to throw an
     error indicating that a string or BLOB is too long to represent.

     ^The sqlite3_result_error_nomem() interface causes SQLite to throw an
     error indicating that a memory allocation failed.

     ^The sqlite3_result_int() interface sets the return value
     of the application-defined function to be the 32-bit signed integer
     value given in the 2nd argument.
     ^The sqlite3_result_int64() interface sets the return value
     of the application-defined function to be the 64-bit signed integer
     value given in the 2nd argument.

     ^The sqlite3_result_null() interface sets the return value
     of the application-defined function to be NULL.

     ^The sqlite3_result_text(), sqlite3_result_text16(),
     sqlite3_result_text16le(), and sqlite3_result_text16be() interfaces
     set the return value of the application-defined function to be
     a text string which is represented as UTF-8, UTF-16 native byte order,
     UTF-16 little endian, or UTF-16 big endian, respectively.
     ^The sqlite3_result_text64() interface sets the return value of an
     application-defined function to be a text string in an encoding
     specified by the fifth (and last) parameter, which must be one
     of [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE].
     ^SQLite takes the text result from the application from
     the 2nd parameter of the sqlite3_result_text* interfaces.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is negative, then SQLite takes result text from the 2nd parameter
     through the first zero character.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is non-negative, then as many bytes (not characters) of the text
     pointed to by the 2nd parameter are taken as the application-defined
     function result.  If the 3rd parameter is non-negative, then it
     must be the byte offset into the string where the NUL terminator would
     appear if the string where NUL terminated.  If any NUL characters occur
     in the string at a byte offset that is less than the value of the 3rd
     parameter, then the resulting string will contain embedded NULs and the
     result of expressions operating on strings with embedded NULs is undefined.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is a non-NULL pointer, then SQLite calls that
     function as the destructor on the text or BLOB result when it has
     finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces or to
     sqlite3_result_blob is the special constant SQLITE_STATIC, then SQLite
     assumes that the text or BLOB result is in constant space and does not
     copy the content of the parameter nor call a destructor on the content
     when it has finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is the special constant SQLITE_TRANSIENT
     then SQLite makes a copy of the result into space obtained
     from [sqlite3_malloc()] before it returns.

     ^The sqlite3_result_value() interface sets the result of
     the application-defined function to be a copy of the
     [unprotected sqlite3_value] object specified by the 2nd parameter.  ^The
     sqlite3_result_value() interface makes a copy of the [sqlite3_value]
     so that the [sqlite3_value] specified in the parameter may change or
     be deallocated after sqlite3_result_value() returns without harm.
     ^A [protected sqlite3_value] object may always be used where an
     [unprotected sqlite3_value] object is required, so either
     kind of [sqlite3_value] object can be used with this interface.

     ^The sqlite3_result_pointer(C,P,T,D) interface sets the result to an
     SQL NULL value, just like [sqlite3_result_null(C)], except that it
     also associates the host-language pointer P or type T with that
     NULL value such that the pointer can be retrieved within an
     [application-defined SQL function] using [sqlite3_value_pointer()].
     ^If the D parameter is not NULL, then it is a pointer to a destructor
     for the P parameter.  ^SQLite invokes D with P as its only argument
     when SQLite is finished with P.  The T parameter should be a static
     string and preferably a string literal. The sqlite3_result_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     If these routines are called from within the different thread
     than the one containing the application-defined function that received
     the [sqlite3_context] pointer, the results are undefined.
     */
    @inlinable public func resultStaticText(_ text: UnsafePointer<Int8>, length: Int32) {
        lsqlite3_result_static_text(rawValue, text, length)
    }

    /**
     CAPI3REF: Setting The Result Of An SQL Function
     METHOD: sqlite3_context

     These routines are used by the xFunc or xFinal callbacks that
     implement SQL functions and aggregates.  See
     [sqlite3_create_function()] and [sqlite3_create_function16()]
     for additional information.

     These functions work very much like the [parameter binding] family of
     functions used to bind values to host parameters in prepared statements.
     Refer to the [SQL parameter] documentation for additional information.

     ^The sqlite3_result_blob() interface sets the result from
     an application-defined function to be the BLOB whose content is pointed
     to by the second parameter and which is N bytes long where N is the
     third parameter.

     ^The sqlite3_result_zeroblob(C,N) and sqlite3_result_zeroblob64(C,N)
     interfaces set the result of the application-defined function to be
     a BLOB containing all zero bytes and N bytes in size.

     ^The sqlite3_result_double() interface sets the result from
     an application-defined function to be a floating point value specified
     by its 2nd argument.

     ^The sqlite3_result_error() and sqlite3_result_error16() functions
     cause the implemented SQL function to throw an exception.
     ^SQLite uses the string pointed to by the
     2nd parameter of sqlite3_result_error() or sqlite3_result_error16()
     as the text of an error message.  ^SQLite interprets the error
     message string from sqlite3_result_error() as UTF-8. ^SQLite
     interprets the string from sqlite3_result_error16() as UTF-16 in native
     byte order.  ^If the third parameter to sqlite3_result_error()
     or sqlite3_result_error16() is negative then SQLite takes as the error
     message all text up through the first zero character.
     ^If the third parameter to sqlite3_result_error() or
     sqlite3_result_error16() is non-negative then SQLite takes that many
     bytes (not characters) from the 2nd parameter as the error message.
     ^The sqlite3_result_error() and sqlite3_result_error16()
     routines make a private copy of the error message text before
     they return.  Hence, the calling function can deallocate or
     modify the text after they return without harm.
     ^The sqlite3_result_error_code() function changes the error code
     returned by SQLite as a result of an error in a function.  ^By default,
     the error code is SQLITE_ERROR.  ^A subsequent call to sqlite3_result_error()
     or sqlite3_result_error16() resets the error code to SQLITE_ERROR.

     ^The sqlite3_result_error_toobig() interface causes SQLite to throw an
     error indicating that a string or BLOB is too long to represent.

     ^The sqlite3_result_error_nomem() interface causes SQLite to throw an
     error indicating that a memory allocation failed.

     ^The sqlite3_result_int() interface sets the return value
     of the application-defined function to be the 32-bit signed integer
     value given in the 2nd argument.
     ^The sqlite3_result_int64() interface sets the return value
     of the application-defined function to be the 64-bit signed integer
     value given in the 2nd argument.

     ^The sqlite3_result_null() interface sets the return value
     of the application-defined function to be NULL.

     ^The sqlite3_result_text(), sqlite3_result_text16(),
     sqlite3_result_text16le(), and sqlite3_result_text16be() interfaces
     set the return value of the application-defined function to be
     a text string which is represented as UTF-8, UTF-16 native byte order,
     UTF-16 little endian, or UTF-16 big endian, respectively.
     ^The sqlite3_result_text64() interface sets the return value of an
     application-defined function to be a text string in an encoding
     specified by the fifth (and last) parameter, which must be one
     of [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE].
     ^SQLite takes the text result from the application from
     the 2nd parameter of the sqlite3_result_text* interfaces.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is negative, then SQLite takes result text from the 2nd parameter
     through the first zero character.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is non-negative, then as many bytes (not characters) of the text
     pointed to by the 2nd parameter are taken as the application-defined
     function result.  If the 3rd parameter is non-negative, then it
     must be the byte offset into the string where the NUL terminator would
     appear if the string where NUL terminated.  If any NUL characters occur
     in the string at a byte offset that is less than the value of the 3rd
     parameter, then the resulting string will contain embedded NULs and the
     result of expressions operating on strings with embedded NULs is undefined.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is a non-NULL pointer, then SQLite calls that
     function as the destructor on the text or BLOB result when it has
     finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces or to
     sqlite3_result_blob is the special constant SQLITE_STATIC, then SQLite
     assumes that the text or BLOB result is in constant space and does not
     copy the content of the parameter nor call a destructor on the content
     when it has finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is the special constant SQLITE_TRANSIENT
     then SQLite makes a copy of the result into space obtained
     from [sqlite3_malloc()] before it returns.

     ^The sqlite3_result_value() interface sets the result of
     the application-defined function to be a copy of the
     [unprotected sqlite3_value] object specified by the 2nd parameter.  ^The
     sqlite3_result_value() interface makes a copy of the [sqlite3_value]
     so that the [sqlite3_value] specified in the parameter may change or
     be deallocated after sqlite3_result_value() returns without harm.
     ^A [protected sqlite3_value] object may always be used where an
     [unprotected sqlite3_value] object is required, so either
     kind of [sqlite3_value] object can be used with this interface.

     ^The sqlite3_result_pointer(C,P,T,D) interface sets the result to an
     SQL NULL value, just like [sqlite3_result_null(C)], except that it
     also associates the host-language pointer P or type T with that
     NULL value such that the pointer can be retrieved within an
     [application-defined SQL function] using [sqlite3_value_pointer()].
     ^If the D parameter is not NULL, then it is a pointer to a destructor
     for the P parameter.  ^SQLite invokes D with P as its only argument
     when SQLite is finished with P.  The T parameter should be a static
     string and preferably a string literal. The sqlite3_result_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     If these routines are called from within the different thread
     than the one containing the application-defined function that received
     the [sqlite3_context] pointer, the results are undefined.
     */
    @inlinable public func resultValue(_ value: Value) {
        sqlite3_result_value(rawValue, value.rawValue)
    }

    /**
     CAPI3REF: Setting The Result Of An SQL Function
     METHOD: sqlite3_context

     These routines are used by the xFunc or xFinal callbacks that
     implement SQL functions and aggregates.  See
     [sqlite3_create_function()] and [sqlite3_create_function16()]
     for additional information.

     These functions work very much like the [parameter binding] family of
     functions used to bind values to host parameters in prepared statements.
     Refer to the [SQL parameter] documentation for additional information.

     ^The sqlite3_result_blob() interface sets the result from
     an application-defined function to be the BLOB whose content is pointed
     to by the second parameter and which is N bytes long where N is the
     third parameter.

     ^The sqlite3_result_zeroblob(C,N) and sqlite3_result_zeroblob64(C,N)
     interfaces set the result of the application-defined function to be
     a BLOB containing all zero bytes and N bytes in size.

     ^The sqlite3_result_double() interface sets the result from
     an application-defined function to be a floating point value specified
     by its 2nd argument.

     ^The sqlite3_result_error() and sqlite3_result_error16() functions
     cause the implemented SQL function to throw an exception.
     ^SQLite uses the string pointed to by the
     2nd parameter of sqlite3_result_error() or sqlite3_result_error16()
     as the text of an error message.  ^SQLite interprets the error
     message string from sqlite3_result_error() as UTF-8. ^SQLite
     interprets the string from sqlite3_result_error16() as UTF-16 in native
     byte order.  ^If the third parameter to sqlite3_result_error()
     or sqlite3_result_error16() is negative then SQLite takes as the error
     message all text up through the first zero character.
     ^If the third parameter to sqlite3_result_error() or
     sqlite3_result_error16() is non-negative then SQLite takes that many
     bytes (not characters) from the 2nd parameter as the error message.
     ^The sqlite3_result_error() and sqlite3_result_error16()
     routines make a private copy of the error message text before
     they return.  Hence, the calling function can deallocate or
     modify the text after they return without harm.
     ^The sqlite3_result_error_code() function changes the error code
     returned by SQLite as a result of an error in a function.  ^By default,
     the error code is SQLITE_ERROR.  ^A subsequent call to sqlite3_result_error()
     or sqlite3_result_error16() resets the error code to SQLITE_ERROR.

     ^The sqlite3_result_error_toobig() interface causes SQLite to throw an
     error indicating that a string or BLOB is too long to represent.

     ^The sqlite3_result_error_nomem() interface causes SQLite to throw an
     error indicating that a memory allocation failed.

     ^The sqlite3_result_int() interface sets the return value
     of the application-defined function to be the 32-bit signed integer
     value given in the 2nd argument.
     ^The sqlite3_result_int64() interface sets the return value
     of the application-defined function to be the 64-bit signed integer
     value given in the 2nd argument.

     ^The sqlite3_result_null() interface sets the return value
     of the application-defined function to be NULL.

     ^The sqlite3_result_text(), sqlite3_result_text16(),
     sqlite3_result_text16le(), and sqlite3_result_text16be() interfaces
     set the return value of the application-defined function to be
     a text string which is represented as UTF-8, UTF-16 native byte order,
     UTF-16 little endian, or UTF-16 big endian, respectively.
     ^The sqlite3_result_text64() interface sets the return value of an
     application-defined function to be a text string in an encoding
     specified by the fifth (and last) parameter, which must be one
     of [SQLITE_UTF8], [SQLITE_UTF16], [SQLITE_UTF16BE], or [SQLITE_UTF16LE].
     ^SQLite takes the text result from the application from
     the 2nd parameter of the sqlite3_result_text* interfaces.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is negative, then SQLite takes result text from the 2nd parameter
     through the first zero character.
     ^If the 3rd parameter to the sqlite3_result_text* interfaces
     is non-negative, then as many bytes (not characters) of the text
     pointed to by the 2nd parameter are taken as the application-defined
     function result.  If the 3rd parameter is non-negative, then it
     must be the byte offset into the string where the NUL terminator would
     appear if the string where NUL terminated.  If any NUL characters occur
     in the string at a byte offset that is less than the value of the 3rd
     parameter, then the resulting string will contain embedded NULs and the
     result of expressions operating on strings with embedded NULs is undefined.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is a non-NULL pointer, then SQLite calls that
     function as the destructor on the text or BLOB result when it has
     finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces or to
     sqlite3_result_blob is the special constant SQLITE_STATIC, then SQLite
     assumes that the text or BLOB result is in constant space and does not
     copy the content of the parameter nor call a destructor on the content
     when it has finished using that result.
     ^If the 4th parameter to the sqlite3_result_text* interfaces
     or sqlite3_result_blob is the special constant SQLITE_TRANSIENT
     then SQLite makes a copy of the result into space obtained
     from [sqlite3_malloc()] before it returns.

     ^The sqlite3_result_value() interface sets the result of
     the application-defined function to be a copy of the
     [unprotected sqlite3_value] object specified by the 2nd parameter.  ^The
     sqlite3_result_value() interface makes a copy of the [sqlite3_value]
     so that the [sqlite3_value] specified in the parameter may change or
     be deallocated after sqlite3_result_value() returns without harm.
     ^A [protected sqlite3_value] object may always be used where an
     [unprotected sqlite3_value] object is required, so either
     kind of [sqlite3_value] object can be used with this interface.

     ^The sqlite3_result_pointer(C,P,T,D) interface sets the result to an
     SQL NULL value, just like [sqlite3_result_null(C)], except that it
     also associates the host-language pointer P or type T with that
     NULL value such that the pointer can be retrieved within an
     [application-defined SQL function] using [sqlite3_value_pointer()].
     ^If the D parameter is not NULL, then it is a pointer to a destructor
     for the P parameter.  ^SQLite invokes D with P as its only argument
     when SQLite is finished with P.  The T parameter should be a static
     string and preferably a string literal. The sqlite3_result_pointer()
     routine is part of the [pointer passing interface] added for SQLite 3.20.0.

     If these routines are called from within the different thread
     than the one containing the application-defined function that received
     the [sqlite3_context] pointer, the results are undefined.
     */
    @inlinable public func resultZeroBlob(length: Int32) {
        sqlite3_result_zeroblob(rawValue, length)
    }

    /**
     CAPI3REF: Setting The Subtype Of An SQL Function
     METHOD: sqlite3_context

     The sqlite3_result_subtype(C,T) function causes the subtype of
     the result from the [application-defined SQL function] with
     [sqlite3_context] C to be the value T.  Only the lower 8 bits
     of the subtype T are preserved in current versions of SQLite;
     higher order bits are discarded.
     The number of subtype bytes preserved by SQLite might increase
     in future releases of SQLite.
     */
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    @inlinable public func resultSubtype(_ subtype: Subtype) {
        sqlite3_result_subtype(rawValue, subtype.rawValue)
    }
}
