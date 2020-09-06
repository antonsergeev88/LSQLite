import MissedSwiftSQLite

extension Statement {
    @inlinable public var columnCount: Int32 {
        sqlite3_column_count(rawValue)
    }

    @inlinable public func columnName(at index: Int32) -> UnsafePointer<Int8>? {
        sqlite3_column_name(rawValue, index)
    }

    @inlinable public func columnDatabaseName(at index: Int32) -> UnsafePointer<Int8>? {
        sqlite3_column_database_name(rawValue, index)
    }

    @inlinable public func columnTableName(at index: Int32) -> UnsafePointer<Int8>? {
        sqlite3_column_table_name(rawValue, index)
    }

    @inlinable public func columnOriginName(at index: Int32) -> UnsafePointer<Int8>? {
        sqlite3_column_origin_name(rawValue, index)
    }

    @inlinable public func columnDeclaredType(at index: Int32) -> UnsafePointer<Int8>? {
        sqlite3_column_decltype(rawValue, index)
    }

    @inlinable public var dataCount: Int32 {
        sqlite3_data_count(rawValue)
    }

    @inlinable public func columnBlob(at index: Int32) -> UnsafeRawPointer? {
        sqlite3_column_blob(rawValue, index)
    }

    @inlinable public func columnDouble(at index: Int32) -> Double {
        sqlite3_column_double(rawValue, index)
    }

    @inlinable public func columnInt(at index: Int32) -> Int32 {
        sqlite3_column_int(rawValue, index)
    }

    @inlinable public func columnInt64(at index: Int32) -> sqlite3_int64 {
        sqlite3_column_int64(rawValue, index)
    }

    @inlinable public func columnText(at index: Int32) -> UnsafePointer<UInt8>? {
        sqlite3_column_text(rawValue, index)
    }

    @inlinable public func columnBytes(at index: Int32) -> Int32 {
        sqlite3_column_bytes(rawValue, index)
    }

    @inlinable public func columnType(at index: Int32) -> Datatype {
        Datatype(rawValue: sqlite3_column_type(rawValue, index))
    }
}
