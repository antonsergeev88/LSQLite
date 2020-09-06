import MissedSwiftSQLite

extension Database {
    /**
     CAPI3REF: Closing A Database Connection
     DESTRUCTOR: sqlite3

     ^The sqlite3_close() and sqlite3_close_v2() routines are destructors
     for the [sqlite3] object.
     ^Calls to sqlite3_close() and sqlite3_close_v2() return [SQLITE_OK] if
     the [sqlite3] object is successfully destroyed and all associated
     resources are deallocated.

     ^If the database connection is associated with unfinalized prepared
     statements or unfinished sqlite3_backup objects then sqlite3_close()
     will leave the database connection open and return [SQLITE_BUSY].
     ^If sqlite3_close_v2() is called with unfinalized prepared statements
     and/or unfinished sqlite3_backups, then the database connection becomes
     an unusable "zombie" which will automatically be deallocated when the
     last prepared statement is finalized or the last sqlite3_backup is
     finished.  The sqlite3_close_v2() interface is intended for use with
     host languages that are garbage collected, and where the order in which
     destructors are called is arbitrary.

     Applications should [sqlite3_finalize | finalize] all [prepared statements],
     [sqlite3_blob_close | close] all [BLOB handles], and
     [sqlite3_backup_finish | finish] all [sqlite3_backup] objects associated
     with the [sqlite3] object prior to attempting to close the object.  ^If
     sqlite3_close_v2() is called on a [database connection] that still has
     outstanding [prepared statements], [BLOB handles], and/or
     [sqlite3_backup] objects then it returns [SQLITE_OK] and the deallocation
     of resources is deferred until all [prepared statements], [BLOB handles],
     and [sqlite3_backup] objects are also destroyed.

     ^If an [sqlite3] object is destroyed while a transaction is open,
     the transaction is automatically rolled back.

     The C parameter to [sqlite3_close(C)] and [sqlite3_close_v2(C)]
     must be either a NULL
     pointer or an [sqlite3] object pointer obtained
     from [sqlite3_open()], [sqlite3_open16()], or
     [sqlite3_open_v2()], and not previously closed.
     ^Calling sqlite3_close() or sqlite3_close_v2() with a NULL pointer
     argument is a harmless no-op.
     */
    @inlinable public func close() -> ResultCode {
        sqlite3_close(rawValue).resultCode
    }

    /**
     CAPI3REF: Closing A Database Connection
     DESTRUCTOR: sqlite3

     ^The sqlite3_close() and sqlite3_close_v2() routines are destructors
     for the [sqlite3] object.
     ^Calls to sqlite3_close() and sqlite3_close_v2() return [SQLITE_OK] if
     the [sqlite3] object is successfully destroyed and all associated
     resources are deallocated.

     ^If the database connection is associated with unfinalized prepared
     statements or unfinished sqlite3_backup objects then sqlite3_close()
     will leave the database connection open and return [SQLITE_BUSY].
     ^If sqlite3_close_v2() is called with unfinalized prepared statements
     and/or unfinished sqlite3_backups, then the database connection becomes
     an unusable "zombie" which will automatically be deallocated when the
     last prepared statement is finalized or the last sqlite3_backup is
     finished.  The sqlite3_close_v2() interface is intended for use with
     host languages that are garbage collected, and where the order in which
     destructors are called is arbitrary.

     Applications should [sqlite3_finalize | finalize] all [prepared statements],
     [sqlite3_blob_close | close] all [BLOB handles], and
     [sqlite3_backup_finish | finish] all [sqlite3_backup] objects associated
     with the [sqlite3] object prior to attempting to close the object.  ^If
     sqlite3_close_v2() is called on a [database connection] that still has
     outstanding [prepared statements], [BLOB handles], and/or
     [sqlite3_backup] objects then it returns [SQLITE_OK] and the deallocation
     of resources is deferred until all [prepared statements], [BLOB handles],
     and [sqlite3_backup] objects are also destroyed.

     ^If an [sqlite3] object is destroyed while a transaction is open,
     the transaction is automatically rolled back.

     The C parameter to [sqlite3_close(C)] and [sqlite3_close_v2(C)]
     must be either a NULL
     pointer or an [sqlite3] object pointer obtained
     from [sqlite3_open()], [sqlite3_open16()], or
     [sqlite3_open_v2()], and not previously closed.
     ^Calling sqlite3_close() or sqlite3_close_v2() with a NULL pointer
     argument is a harmless no-op.
     */
    @available(iOS 8.2, macOS 10.10, tvOS 8.2, watchOS 2.0, *)
    @inlinable public func closeV2() -> ResultCode {
        sqlite3_close_v2(rawValue).resultCode
    }
}
