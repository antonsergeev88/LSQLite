import MissedSwiftSQLite

extension Mutex {
    /**
     CAPI3REF: Mutexes

     The SQLite core uses these routines for thread
     synchronization. Though they are intended for internal
     use by SQLite, code that links against SQLite is
     permitted to use any of these routines.

     The SQLite source code contains multiple implementations
     of these mutex routines.  An appropriate implementation
     is selected automatically at compile-time.  The following
     implementations are available in the SQLite core:

     <ul>
     <li>   SQLITE_MUTEX_PTHREADS
     <li>   SQLITE_MUTEX_W32
     <li>   SQLITE_MUTEX_NOOP
     </ul>

     The SQLITE_MUTEX_NOOP implementation is a set of routines
     that does no real locking and is appropriate for use in
     a single-threaded application.  The SQLITE_MUTEX_PTHREADS and
     SQLITE_MUTEX_W32 implementations are appropriate for use on Unix
     and Windows.

     If SQLite is compiled with the SQLITE_MUTEX_APPDEF preprocessor
     macro defined (with "-DSQLITE_MUTEX_APPDEF=1"), then no mutex
     implementation is included with the library. In this case the
     application must supply a custom mutex implementation using the
     [SQLITE_CONFIG_MUTEX] option of the sqlite3_config() function
     before calling sqlite3_initialize() or any other public sqlite3_
     function that calls sqlite3_initialize().

     ^The sqlite3_mutex_alloc() routine allocates a new
     mutex and returns a pointer to it. ^The sqlite3_mutex_alloc()
     routine returns NULL if it is unable to allocate the requested
     mutex.  The argument to sqlite3_mutex_alloc() must one of these
     integer constants:

     <ul>
     <li>  SQLITE_MUTEX_FAST
     <li>  SQLITE_MUTEX_RECURSIVE
     <li>  SQLITE_MUTEX_STATIC_MASTER
     <li>  SQLITE_MUTEX_STATIC_MEM
     <li>  SQLITE_MUTEX_STATIC_OPEN
     <li>  SQLITE_MUTEX_STATIC_PRNG
     <li>  SQLITE_MUTEX_STATIC_LRU
     <li>  SQLITE_MUTEX_STATIC_PMEM
     <li>  SQLITE_MUTEX_STATIC_APP1
     <li>  SQLITE_MUTEX_STATIC_APP2
     <li>  SQLITE_MUTEX_STATIC_APP3
     <li>  SQLITE_MUTEX_STATIC_VFS1
     <li>  SQLITE_MUTEX_STATIC_VFS2
     <li>  SQLITE_MUTEX_STATIC_VFS3
     </ul>

     ^The first two constants (SQLITE_MUTEX_FAST and SQLITE_MUTEX_RECURSIVE)
     cause sqlite3_mutex_alloc() to create
     a new mutex.  ^The new mutex is recursive when SQLITE_MUTEX_RECURSIVE
     is used but not necessarily so when SQLITE_MUTEX_FAST is used.
     The mutex implementation does not need to make a distinction
     between SQLITE_MUTEX_RECURSIVE and SQLITE_MUTEX_FAST if it does
     not want to.  SQLite will only request a recursive mutex in
     cases where it really needs one.  If a faster non-recursive mutex
     implementation is available on the host platform, the mutex subsystem
     might return such a mutex in response to SQLITE_MUTEX_FAST.

     ^The other allowed parameters to sqlite3_mutex_alloc() (anything other
     than SQLITE_MUTEX_FAST and SQLITE_MUTEX_RECURSIVE) each return
     a pointer to a static preexisting mutex.  ^Nine static mutexes are
     used by the current version of SQLite.  Future versions of SQLite
     may add additional static mutexes.  Static mutexes are for internal
     use by SQLite only.  Applications that use SQLite mutexes should
     use only the dynamic mutexes returned by SQLITE_MUTEX_FAST or
     SQLITE_MUTEX_RECURSIVE.

     ^Note that if one of the dynamic mutex parameters (SQLITE_MUTEX_FAST
     or SQLITE_MUTEX_RECURSIVE) is used then sqlite3_mutex_alloc()
     returns a different mutex on every call.  ^For the static
     mutex types, the same mutex is returned on every call that has
     the same type number.

     ^The sqlite3_mutex_free() routine deallocates a previously
     allocated dynamic mutex.  Attempting to deallocate a static
     mutex results in undefined behavior.

     ^The sqlite3_mutex_enter() and sqlite3_mutex_try() routines attempt
     to enter a mutex.  ^If another thread is already within the mutex,
     sqlite3_mutex_enter() will block and sqlite3_mutex_try() will return
     SQLITE_BUSY.  ^The sqlite3_mutex_try() interface returns [SQLITE_OK]
     upon successful entry.  ^(Mutexes created using
     SQLITE_MUTEX_RECURSIVE can be entered multiple times by the same thread.
     In such cases, the
     mutex must be exited an equal number of times before another thread
     can enter.)^  If the same thread tries to enter any mutex other
     than an SQLITE_MUTEX_RECURSIVE more than once, the behavior is undefined.

     ^(Some systems (for example, Windows 95) do not support the operation
     implemented by sqlite3_mutex_try().  On those systems, sqlite3_mutex_try()
     will always return SQLITE_BUSY. The SQLite core only ever uses
     sqlite3_mutex_try() as an optimization so this is acceptable
     behavior.)^

     ^The sqlite3_mutex_leave() routine exits a mutex that was
     previously entered by the same thread.   The behavior
     is undefined if the mutex is not currently entered by the
     calling thread or is not currently allocated.

     ^If the argument to sqlite3_mutex_enter(), sqlite3_mutex_try(), or
     sqlite3_mutex_leave() is a NULL pointer, then all three routines
     behave as no-ops.
     */
    @inlinable public func enter() {
        sqlite3_mutex_enter(rawValue)
    }

    /**
     CAPI3REF: Mutexes

     The SQLite core uses these routines for thread
     synchronization. Though they are intended for internal
     use by SQLite, code that links against SQLite is
     permitted to use any of these routines.

     The SQLite source code contains multiple implementations
     of these mutex routines.  An appropriate implementation
     is selected automatically at compile-time.  The following
     implementations are available in the SQLite core:

     <ul>
     <li>   SQLITE_MUTEX_PTHREADS
     <li>   SQLITE_MUTEX_W32
     <li>   SQLITE_MUTEX_NOOP
     </ul>

     The SQLITE_MUTEX_NOOP implementation is a set of routines
     that does no real locking and is appropriate for use in
     a single-threaded application.  The SQLITE_MUTEX_PTHREADS and
     SQLITE_MUTEX_W32 implementations are appropriate for use on Unix
     and Windows.

     If SQLite is compiled with the SQLITE_MUTEX_APPDEF preprocessor
     macro defined (with "-DSQLITE_MUTEX_APPDEF=1"), then no mutex
     implementation is included with the library. In this case the
     application must supply a custom mutex implementation using the
     [SQLITE_CONFIG_MUTEX] option of the sqlite3_config() function
     before calling sqlite3_initialize() or any other public sqlite3_
     function that calls sqlite3_initialize().

     ^The sqlite3_mutex_alloc() routine allocates a new
     mutex and returns a pointer to it. ^The sqlite3_mutex_alloc()
     routine returns NULL if it is unable to allocate the requested
     mutex.  The argument to sqlite3_mutex_alloc() must one of these
     integer constants:

     <ul>
     <li>  SQLITE_MUTEX_FAST
     <li>  SQLITE_MUTEX_RECURSIVE
     <li>  SQLITE_MUTEX_STATIC_MASTER
     <li>  SQLITE_MUTEX_STATIC_MEM
     <li>  SQLITE_MUTEX_STATIC_OPEN
     <li>  SQLITE_MUTEX_STATIC_PRNG
     <li>  SQLITE_MUTEX_STATIC_LRU
     <li>  SQLITE_MUTEX_STATIC_PMEM
     <li>  SQLITE_MUTEX_STATIC_APP1
     <li>  SQLITE_MUTEX_STATIC_APP2
     <li>  SQLITE_MUTEX_STATIC_APP3
     <li>  SQLITE_MUTEX_STATIC_VFS1
     <li>  SQLITE_MUTEX_STATIC_VFS2
     <li>  SQLITE_MUTEX_STATIC_VFS3
     </ul>

     ^The first two constants (SQLITE_MUTEX_FAST and SQLITE_MUTEX_RECURSIVE)
     cause sqlite3_mutex_alloc() to create
     a new mutex.  ^The new mutex is recursive when SQLITE_MUTEX_RECURSIVE
     is used but not necessarily so when SQLITE_MUTEX_FAST is used.
     The mutex implementation does not need to make a distinction
     between SQLITE_MUTEX_RECURSIVE and SQLITE_MUTEX_FAST if it does
     not want to.  SQLite will only request a recursive mutex in
     cases where it really needs one.  If a faster non-recursive mutex
     implementation is available on the host platform, the mutex subsystem
     might return such a mutex in response to SQLITE_MUTEX_FAST.

     ^The other allowed parameters to sqlite3_mutex_alloc() (anything other
     than SQLITE_MUTEX_FAST and SQLITE_MUTEX_RECURSIVE) each return
     a pointer to a static preexisting mutex.  ^Nine static mutexes are
     used by the current version of SQLite.  Future versions of SQLite
     may add additional static mutexes.  Static mutexes are for internal
     use by SQLite only.  Applications that use SQLite mutexes should
     use only the dynamic mutexes returned by SQLITE_MUTEX_FAST or
     SQLITE_MUTEX_RECURSIVE.

     ^Note that if one of the dynamic mutex parameters (SQLITE_MUTEX_FAST
     or SQLITE_MUTEX_RECURSIVE) is used then sqlite3_mutex_alloc()
     returns a different mutex on every call.  ^For the static
     mutex types, the same mutex is returned on every call that has
     the same type number.

     ^The sqlite3_mutex_free() routine deallocates a previously
     allocated dynamic mutex.  Attempting to deallocate a static
     mutex results in undefined behavior.

     ^The sqlite3_mutex_enter() and sqlite3_mutex_try() routines attempt
     to enter a mutex.  ^If another thread is already within the mutex,
     sqlite3_mutex_enter() will block and sqlite3_mutex_try() will return
     SQLITE_BUSY.  ^The sqlite3_mutex_try() interface returns [SQLITE_OK]
     upon successful entry.  ^(Mutexes created using
     SQLITE_MUTEX_RECURSIVE can be entered multiple times by the same thread.
     In such cases, the
     mutex must be exited an equal number of times before another thread
     can enter.)^  If the same thread tries to enter any mutex other
     than an SQLITE_MUTEX_RECURSIVE more than once, the behavior is undefined.

     ^(Some systems (for example, Windows 95) do not support the operation
     implemented by sqlite3_mutex_try().  On those systems, sqlite3_mutex_try()
     will always return SQLITE_BUSY. The SQLite core only ever uses
     sqlite3_mutex_try() as an optimization so this is acceptable
     behavior.)^

     ^The sqlite3_mutex_leave() routine exits a mutex that was
     previously entered by the same thread.   The behavior
     is undefined if the mutex is not currently entered by the
     calling thread or is not currently allocated.

     ^If the argument to sqlite3_mutex_enter(), sqlite3_mutex_try(), or
     sqlite3_mutex_leave() is a NULL pointer, then all three routines
     behave as no-ops.
     */
    @inlinable public func `try`() -> ResultCode {
        sqlite3_mutex_try(rawValue).resultCode
    }

    /**
     CAPI3REF: Mutexes

     The SQLite core uses these routines for thread
     synchronization. Though they are intended for internal
     use by SQLite, code that links against SQLite is
     permitted to use any of these routines.

     The SQLite source code contains multiple implementations
     of these mutex routines.  An appropriate implementation
     is selected automatically at compile-time.  The following
     implementations are available in the SQLite core:

     <ul>
     <li>   SQLITE_MUTEX_PTHREADS
     <li>   SQLITE_MUTEX_W32
     <li>   SQLITE_MUTEX_NOOP
     </ul>

     The SQLITE_MUTEX_NOOP implementation is a set of routines
     that does no real locking and is appropriate for use in
     a single-threaded application.  The SQLITE_MUTEX_PTHREADS and
     SQLITE_MUTEX_W32 implementations are appropriate for use on Unix
     and Windows.

     If SQLite is compiled with the SQLITE_MUTEX_APPDEF preprocessor
     macro defined (with "-DSQLITE_MUTEX_APPDEF=1"), then no mutex
     implementation is included with the library. In this case the
     application must supply a custom mutex implementation using the
     [SQLITE_CONFIG_MUTEX] option of the sqlite3_config() function
     before calling sqlite3_initialize() or any other public sqlite3_
     function that calls sqlite3_initialize().

     ^The sqlite3_mutex_alloc() routine allocates a new
     mutex and returns a pointer to it. ^The sqlite3_mutex_alloc()
     routine returns NULL if it is unable to allocate the requested
     mutex.  The argument to sqlite3_mutex_alloc() must one of these
     integer constants:

     <ul>
     <li>  SQLITE_MUTEX_FAST
     <li>  SQLITE_MUTEX_RECURSIVE
     <li>  SQLITE_MUTEX_STATIC_MASTER
     <li>  SQLITE_MUTEX_STATIC_MEM
     <li>  SQLITE_MUTEX_STATIC_OPEN
     <li>  SQLITE_MUTEX_STATIC_PRNG
     <li>  SQLITE_MUTEX_STATIC_LRU
     <li>  SQLITE_MUTEX_STATIC_PMEM
     <li>  SQLITE_MUTEX_STATIC_APP1
     <li>  SQLITE_MUTEX_STATIC_APP2
     <li>  SQLITE_MUTEX_STATIC_APP3
     <li>  SQLITE_MUTEX_STATIC_VFS1
     <li>  SQLITE_MUTEX_STATIC_VFS2
     <li>  SQLITE_MUTEX_STATIC_VFS3
     </ul>

     ^The first two constants (SQLITE_MUTEX_FAST and SQLITE_MUTEX_RECURSIVE)
     cause sqlite3_mutex_alloc() to create
     a new mutex.  ^The new mutex is recursive when SQLITE_MUTEX_RECURSIVE
     is used but not necessarily so when SQLITE_MUTEX_FAST is used.
     The mutex implementation does not need to make a distinction
     between SQLITE_MUTEX_RECURSIVE and SQLITE_MUTEX_FAST if it does
     not want to.  SQLite will only request a recursive mutex in
     cases where it really needs one.  If a faster non-recursive mutex
     implementation is available on the host platform, the mutex subsystem
     might return such a mutex in response to SQLITE_MUTEX_FAST.

     ^The other allowed parameters to sqlite3_mutex_alloc() (anything other
     than SQLITE_MUTEX_FAST and SQLITE_MUTEX_RECURSIVE) each return
     a pointer to a static preexisting mutex.  ^Nine static mutexes are
     used by the current version of SQLite.  Future versions of SQLite
     may add additional static mutexes.  Static mutexes are for internal
     use by SQLite only.  Applications that use SQLite mutexes should
     use only the dynamic mutexes returned by SQLITE_MUTEX_FAST or
     SQLITE_MUTEX_RECURSIVE.

     ^Note that if one of the dynamic mutex parameters (SQLITE_MUTEX_FAST
     or SQLITE_MUTEX_RECURSIVE) is used then sqlite3_mutex_alloc()
     returns a different mutex on every call.  ^For the static
     mutex types, the same mutex is returned on every call that has
     the same type number.

     ^The sqlite3_mutex_free() routine deallocates a previously
     allocated dynamic mutex.  Attempting to deallocate a static
     mutex results in undefined behavior.

     ^The sqlite3_mutex_enter() and sqlite3_mutex_try() routines attempt
     to enter a mutex.  ^If another thread is already within the mutex,
     sqlite3_mutex_enter() will block and sqlite3_mutex_try() will return
     SQLITE_BUSY.  ^The sqlite3_mutex_try() interface returns [SQLITE_OK]
     upon successful entry.  ^(Mutexes created using
     SQLITE_MUTEX_RECURSIVE can be entered multiple times by the same thread.
     In such cases, the
     mutex must be exited an equal number of times before another thread
     can enter.)^  If the same thread tries to enter any mutex other
     than an SQLITE_MUTEX_RECURSIVE more than once, the behavior is undefined.

     ^(Some systems (for example, Windows 95) do not support the operation
     implemented by sqlite3_mutex_try().  On those systems, sqlite3_mutex_try()
     will always return SQLITE_BUSY. The SQLite core only ever uses
     sqlite3_mutex_try() as an optimization so this is acceptable
     behavior.)^

     ^The sqlite3_mutex_leave() routine exits a mutex that was
     previously entered by the same thread.   The behavior
     is undefined if the mutex is not currently entered by the
     calling thread or is not currently allocated.

     ^If the argument to sqlite3_mutex_enter(), sqlite3_mutex_try(), or
     sqlite3_mutex_leave() is a NULL pointer, then all three routines
     behave as no-ops.
     */
    @inlinable public func leave() {
        sqlite3_mutex_leave(rawValue)
    }
}
