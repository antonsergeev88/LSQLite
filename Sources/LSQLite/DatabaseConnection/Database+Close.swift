import SQLite3

extension Database {
    @inlinable public func close() -> ResultCode {
        sqlite3_close(rawValue).resultCode
    }

    @available(iOS 8.2, macOS 10.10, tvOS 8.2, watchOS 2.0, *)
    @inlinable public func closeV2() -> ResultCode {
        sqlite3_close_v2(rawValue).resultCode
    }
}
