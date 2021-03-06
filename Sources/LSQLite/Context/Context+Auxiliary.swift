import MissedSwiftSQLite

extension Context {
    public typealias AuxiliaryDataDestructor = @convention(c) (UnsafeMutableRawPointer?) -> Void

    /**
     CAPI3REF: Function Auxiliary Data
     METHOD: sqlite3_context

     These functions may be used by (non-aggregate) SQL functions to
     associate metadata with argument values. If the same value is passed to
     multiple invocations of the same SQL function during query execution, under
     some circumstances the associated metadata may be preserved.  An example
     of where this might be useful is in a regular-expression matching
     function. The compiled version of the regular expression can be stored as
     metadata associated with the pattern string.
     Then as long as the pattern string remains the same,
     the compiled regular expression can be reused on multiple
     invocations of the same function.

     ^The sqlite3_get_auxdata(C,N) interface returns a pointer to the metadata
     associated by the sqlite3_set_auxdata(C,N,P,X) function with the Nth argument
     value to the application-defined function.  ^N is zero for the left-most
     function argument.  ^If there is no metadata
     associated with the function argument, the sqlite3_get_auxdata(C,N) interface
     returns a NULL pointer.

     ^The sqlite3_set_auxdata(C,N,P,X) interface saves P as metadata for the N-th
     argument of the application-defined function.  ^Subsequent
     calls to sqlite3_get_auxdata(C,N) return P from the most recent
     sqlite3_set_auxdata(C,N,P,X) call if the metadata is still valid or
     NULL if the metadata has been discarded.
     ^After each call to sqlite3_set_auxdata(C,N,P,X) where X is not NULL,
     SQLite will invoke the destructor function X with parameter P exactly
     once, when the metadata is discarded.
     SQLite is free to discard the metadata at any time, including: 
      ^(when the corresponding function parameter changes)^, or
      ^(when [sqlite3_reset()] or [sqlite3_finalize()] is called for the
     SQL statement)^, or
      ^(when sqlite3_set_auxdata() is invoked again on the same
     parameter)^, or
      ^(during the original sqlite3_set_auxdata() call when a memory
     allocation error occurs.)^ 

     Note the last bullet in particular.  The destructor X in
     sqlite3_set_auxdata(C,N,P,X) might be called immediately, before the
     sqlite3_set_auxdata() interface even returns.  Hence sqlite3_set_auxdata()
     should be called near the end of the function implementation and the
     function implementation should not make any use of P after
     sqlite3_set_auxdata() has been called.

     ^(In practice, metadata is preserved between function calls for
     function parameters that are compile-time constants, including literal
     values and [parameters] and expressions composed from the same.)^

     The value of the N parameter to these interfaces should be non-negative.
     Future enhancements may make use of negative N values to define new
     kinds of function caching behavior.

     These routines must be called from the same thread in which
     the SQL function is running.
     */
    @inlinable public func getAuxiliaryData(forArgument argument: Int32) -> UnsafeMutableRawPointer? {
        sqlite3_get_auxdata(rawValue, argument)
    }

    /**
     CAPI3REF: Function Auxiliary Data
     METHOD: sqlite3_context

     These functions may be used by (non-aggregate) SQL functions to
     associate metadata with argument values. If the same value is passed to
     multiple invocations of the same SQL function during query execution, under
     some circumstances the associated metadata may be preserved.  An example
     of where this might be useful is in a regular-expression matching
     function. The compiled version of the regular expression can be stored as
     metadata associated with the pattern string.
     Then as long as the pattern string remains the same,
     the compiled regular expression can be reused on multiple
     invocations of the same function.

     ^The sqlite3_get_auxdata(C,N) interface returns a pointer to the metadata
     associated by the sqlite3_set_auxdata(C,N,P,X) function with the Nth argument
     value to the application-defined function.  ^N is zero for the left-most
     function argument.  ^If there is no metadata
     associated with the function argument, the sqlite3_get_auxdata(C,N) interface
     returns a NULL pointer.

     ^The sqlite3_set_auxdata(C,N,P,X) interface saves P as metadata for the N-th
     argument of the application-defined function.  ^Subsequent
     calls to sqlite3_get_auxdata(C,N) return P from the most recent
     sqlite3_set_auxdata(C,N,P,X) call if the metadata is still valid or
     NULL if the metadata has been discarded.
     ^After each call to sqlite3_set_auxdata(C,N,P,X) where X is not NULL,
     SQLite will invoke the destructor function X with parameter P exactly
     once, when the metadata is discarded.
     SQLite is free to discard the metadata at any time, including: 
      ^(when the corresponding function parameter changes)^, or
      ^(when [sqlite3_reset()] or [sqlite3_finalize()] is called for the
     SQL statement)^, or
      ^(when sqlite3_set_auxdata() is invoked again on the same
     parameter)^, or
      ^(during the original sqlite3_set_auxdata() call when a memory
     allocation error occurs.)^ 

     Note the last bullet in particular.  The destructor X in
     sqlite3_set_auxdata(C,N,P,X) might be called immediately, before the
     sqlite3_set_auxdata() interface even returns.  Hence sqlite3_set_auxdata()
     should be called near the end of the function implementation and the
     function implementation should not make any use of P after
     sqlite3_set_auxdata() has been called.

     ^(In practice, metadata is preserved between function calls for
     function parameters that are compile-time constants, including literal
     values and [parameters] and expressions composed from the same.)^

     The value of the N parameter to these interfaces should be non-negative.
     Future enhancements may make use of negative N values to define new
     kinds of function caching behavior.

     These routines must be called from the same thread in which
     the SQL function is running.
     */
    @inlinable public func setAuxiliaryData(_ data: UnsafeMutableRawPointer?, forArgument argument: Int32, destructor: AuxiliaryDataDestructor? = nil) {
        sqlite3_set_auxdata(rawValue, argument, data, destructor)
    }
}
