/**
 CAPI3REF: Dynamically Typed Value Object
 KEYWORDS: {protected sqlite3_value} {unprotected sqlite3_value}

 SQLite uses the sqlite3_value object to represent all values
 that can be stored in a database table. SQLite uses dynamic typing
 for the values it stores.  ^Values stored in sqlite3_value objects
 can be integers, floating point values, strings, BLOBs, or NULL.

 An sqlite3_value object may be either "protected" or "unprotected".
 Some interfaces require a protected sqlite3_value.  Other interfaces
 will accept either a protected or an unprotected sqlite3_value.
 Every interface that accepts sqlite3_value arguments specifies
 whether or not it requires a protected sqlite3_value.  The
 [sqlite3_value_dup()] interface can be used to construct a new
 protected sqlite3_value from an unprotected sqlite3_value.

 The terms "protected" and "unprotected" refer to whether or not
 a mutex is held.  An internal mutex is held for a protected
 sqlite3_value object but no mutex is held for an unprotected
 sqlite3_value object.  If SQLite is compiled to be single-threaded
 (with [SQLITE_THREADSAFE=0] and with [sqlite3_threadsafe()] returning 0)
 or if SQLite is run in one of reduced mutex modes
 [SQLITE_CONFIG_SINGLETHREAD] or [SQLITE_CONFIG_MULTITHREAD]
 then there is no distinction between protected and unprotected
 sqlite3_value objects and they can be used interchangeably.  However,
 for maximum code portability it is recommended that applications
 still make the distinction between protected and unprotected
 sqlite3_value objects even when not strictly required.

 ^The sqlite3_value objects that are passed as parameters into the
 implementation of [application-defined SQL functions] are protected.
 ^The sqlite3_value object returned by
 [sqlite3_column_value()] is unprotected.
 Unprotected sqlite3_value objects may only be used as arguments
 to [sqlite3_result_value()], [sqlite3_bind_value()], and
 [sqlite3_value_dup()].
 The [sqlite3_value_blob | sqlite3_value_type()] family of
 interfaces require protected sqlite3_value objects.
*/
@frozen public struct Value: RawRepresentable {
    public let rawValue: OpaquePointer

    @inlinable public init(rawValue: OpaquePointer) {
        self.rawValue = rawValue
    }
}
