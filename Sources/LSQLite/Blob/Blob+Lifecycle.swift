import MissedSwiftSQLite

extension Blob {
    @inlinable public func reopen(at rowID: RowID) -> ResultCode {
        sqlite3_blob_reopen(rawValue, rowID.rawValue).resultCode
    }
    
    @inlinable public func close() -> ResultCode {
        sqlite3_blob_close(rawValue).resultCode
    }
}
