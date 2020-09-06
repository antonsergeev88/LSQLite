import MissedSwiftSQLite

extension Blob {
    /**
     CAPI3REF: Return The Size Of An Open BLOB
     METHOD: sqlite3_blob

     ^Returns the size in bytes of the BLOB accessible via the
     successfully opened [BLOB handle] in its only argument.  ^The
     incremental blob I/O routines can only read or overwriting existing
     blob content; they cannot change the size of a blob.

     This routine only works on a [BLOB handle] which has been created
     by a prior successful call to [sqlite3_blob_open()] and which has not
     been closed by [sqlite3_blob_close()].  Passing any other pointer in
     to this routine results in undefined and probably undesirable behavior.
     */
    @inlinable public var byteCount: Int32 {
        sqlite3_blob_bytes(rawValue)
    }

    /**
     CAPI3REF: Read Data From A BLOB Incrementally
     METHOD: sqlite3_blob

     ^(This function is used to read data from an open [BLOB handle] into a
     caller-supplied buffer. N bytes of data are copied into buffer Z
     from the open BLOB, starting at offset iOffset.)^

     ^If offset iOffset is less than N bytes from the end of the BLOB,
     [SQLITE_ERROR] is returned and no data is read.  ^If N or iOffset is
     less than zero, [SQLITE_ERROR] is returned and no data is read.
     ^The size of the blob (and hence the maximum value of N+iOffset)
     can be determined using the [sqlite3_blob_bytes()] interface.

     ^An attempt to read from an expired [BLOB handle] fails with an
     error code of [SQLITE_ABORT].

     ^(On success, sqlite3_blob_read() returns SQLITE_OK.
     Otherwise, an [error code] or an [extended error code] is returned.)^

     This routine only works on a [BLOB handle] which has been created
     by a prior successful call to [sqlite3_blob_open()] and which has not
     been closed by [sqlite3_blob_close()].  Passing any other pointer in
     to this routine results in undefined and probably undesirable behavior.

     See also: [sqlite3_blob_write()].
     */
    @inlinable public func read(into buffer: UnsafeMutableRawPointer, length: Int32, offset: Int32) -> ResultCode {
        sqlite3_blob_read(rawValue, buffer, length, offset).resultCode
    }

    /**
     CAPI3REF: Write Data Into A BLOB Incrementally
     METHOD: sqlite3_blob

     ^(This function is used to write data into an open [BLOB handle] from a
     caller-supplied buffer. N bytes of data are copied from the buffer Z
     into the open BLOB, starting at offset iOffset.)^

     ^(On success, sqlite3_blob_write() returns SQLITE_OK.
     Otherwise, an  [error code] or an [extended error code] is returned.)^
     ^Unless SQLITE_MISUSE is returned, this function sets the
     [database connection] error code and message accessible via
     [sqlite3_errcode()] and [sqlite3_errmsg()] and related functions.

     ^If the [BLOB handle] passed as the first argument was not opened for
     writing (the flags parameter to [sqlite3_blob_open()] was zero),
     this function returns [SQLITE_READONLY].

     This function may only modify the contents of the BLOB; it is
     not possible to increase the size of a BLOB using this API.
     ^If offset iOffset is less than N bytes from the end of the BLOB,
     [SQLITE_ERROR] is returned and no data is written. The size of the
     BLOB (and hence the maximum value of N+iOffset) can be determined
     using the [sqlite3_blob_bytes()] interface. ^If N or iOffset are less
     than zero [SQLITE_ERROR] is returned and no data is written.

     ^An attempt to write to an expired [BLOB handle] fails with an
     error code of [SQLITE_ABORT].  ^Writes to the BLOB that occurred
     before the [BLOB handle] expired are not rolled back by the
     expiration of the handle, though of course those changes might
     have been overwritten by the statement that expired the BLOB handle
     or by other independent statements.

     This routine only works on a [BLOB handle] which has been created
     by a prior successful call to [sqlite3_blob_open()] and which has not
     been closed by [sqlite3_blob_close()].  Passing any other pointer in
     to this routine results in undefined and probably undesirable behavior.

     See also: [sqlite3_blob_read()].
     */
    @inlinable public func write(_ buffer: UnsafeRawPointer, length: Int32, offset: Int32) -> ResultCode {
        sqlite3_blob_write(rawValue, buffer, length, offset).resultCode
    }
}
