import MissedSwiftSQLite

extension Blob {
    @inlinable public var byteCount: Int32 {
        sqlite3_blob_bytes(rawValue)
    }

    @inlinable public func read(into buffer: UnsafeMutableRawPointer, length: Int32, offset: Int32) -> ResultCode {
        sqlite3_blob_read(rawValue, buffer, length, offset).resultCode
    }

    @inlinable public func write(_ buffer: UnsafeRawPointer, length: Int32, offset: Int32) -> ResultCode {
        sqlite3_blob_write(rawValue, buffer, length, offset).resultCode
    }
}
