import MissedSwiftSQLite

@frozen public struct MemoryHighWaterResetFlag: Equatable, RawRepresentable, CustomDebugStringConvertible {
    public let rawValue: Int32

    @inlinable public init(rawValue: Int32) {
        self.rawValue = rawValue
    }

    public static let safe = Self(rawValue: 0)
    public static let reset = Self(rawValue: 1)

    public var debugDescription: String {
        switch self {
        case .safe: return "LSQLITE_SAFE"
        case .reset: return "LSQLITE_RESET"
        default: return "MemoryHighWaterResetFlag(rawValue: \(rawValue))"
        }
    }
}

/**
 CAPI3REF: Memory Allocation Subsystem

 The SQLite core uses these three routines for all of its own
 internal memory allocation needs. "Core" in the previous sentence
 does not include operating-system specific VFS implementation.  The
 Windows VFS uses native malloc() and free() for some operations.

 ^The sqlite3_malloc() routine returns a pointer to a block
 of memory at least N bytes in length, where N is the parameter.
 ^If sqlite3_malloc() is unable to obtain sufficient free
 memory, it returns a NULL pointer.  ^If the parameter N to
 sqlite3_malloc() is zero or negative then sqlite3_malloc() returns
 a NULL pointer.

 ^The sqlite3_malloc64(N) routine works just like
 sqlite3_malloc(N) except that N is an unsigned 64-bit integer instead
 of a signed 32-bit integer.

 ^Calling sqlite3_free() with a pointer previously returned
 by sqlite3_malloc() or sqlite3_realloc() releases that memory so
 that it might be reused.  ^The sqlite3_free() routine is
 a no-op if is called with a NULL pointer.  Passing a NULL pointer
 to sqlite3_free() is harmless.  After being freed, memory
 should neither be read nor written.  Even reading previously freed
 memory might result in a segmentation fault or other severe error.
 Memory corruption, a segmentation fault, or other severe error
 might result if sqlite3_free() is called with a non-NULL pointer that
 was not obtained from sqlite3_malloc() or sqlite3_realloc().

 ^The sqlite3_realloc(X,N) interface attempts to resize a
 prior memory allocation X to be at least N bytes.
 ^If the X parameter to sqlite3_realloc(X,N)
 is a NULL pointer then its behavior is identical to calling
 sqlite3_malloc(N).
 ^If the N parameter to sqlite3_realloc(X,N) is zero or
 negative then the behavior is exactly the same as calling
 sqlite3_free(X).
 ^sqlite3_realloc(X,N) returns a pointer to a memory allocation
 of at least N bytes in size or NULL if insufficient memory is available.
 ^If M is the size of the prior allocation, then min(N,M) bytes
 of the prior allocation are copied into the beginning of buffer returned
 by sqlite3_realloc(X,N) and the prior allocation is freed.
 ^If sqlite3_realloc(X,N) returns NULL and N is positive, then the
 prior allocation is not freed.

 ^The sqlite3_realloc64(X,N) interfaces works the same as
 sqlite3_realloc(X,N) except that N is a 64-bit unsigned integer instead
 of a 32-bit signed integer.

 ^If X is a memory allocation previously obtained from sqlite3_malloc(),
 sqlite3_malloc64(), sqlite3_realloc(), or sqlite3_realloc64(), then
 sqlite3_msize(X) returns the size of that memory allocation in bytes.
 ^The value returned by sqlite3_msize(X) might be larger than the number
 of bytes requested when X was allocated.  ^If X is a NULL pointer then
 sqlite3_msize(X) returns zero.  If X points to something that is not
 the beginning of memory allocation, or if it points to a formerly
 valid memory allocation that has now been freed, then the behavior
 of sqlite3_msize(X) is undefined and possibly harmful.

 ^The memory returned by sqlite3_malloc(), sqlite3_realloc(),
 sqlite3_malloc64(), and sqlite3_realloc64()
 is always aligned to at least an 8 byte boundary, or to a
 4 byte boundary if the [SQLITE_4_BYTE_ALIGNED_MALLOC] compile-time
 option is used.

 In SQLite version 3.5.0 and 3.5.1, it was possible to define
 the SQLITE_OMIT_MEMORY_ALLOCATION which would cause the built-in
 implementation of these routines to be omitted.  That capability
 is no longer provided.  Only built-in memory allocators can be used.

 Prior to SQLite version 3.7.10, the Windows OS interface layer called
 the system malloc() and free() directly when converting
 filenames between the UTF-8 encoding used by SQLite
 and whatever filename encoding is used by the particular Windows
 installation.  Memory allocation errors were detected, but
 they were reported back as [SQLITE_CANTOPEN] or
 [SQLITE_IOERR] rather than [SQLITE_NOMEM].

 The pointer arguments to [sqlite3_free()] and [sqlite3_realloc()]
 must be either NULL or else pointers obtained from a prior
 invocation of [sqlite3_malloc()] or [sqlite3_realloc()] that have
 not yet been released.

 The application must not read or write any part of
 a block of memory after it has been released using
 [sqlite3_free()] or [sqlite3_realloc()].
 */
@inlinable public func malloc(_ size: Int32) -> UnsafeMutableRawPointer? {
    sqlite3_malloc(size)
}

/**
 CAPI3REF: Memory Allocation Subsystem

 The SQLite core uses these three routines for all of its own
 internal memory allocation needs. "Core" in the previous sentence
 does not include operating-system specific VFS implementation.  The
 Windows VFS uses native malloc() and free() for some operations.

 ^The sqlite3_malloc() routine returns a pointer to a block
 of memory at least N bytes in length, where N is the parameter.
 ^If sqlite3_malloc() is unable to obtain sufficient free
 memory, it returns a NULL pointer.  ^If the parameter N to
 sqlite3_malloc() is zero or negative then sqlite3_malloc() returns
 a NULL pointer.

 ^The sqlite3_malloc64(N) routine works just like
 sqlite3_malloc(N) except that N is an unsigned 64-bit integer instead
 of a signed 32-bit integer.

 ^Calling sqlite3_free() with a pointer previously returned
 by sqlite3_malloc() or sqlite3_realloc() releases that memory so
 that it might be reused.  ^The sqlite3_free() routine is
 a no-op if is called with a NULL pointer.  Passing a NULL pointer
 to sqlite3_free() is harmless.  After being freed, memory
 should neither be read nor written.  Even reading previously freed
 memory might result in a segmentation fault or other severe error.
 Memory corruption, a segmentation fault, or other severe error
 might result if sqlite3_free() is called with a non-NULL pointer that
 was not obtained from sqlite3_malloc() or sqlite3_realloc().

 ^The sqlite3_realloc(X,N) interface attempts to resize a
 prior memory allocation X to be at least N bytes.
 ^If the X parameter to sqlite3_realloc(X,N)
 is a NULL pointer then its behavior is identical to calling
 sqlite3_malloc(N).
 ^If the N parameter to sqlite3_realloc(X,N) is zero or
 negative then the behavior is exactly the same as calling
 sqlite3_free(X).
 ^sqlite3_realloc(X,N) returns a pointer to a memory allocation
 of at least N bytes in size or NULL if insufficient memory is available.
 ^If M is the size of the prior allocation, then min(N,M) bytes
 of the prior allocation are copied into the beginning of buffer returned
 by sqlite3_realloc(X,N) and the prior allocation is freed.
 ^If sqlite3_realloc(X,N) returns NULL and N is positive, then the
 prior allocation is not freed.

 ^The sqlite3_realloc64(X,N) interfaces works the same as
 sqlite3_realloc(X,N) except that N is a 64-bit unsigned integer instead
 of a 32-bit signed integer.

 ^If X is a memory allocation previously obtained from sqlite3_malloc(),
 sqlite3_malloc64(), sqlite3_realloc(), or sqlite3_realloc64(), then
 sqlite3_msize(X) returns the size of that memory allocation in bytes.
 ^The value returned by sqlite3_msize(X) might be larger than the number
 of bytes requested when X was allocated.  ^If X is a NULL pointer then
 sqlite3_msize(X) returns zero.  If X points to something that is not
 the beginning of memory allocation, or if it points to a formerly
 valid memory allocation that has now been freed, then the behavior
 of sqlite3_msize(X) is undefined and possibly harmful.

 ^The memory returned by sqlite3_malloc(), sqlite3_realloc(),
 sqlite3_malloc64(), and sqlite3_realloc64()
 is always aligned to at least an 8 byte boundary, or to a
 4 byte boundary if the [SQLITE_4_BYTE_ALIGNED_MALLOC] compile-time
 option is used.

 In SQLite version 3.5.0 and 3.5.1, it was possible to define
 the SQLITE_OMIT_MEMORY_ALLOCATION which would cause the built-in
 implementation of these routines to be omitted.  That capability
 is no longer provided.  Only built-in memory allocators can be used.

 Prior to SQLite version 3.7.10, the Windows OS interface layer called
 the system malloc() and free() directly when converting
 filenames between the UTF-8 encoding used by SQLite
 and whatever filename encoding is used by the particular Windows
 installation.  Memory allocation errors were detected, but
 they were reported back as [SQLITE_CANTOPEN] or
 [SQLITE_IOERR] rather than [SQLITE_NOMEM].

 The pointer arguments to [sqlite3_free()] and [sqlite3_realloc()]
 must be either NULL or else pointers obtained from a prior
 invocation of [sqlite3_malloc()] or [sqlite3_realloc()] that have
 not yet been released.

 The application must not read or write any part of
 a block of memory after it has been released using
 [sqlite3_free()] or [sqlite3_realloc()].
 */
@available(iOS 9.0, macOS 10.11, tvOS 9.0, watchOS 2.0, *)
@inlinable public func malloc64(_ size: UInt64) -> UnsafeMutableRawPointer? {
    sqlite3_malloc64(size)
}

/**
 CAPI3REF: Memory Allocation Subsystem

 The SQLite core uses these three routines for all of its own
 internal memory allocation needs. "Core" in the previous sentence
 does not include operating-system specific VFS implementation.  The
 Windows VFS uses native malloc() and free() for some operations.

 ^The sqlite3_malloc() routine returns a pointer to a block
 of memory at least N bytes in length, where N is the parameter.
 ^If sqlite3_malloc() is unable to obtain sufficient free
 memory, it returns a NULL pointer.  ^If the parameter N to
 sqlite3_malloc() is zero or negative then sqlite3_malloc() returns
 a NULL pointer.

 ^The sqlite3_malloc64(N) routine works just like
 sqlite3_malloc(N) except that N is an unsigned 64-bit integer instead
 of a signed 32-bit integer.

 ^Calling sqlite3_free() with a pointer previously returned
 by sqlite3_malloc() or sqlite3_realloc() releases that memory so
 that it might be reused.  ^The sqlite3_free() routine is
 a no-op if is called with a NULL pointer.  Passing a NULL pointer
 to sqlite3_free() is harmless.  After being freed, memory
 should neither be read nor written.  Even reading previously freed
 memory might result in a segmentation fault or other severe error.
 Memory corruption, a segmentation fault, or other severe error
 might result if sqlite3_free() is called with a non-NULL pointer that
 was not obtained from sqlite3_malloc() or sqlite3_realloc().

 ^The sqlite3_realloc(X,N) interface attempts to resize a
 prior memory allocation X to be at least N bytes.
 ^If the X parameter to sqlite3_realloc(X,N)
 is a NULL pointer then its behavior is identical to calling
 sqlite3_malloc(N).
 ^If the N parameter to sqlite3_realloc(X,N) is zero or
 negative then the behavior is exactly the same as calling
 sqlite3_free(X).
 ^sqlite3_realloc(X,N) returns a pointer to a memory allocation
 of at least N bytes in size or NULL if insufficient memory is available.
 ^If M is the size of the prior allocation, then min(N,M) bytes
 of the prior allocation are copied into the beginning of buffer returned
 by sqlite3_realloc(X,N) and the prior allocation is freed.
 ^If sqlite3_realloc(X,N) returns NULL and N is positive, then the
 prior allocation is not freed.

 ^The sqlite3_realloc64(X,N) interfaces works the same as
 sqlite3_realloc(X,N) except that N is a 64-bit unsigned integer instead
 of a 32-bit signed integer.

 ^If X is a memory allocation previously obtained from sqlite3_malloc(),
 sqlite3_malloc64(), sqlite3_realloc(), or sqlite3_realloc64(), then
 sqlite3_msize(X) returns the size of that memory allocation in bytes.
 ^The value returned by sqlite3_msize(X) might be larger than the number
 of bytes requested when X was allocated.  ^If X is a NULL pointer then
 sqlite3_msize(X) returns zero.  If X points to something that is not
 the beginning of memory allocation, or if it points to a formerly
 valid memory allocation that has now been freed, then the behavior
 of sqlite3_msize(X) is undefined and possibly harmful.

 ^The memory returned by sqlite3_malloc(), sqlite3_realloc(),
 sqlite3_malloc64(), and sqlite3_realloc64()
 is always aligned to at least an 8 byte boundary, or to a
 4 byte boundary if the [SQLITE_4_BYTE_ALIGNED_MALLOC] compile-time
 option is used.

 In SQLite version 3.5.0 and 3.5.1, it was possible to define
 the SQLITE_OMIT_MEMORY_ALLOCATION which would cause the built-in
 implementation of these routines to be omitted.  That capability
 is no longer provided.  Only built-in memory allocators can be used.

 Prior to SQLite version 3.7.10, the Windows OS interface layer called
 the system malloc() and free() directly when converting
 filenames between the UTF-8 encoding used by SQLite
 and whatever filename encoding is used by the particular Windows
 installation.  Memory allocation errors were detected, but
 they were reported back as [SQLITE_CANTOPEN] or
 [SQLITE_IOERR] rather than [SQLITE_NOMEM].

 The pointer arguments to [sqlite3_free()] and [sqlite3_realloc()]
 must be either NULL or else pointers obtained from a prior
 invocation of [sqlite3_malloc()] or [sqlite3_realloc()] that have
 not yet been released.

 The application must not read or write any part of
 a block of memory after it has been released using
 [sqlite3_free()] or [sqlite3_realloc()].
 */
@inlinable public func realloc(_ buffer: UnsafeMutableRawPointer?, _ size: Int32) -> UnsafeMutableRawPointer? {
    sqlite3_realloc(buffer, size)
}

/**
 CAPI3REF: Memory Allocation Subsystem

 The SQLite core uses these three routines for all of its own
 internal memory allocation needs. "Core" in the previous sentence
 does not include operating-system specific VFS implementation.  The
 Windows VFS uses native malloc() and free() for some operations.

 ^The sqlite3_malloc() routine returns a pointer to a block
 of memory at least N bytes in length, where N is the parameter.
 ^If sqlite3_malloc() is unable to obtain sufficient free
 memory, it returns a NULL pointer.  ^If the parameter N to
 sqlite3_malloc() is zero or negative then sqlite3_malloc() returns
 a NULL pointer.

 ^The sqlite3_malloc64(N) routine works just like
 sqlite3_malloc(N) except that N is an unsigned 64-bit integer instead
 of a signed 32-bit integer.

 ^Calling sqlite3_free() with a pointer previously returned
 by sqlite3_malloc() or sqlite3_realloc() releases that memory so
 that it might be reused.  ^The sqlite3_free() routine is
 a no-op if is called with a NULL pointer.  Passing a NULL pointer
 to sqlite3_free() is harmless.  After being freed, memory
 should neither be read nor written.  Even reading previously freed
 memory might result in a segmentation fault or other severe error.
 Memory corruption, a segmentation fault, or other severe error
 might result if sqlite3_free() is called with a non-NULL pointer that
 was not obtained from sqlite3_malloc() or sqlite3_realloc().

 ^The sqlite3_realloc(X,N) interface attempts to resize a
 prior memory allocation X to be at least N bytes.
 ^If the X parameter to sqlite3_realloc(X,N)
 is a NULL pointer then its behavior is identical to calling
 sqlite3_malloc(N).
 ^If the N parameter to sqlite3_realloc(X,N) is zero or
 negative then the behavior is exactly the same as calling
 sqlite3_free(X).
 ^sqlite3_realloc(X,N) returns a pointer to a memory allocation
 of at least N bytes in size or NULL if insufficient memory is available.
 ^If M is the size of the prior allocation, then min(N,M) bytes
 of the prior allocation are copied into the beginning of buffer returned
 by sqlite3_realloc(X,N) and the prior allocation is freed.
 ^If sqlite3_realloc(X,N) returns NULL and N is positive, then the
 prior allocation is not freed.

 ^The sqlite3_realloc64(X,N) interfaces works the same as
 sqlite3_realloc(X,N) except that N is a 64-bit unsigned integer instead
 of a 32-bit signed integer.

 ^If X is a memory allocation previously obtained from sqlite3_malloc(),
 sqlite3_malloc64(), sqlite3_realloc(), or sqlite3_realloc64(), then
 sqlite3_msize(X) returns the size of that memory allocation in bytes.
 ^The value returned by sqlite3_msize(X) might be larger than the number
 of bytes requested when X was allocated.  ^If X is a NULL pointer then
 sqlite3_msize(X) returns zero.  If X points to something that is not
 the beginning of memory allocation, or if it points to a formerly
 valid memory allocation that has now been freed, then the behavior
 of sqlite3_msize(X) is undefined and possibly harmful.

 ^The memory returned by sqlite3_malloc(), sqlite3_realloc(),
 sqlite3_malloc64(), and sqlite3_realloc64()
 is always aligned to at least an 8 byte boundary, or to a
 4 byte boundary if the [SQLITE_4_BYTE_ALIGNED_MALLOC] compile-time
 option is used.

 In SQLite version 3.5.0 and 3.5.1, it was possible to define
 the SQLITE_OMIT_MEMORY_ALLOCATION which would cause the built-in
 implementation of these routines to be omitted.  That capability
 is no longer provided.  Only built-in memory allocators can be used.

 Prior to SQLite version 3.7.10, the Windows OS interface layer called
 the system malloc() and free() directly when converting
 filenames between the UTF-8 encoding used by SQLite
 and whatever filename encoding is used by the particular Windows
 installation.  Memory allocation errors were detected, but
 they were reported back as [SQLITE_CANTOPEN] or
 [SQLITE_IOERR] rather than [SQLITE_NOMEM].

 The pointer arguments to [sqlite3_free()] and [sqlite3_realloc()]
 must be either NULL or else pointers obtained from a prior
 invocation of [sqlite3_malloc()] or [sqlite3_realloc()] that have
 not yet been released.

 The application must not read or write any part of
 a block of memory after it has been released using
 [sqlite3_free()] or [sqlite3_realloc()].
 */
@available(iOS 9.0, macOS 10.11, tvOS 9.0, watchOS 2.0, *)
@inlinable public func realloc64(_ buffer: UnsafeMutableRawPointer?, _ size: UInt64) -> UnsafeMutableRawPointer? {
    sqlite3_realloc64(buffer, size)
}

/**
 CAPI3REF: Memory Allocation Subsystem

 The SQLite core uses these three routines for all of its own
 internal memory allocation needs. "Core" in the previous sentence
 does not include operating-system specific VFS implementation.  The
 Windows VFS uses native malloc() and free() for some operations.

 ^The sqlite3_malloc() routine returns a pointer to a block
 of memory at least N bytes in length, where N is the parameter.
 ^If sqlite3_malloc() is unable to obtain sufficient free
 memory, it returns a NULL pointer.  ^If the parameter N to
 sqlite3_malloc() is zero or negative then sqlite3_malloc() returns
 a NULL pointer.

 ^The sqlite3_malloc64(N) routine works just like
 sqlite3_malloc(N) except that N is an unsigned 64-bit integer instead
 of a signed 32-bit integer.

 ^Calling sqlite3_free() with a pointer previously returned
 by sqlite3_malloc() or sqlite3_realloc() releases that memory so
 that it might be reused.  ^The sqlite3_free() routine is
 a no-op if is called with a NULL pointer.  Passing a NULL pointer
 to sqlite3_free() is harmless.  After being freed, memory
 should neither be read nor written.  Even reading previously freed
 memory might result in a segmentation fault or other severe error.
 Memory corruption, a segmentation fault, or other severe error
 might result if sqlite3_free() is called with a non-NULL pointer that
 was not obtained from sqlite3_malloc() or sqlite3_realloc().

 ^The sqlite3_realloc(X,N) interface attempts to resize a
 prior memory allocation X to be at least N bytes.
 ^If the X parameter to sqlite3_realloc(X,N)
 is a NULL pointer then its behavior is identical to calling
 sqlite3_malloc(N).
 ^If the N parameter to sqlite3_realloc(X,N) is zero or
 negative then the behavior is exactly the same as calling
 sqlite3_free(X).
 ^sqlite3_realloc(X,N) returns a pointer to a memory allocation
 of at least N bytes in size or NULL if insufficient memory is available.
 ^If M is the size of the prior allocation, then min(N,M) bytes
 of the prior allocation are copied into the beginning of buffer returned
 by sqlite3_realloc(X,N) and the prior allocation is freed.
 ^If sqlite3_realloc(X,N) returns NULL and N is positive, then the
 prior allocation is not freed.

 ^The sqlite3_realloc64(X,N) interfaces works the same as
 sqlite3_realloc(X,N) except that N is a 64-bit unsigned integer instead
 of a 32-bit signed integer.

 ^If X is a memory allocation previously obtained from sqlite3_malloc(),
 sqlite3_malloc64(), sqlite3_realloc(), or sqlite3_realloc64(), then
 sqlite3_msize(X) returns the size of that memory allocation in bytes.
 ^The value returned by sqlite3_msize(X) might be larger than the number
 of bytes requested when X was allocated.  ^If X is a NULL pointer then
 sqlite3_msize(X) returns zero.  If X points to something that is not
 the beginning of memory allocation, or if it points to a formerly
 valid memory allocation that has now been freed, then the behavior
 of sqlite3_msize(X) is undefined and possibly harmful.

 ^The memory returned by sqlite3_malloc(), sqlite3_realloc(),
 sqlite3_malloc64(), and sqlite3_realloc64()
 is always aligned to at least an 8 byte boundary, or to a
 4 byte boundary if the [SQLITE_4_BYTE_ALIGNED_MALLOC] compile-time
 option is used.

 In SQLite version 3.5.0 and 3.5.1, it was possible to define
 the SQLITE_OMIT_MEMORY_ALLOCATION which would cause the built-in
 implementation of these routines to be omitted.  That capability
 is no longer provided.  Only built-in memory allocators can be used.

 Prior to SQLite version 3.7.10, the Windows OS interface layer called
 the system malloc() and free() directly when converting
 filenames between the UTF-8 encoding used by SQLite
 and whatever filename encoding is used by the particular Windows
 installation.  Memory allocation errors were detected, but
 they were reported back as [SQLITE_CANTOPEN] or
 [SQLITE_IOERR] rather than [SQLITE_NOMEM].

 The pointer arguments to [sqlite3_free()] and [sqlite3_realloc()]
 must be either NULL or else pointers obtained from a prior
 invocation of [sqlite3_malloc()] or [sqlite3_realloc()] that have
 not yet been released.

 The application must not read or write any part of
 a block of memory after it has been released using
 [sqlite3_free()] or [sqlite3_realloc()].
 */
@inlinable public func free(_ buffer: UnsafeMutableRawPointer?) {
    sqlite3_free(buffer)
}

/**
 CAPI3REF: Memory Allocation Subsystem

 The SQLite core uses these three routines for all of its own
 internal memory allocation needs. "Core" in the previous sentence
 does not include operating-system specific VFS implementation.  The
 Windows VFS uses native malloc() and free() for some operations.

 ^The sqlite3_malloc() routine returns a pointer to a block
 of memory at least N bytes in length, where N is the parameter.
 ^If sqlite3_malloc() is unable to obtain sufficient free
 memory, it returns a NULL pointer.  ^If the parameter N to
 sqlite3_malloc() is zero or negative then sqlite3_malloc() returns
 a NULL pointer.

 ^The sqlite3_malloc64(N) routine works just like
 sqlite3_malloc(N) except that N is an unsigned 64-bit integer instead
 of a signed 32-bit integer.

 ^Calling sqlite3_free() with a pointer previously returned
 by sqlite3_malloc() or sqlite3_realloc() releases that memory so
 that it might be reused.  ^The sqlite3_free() routine is
 a no-op if is called with a NULL pointer.  Passing a NULL pointer
 to sqlite3_free() is harmless.  After being freed, memory
 should neither be read nor written.  Even reading previously freed
 memory might result in a segmentation fault or other severe error.
 Memory corruption, a segmentation fault, or other severe error
 might result if sqlite3_free() is called with a non-NULL pointer that
 was not obtained from sqlite3_malloc() or sqlite3_realloc().

 ^The sqlite3_realloc(X,N) interface attempts to resize a
 prior memory allocation X to be at least N bytes.
 ^If the X parameter to sqlite3_realloc(X,N)
 is a NULL pointer then its behavior is identical to calling
 sqlite3_malloc(N).
 ^If the N parameter to sqlite3_realloc(X,N) is zero or
 negative then the behavior is exactly the same as calling
 sqlite3_free(X).
 ^sqlite3_realloc(X,N) returns a pointer to a memory allocation
 of at least N bytes in size or NULL if insufficient memory is available.
 ^If M is the size of the prior allocation, then min(N,M) bytes
 of the prior allocation are copied into the beginning of buffer returned
 by sqlite3_realloc(X,N) and the prior allocation is freed.
 ^If sqlite3_realloc(X,N) returns NULL and N is positive, then the
 prior allocation is not freed.

 ^The sqlite3_realloc64(X,N) interfaces works the same as
 sqlite3_realloc(X,N) except that N is a 64-bit unsigned integer instead
 of a 32-bit signed integer.

 ^If X is a memory allocation previously obtained from sqlite3_malloc(),
 sqlite3_malloc64(), sqlite3_realloc(), or sqlite3_realloc64(), then
 sqlite3_msize(X) returns the size of that memory allocation in bytes.
 ^The value returned by sqlite3_msize(X) might be larger than the number
 of bytes requested when X was allocated.  ^If X is a NULL pointer then
 sqlite3_msize(X) returns zero.  If X points to something that is not
 the beginning of memory allocation, or if it points to a formerly
 valid memory allocation that has now been freed, then the behavior
 of sqlite3_msize(X) is undefined and possibly harmful.

 ^The memory returned by sqlite3_malloc(), sqlite3_realloc(),
 sqlite3_malloc64(), and sqlite3_realloc64()
 is always aligned to at least an 8 byte boundary, or to a
 4 byte boundary if the [SQLITE_4_BYTE_ALIGNED_MALLOC] compile-time
 option is used.

 In SQLite version 3.5.0 and 3.5.1, it was possible to define
 the SQLITE_OMIT_MEMORY_ALLOCATION which would cause the built-in
 implementation of these routines to be omitted.  That capability
 is no longer provided.  Only built-in memory allocators can be used.

 Prior to SQLite version 3.7.10, the Windows OS interface layer called
 the system malloc() and free() directly when converting
 filenames between the UTF-8 encoding used by SQLite
 and whatever filename encoding is used by the particular Windows
 installation.  Memory allocation errors were detected, but
 they were reported back as [SQLITE_CANTOPEN] or
 [SQLITE_IOERR] rather than [SQLITE_NOMEM].

 The pointer arguments to [sqlite3_free()] and [sqlite3_realloc()]
 must be either NULL or else pointers obtained from a prior
 invocation of [sqlite3_malloc()] or [sqlite3_realloc()] that have
 not yet been released.

 The application must not read or write any part of
 a block of memory after it has been released using
 [sqlite3_free()] or [sqlite3_realloc()].
 */
@available(iOS 9.0, macOS 10.11, tvOS 9.0, watchOS 2.0, *)
@inlinable public func msize(_ buffer: UnsafeMutableRawPointer?) -> UInt64 {
    sqlite3_msize(buffer)
}

/**
 CAPI3REF: Memory Allocator Statistics

 SQLite provides these two interfaces for reporting on the status
 of the [sqlite3_malloc()], [sqlite3_free()], and [sqlite3_realloc()]
 routines, which form the built-in memory allocation subsystem.

 ^The [sqlite3_memory_used()] routine returns the number of bytes
 of memory currently outstanding (malloced but not freed).
 ^The [sqlite3_memory_highwater()] routine returns the maximum
 value of [sqlite3_memory_used()] since the high-water mark
 was last reset.  ^The values returned by [sqlite3_memory_used()] and
 [sqlite3_memory_highwater()] include any overhead
 added by SQLite in its implementation of [sqlite3_malloc()],
 but not overhead added by the any underlying system library
 routines that [sqlite3_malloc()] may call.

 ^The memory high-water mark is reset to the current value of
 [sqlite3_memory_used()] if and only if the parameter to
 [sqlite3_memory_highwater()] is true.  ^The value returned
 by [sqlite3_memory_highwater(1)] is the high-water mark
 prior to the reset.
 */
@inlinable public var memoryUsed: Int64 {
    sqlite3_memory_used()
}

/**
 CAPI3REF: Memory Allocator Statistics

 SQLite provides these two interfaces for reporting on the status
 of the [sqlite3_malloc()], [sqlite3_free()], and [sqlite3_realloc()]
 routines, which form the built-in memory allocation subsystem.
 
 ^The [sqlite3_memory_used()] routine returns the number of bytes
 of memory currently outstanding (malloced but not freed).
 ^The [sqlite3_memory_highwater()] routine returns the maximum
 value of [sqlite3_memory_used()] since the high-water mark
 was last reset.  ^The values returned by [sqlite3_memory_used()] and
 [sqlite3_memory_highwater()] include any overhead
 added by SQLite in its implementation of [sqlite3_malloc()],
 but not overhead added by the any underlying system library
 routines that [sqlite3_malloc()] may call.

 ^The memory high-water mark is reset to the current value of
 [sqlite3_memory_used()] if and only if the parameter to
 [sqlite3_memory_highwater()] is true.  ^The value returned
 by [sqlite3_memory_highwater(1)] is the high-water mark
 prior to the reset.
 */
@inlinable public func memoryHighwater(_ resetFlag: MemoryHighWaterResetFlag) -> Int64 {
    sqlite3_memory_highwater(resetFlag.rawValue)
}
