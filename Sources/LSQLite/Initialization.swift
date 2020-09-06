import MissedSwiftSQLite

/**
 CAPI3REF: Initialize The SQLite Library

 ^The sqlite3_initialize() routine initializes the
 SQLite library.  ^The sqlite3_shutdown() routine
 deallocates any resources that were allocated by sqlite3_initialize().
 These routines are designed to aid in process initialization and
 shutdown on embedded systems.  Workstation applications using
 SQLite normally do not need to invoke either of these routines.

 A call to sqlite3_initialize() is an "effective" call if it is
 the first time sqlite3_initialize() is invoked during the lifetime of
 the process, or if it is the first time sqlite3_initialize() is invoked
 following a call to sqlite3_shutdown().  ^(Only an effective call
 of sqlite3_initialize() does any initialization.  All other calls
 are harmless no-ops.)^

 A call to sqlite3_shutdown() is an "effective" call if it is the first
 call to sqlite3_shutdown() since the last sqlite3_initialize().  ^(Only
 an effective call to sqlite3_shutdown() does any deinitialization.
 All other valid calls to sqlite3_shutdown() are harmless no-ops.)^

 The sqlite3_initialize() interface is threadsafe, but sqlite3_shutdown()
 is not.  The sqlite3_shutdown() interface must only be called from a
 single thread.  All open [database connections] must be closed and all
 other SQLite resources must be deallocated prior to invoking
 sqlite3_shutdown().

 Among other things, ^sqlite3_initialize() will invoke
 sqlite3_os_init().  Similarly, ^sqlite3_shutdown()
 will invoke sqlite3_os_end().

 ^The sqlite3_initialize() routine returns [SQLITE_OK] on success.
 ^If for some reason, sqlite3_initialize() is unable to initialize
 the library (perhaps it is unable to allocate a needed resource such
 as a mutex) it returns an [error code] other than [SQLITE_OK].

 ^The sqlite3_initialize() routine is called internally by many other
 SQLite interfaces so that an application usually does not need to
 invoke sqlite3_initialize() directly.  For example, [sqlite3_open()]
 calls sqlite3_initialize() so the SQLite library will be automatically
 initialized when [sqlite3_open()] is called if it has not be initialized
 already.  ^However, if SQLite is compiled with the [SQLITE_OMIT_AUTOINIT]
 compile-time option, then the automatic calls to sqlite3_initialize()
 are omitted and the application must call sqlite3_initialize() directly
 prior to using any other SQLite interface.  For maximum portability,
 it is recommended that applications always invoke sqlite3_initialize()
 directly prior to using any other SQLite interface.  Future releases
 of SQLite may require this.  In other words, the behavior exhibited
 when SQLite is compiled with [SQLITE_OMIT_AUTOINIT] might become the
 default behavior in some future release of SQLite.

 The sqlite3_os_init() routine does operating-system specific
 initialization of the SQLite library.  The sqlite3_os_end()
 routine undoes the effect of sqlite3_os_init().  Typical tasks
 performed by these routines include allocation or deallocation
 of static resources, initialization of global variables,
 setting up a default [sqlite3_vfs] module, or setting up
 a default configuration using [sqlite3_config()].

 The application should never invoke either sqlite3_os_init()
 or sqlite3_os_end() directly.  The application should only invoke
 sqlite3_initialize() and sqlite3_shutdown().  The sqlite3_os_init()
 interface is called automatically by sqlite3_initialize() and
 sqlite3_os_end() is called by sqlite3_shutdown().  Appropriate
 implementations for sqlite3_os_init() and sqlite3_os_end()
 are built into SQLite when it is compiled for Unix, Windows, or OS/2.
 When [custom builds | built for other platforms]
 (using the [SQLITE_OS_OTHER=1] compile-time
 option) the application must supply a suitable implementation for
 sqlite3_os_init() and sqlite3_os_end().  An application-supplied
 implementation of sqlite3_os_init() or sqlite3_os_end()
 must return [SQLITE_OK] on success and some other [error code] upon
 failure.
 */
@inlinable public func initialize() -> ResultCode {
    sqlite3_initialize().resultCode
}

/**
 CAPI3REF: Initialize The SQLite Library

 ^The sqlite3_initialize() routine initializes the
 SQLite library.  ^The sqlite3_shutdown() routine
 deallocates any resources that were allocated by sqlite3_initialize().
 These routines are designed to aid in process initialization and
 shutdown on embedded systems.  Workstation applications using
 SQLite normally do not need to invoke either of these routines.

 A call to sqlite3_initialize() is an "effective" call if it is
 the first time sqlite3_initialize() is invoked during the lifetime of
 the process, or if it is the first time sqlite3_initialize() is invoked
 following a call to sqlite3_shutdown().  ^(Only an effective call
 of sqlite3_initialize() does any initialization.  All other calls
 are harmless no-ops.)^

 A call to sqlite3_shutdown() is an "effective" call if it is the first
 call to sqlite3_shutdown() since the last sqlite3_initialize().  ^(Only
 an effective call to sqlite3_shutdown() does any deinitialization.
 All other valid calls to sqlite3_shutdown() are harmless no-ops.)^

 The sqlite3_initialize() interface is threadsafe, but sqlite3_shutdown()
 is not.  The sqlite3_shutdown() interface must only be called from a
 single thread.  All open [database connections] must be closed and all
 other SQLite resources must be deallocated prior to invoking
 sqlite3_shutdown().

 Among other things, ^sqlite3_initialize() will invoke
 sqlite3_os_init().  Similarly, ^sqlite3_shutdown()
 will invoke sqlite3_os_end().

 ^The sqlite3_initialize() routine returns [SQLITE_OK] on success.
 ^If for some reason, sqlite3_initialize() is unable to initialize
 the library (perhaps it is unable to allocate a needed resource such
 as a mutex) it returns an [error code] other than [SQLITE_OK].

 ^The sqlite3_initialize() routine is called internally by many other
 SQLite interfaces so that an application usually does not need to
 invoke sqlite3_initialize() directly.  For example, [sqlite3_open()]
 calls sqlite3_initialize() so the SQLite library will be automatically
 initialized when [sqlite3_open()] is called if it has not be initialized
 already.  ^However, if SQLite is compiled with the [SQLITE_OMIT_AUTOINIT]
 compile-time option, then the automatic calls to sqlite3_initialize()
 are omitted and the application must call sqlite3_initialize() directly
 prior to using any other SQLite interface.  For maximum portability,
 it is recommended that applications always invoke sqlite3_initialize()
 directly prior to using any other SQLite interface.  Future releases
 of SQLite may require this.  In other words, the behavior exhibited
 when SQLite is compiled with [SQLITE_OMIT_AUTOINIT] might become the
 default behavior in some future release of SQLite.

 The sqlite3_os_init() routine does operating-system specific
 initialization of the SQLite library.  The sqlite3_os_end()
 routine undoes the effect of sqlite3_os_init().  Typical tasks
 performed by these routines include allocation or deallocation
 of static resources, initialization of global variables,
 setting up a default [sqlite3_vfs] module, or setting up
 a default configuration using [sqlite3_config()].

 The application should never invoke either sqlite3_os_init()
 or sqlite3_os_end() directly.  The application should only invoke
 sqlite3_initialize() and sqlite3_shutdown().  The sqlite3_os_init()
 interface is called automatically by sqlite3_initialize() and
 sqlite3_os_end() is called by sqlite3_shutdown().  Appropriate
 implementations for sqlite3_os_init() and sqlite3_os_end()
 are built into SQLite when it is compiled for Unix, Windows, or OS/2.
 When [custom builds | built for other platforms]
 (using the [SQLITE_OS_OTHER=1] compile-time
 option) the application must supply a suitable implementation for
 sqlite3_os_init() and sqlite3_os_end().  An application-supplied
 implementation of sqlite3_os_init() or sqlite3_os_end()
 must return [SQLITE_OK] on success and some other [error code] upon
 failure.
 */
@inlinable public func shutdown() -> ResultCode {
    sqlite3_shutdown().resultCode
}
