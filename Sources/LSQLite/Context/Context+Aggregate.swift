import MissedSwiftSQLite

extension Context {
    /**
     CAPI3REF: Obtain Aggregate Function Context
     METHOD: sqlite3_context

     Implementations of aggregate SQL functions use this
     routine to allocate memory for storing their state.

     ^The first time the sqlite3_aggregate_context(C,N) routine is called
     for a particular aggregate function, SQLite
     allocates N of memory, zeroes out that memory, and returns a pointer
     to the new memory. ^On second and subsequent calls to
     sqlite3_aggregate_context() for the same aggregate function instance,
     the same buffer is returned.  Sqlite3_aggregate_context() is normally
     called once for each invocation of the xStep callback and then one
     last time when the xFinal callback is invoked.  ^(When no rows match
     an aggregate query, the xStep() callback of the aggregate function
     implementation is never called and xFinal() is called exactly once.
     In those cases, sqlite3_aggregate_context() might be called for the
     first time from within xFinal().)^

     ^The sqlite3_aggregate_context(C,N) routine returns a NULL pointer
     when first called if N is less than or equal to zero or if a memory
     allocate error occurs.

     ^(The amount of space allocated by sqlite3_aggregate_context(C,N) is
     determined by the N parameter on first successful call.  Changing the
     value of N in subsequent call to sqlite3_aggregate_context() within
     the same aggregate function instance will not resize the memory
     allocation.)^  Within the xFinal callback, it is customary to set
     N=0 in calls to sqlite3_aggregate_context(C,N) so that no
     pointless memory allocations occur.

     ^SQLite automatically frees the memory allocated by
     sqlite3_aggregate_context() when the aggregate query concludes.

     The first parameter must be a copy of the
     [sqlite3_context | SQL function context] that is the first parameter
     to the xStep or xFinal callback routine that implements the aggregate
     function.

     This routine must be called from the same thread in which
     the aggregate SQL function is running.
     */
    @inlinable public func aggregateContext(size: Int32) -> UnsafeMutableRawPointer? {
        sqlite3_aggregate_context(rawValue, size)
    }
}
