import SQLite3

extension Blob {
    /// Size of this open BLOB in bytes.
    ///
    /// Related SQLite: `sqlite3_blob_bytes`, `sqlite3_blob_open`, `sqlite3_blob_close`
    @inlinable public var byteCount: Int32 {
        sqlite3_blob_bytes(rawValue)
    }

    /// Reads `length` bytes from the BLOB starting at `offset` into `buffer`.
    /// - Parameters:
    ///   - buffer: Destination buffer.
    ///   - length: Number of bytes to copy.
    ///   - offset: Byte offset within the BLOB.
    /// - Returns: Result of `sqlite3_blob_read`.
    ///
    /// Related SQLite: `sqlite3_blob_read`, `sqlite3_blob_bytes`, `sqlite3_blob_open`
    @inlinable public func read(into buffer: UnsafeMutableRawPointer, length: Int32, offset: Int32) -> ResultCode {
        sqlite3_blob_read(rawValue, buffer, length, offset).resultCode
    }

    /// Writes `length` bytes from `buffer` into the BLOB starting at `offset`; handle must be opened for writing.
    /// - Parameters:
    ///   - buffer: Source bytes to write.
    ///   - length: Number of bytes to write.
    ///   - offset: Byte offset within the BLOB.
    /// - Returns: Result of `sqlite3_blob_write`.
    ///
    /// Related SQLite: `sqlite3_blob_write`, `sqlite3_blob_bytes`, `sqlite3_blob_open`
    @inlinable public func write(_ buffer: UnsafeRawPointer, length: Int32, offset: Int32) -> ResultCode {
        sqlite3_blob_write(rawValue, buffer, length, offset).resultCode
    }
}
