import MissedSwiftSQLite

extension Blob {
    /// Size of this open BLOB in bytes.
    ///
    /// Returns 0 if the handle is aborted.
    ///
    /// Related SQLite: `sqlite3_blob_bytes`
    @inlinable public var byteCount: Int32 {
        sqlite3_blob_bytes(rawValue)
    }

    /// Reads `length` bytes from the BLOB starting at `offset` into `buffer`.
    ///
    /// Use `byteCount` to validate bounds before reading. If `length` or `offset` is negative, or
    /// if the read would extend past the end of the BLOB, the call returns `.error` and reads no
    /// data. Reads from an expired handle return `.abort`.
    /// - Parameters:
    ///   - buffer: Destination buffer.
    ///   - length: Number of bytes to copy.
    ///   - offset: Byte offset within the BLOB.
    /// - Returns: Result code for the read.
    ///
    /// Related SQLite: `sqlite3_blob_read`
    @inlinable public func read(into buffer: UnsafeMutableRawPointer, length: Int32, offset: Int32) -> ResultCode {
        sqlite3_blob_read(rawValue, buffer, length, offset).resultCode
    }

    /// Writes `length` bytes from `buffer` into the BLOB starting at `offset`.
    ///
    /// The handle must be opened for writing and the write does not change the BLOB size.
    /// Use `byteCount` to validate bounds before writing. If the handle is read-only, the call
    /// returns `.readonly`. If `length` or `offset` is negative, or if the write would extend past
    /// the end of the BLOB, the call returns `.error` and writes no data. Writes to an expired
    /// handle return `.abort`.
    /// - Parameters:
    ///   - buffer: Source bytes to write.
    ///   - length: Number of bytes to write.
    ///   - offset: Byte offset within the BLOB.
    /// - Returns: Result code for the write.
    ///
    /// Related SQLite: `sqlite3_blob_write`
    @inlinable public func write(_ buffer: UnsafeRawPointer, length: Int32, offset: Int32) -> ResultCode {
        sqlite3_blob_write(rawValue, buffer, length, offset).resultCode
    }
}
