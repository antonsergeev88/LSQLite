import MissedSwiftSQLite

extension Statement {
    /// Number of columns in the result set.
    ///
    /// Related SQLite: `sqlite3_column_count`
    @inlinable public var columnCount: Int32 {
        sqlite3_column_count(rawValue)
    }

    /// Column name for the given 0-based index.
    ///
    /// Related SQLite: `sqlite3_column_name`
    @inlinable public func columnName(at index: Int32) -> String? {
        let cString = sqlite3_column_name(rawValue, index)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        guard !string.isEmpty else {
            return nil
        }
        return string
    }

    /// Database name for the column (or nil).
    ///
    /// Related SQLite: `sqlite3_column_database_name`
    @inlinable public func columnDatabaseName(at index: Int32) -> String? {
        let cString = sqlite3_column_database_name(rawValue, index)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        guard !string.isEmpty else {
            return nil
        }
        return string
    }

    /// Table name for the column (or nil).
    ///
    /// Related SQLite: `sqlite3_column_table_name`
    @inlinable public func columnTableName(at index: Int32) -> String? {
        let cString = sqlite3_column_table_name(rawValue, index)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        guard !string.isEmpty else {
            return nil
        }
        return string
    }

    /// Original column name before any AS alias (or nil).
    ///
    /// Related SQLite: `sqlite3_column_origin_name`
    @inlinable public func columnOriginName(at index: Int32) -> String? {
        let cString = sqlite3_column_origin_name(rawValue, index)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        guard !string.isEmpty else {
            return nil
        }
        return string
    }

    /// Declared type of the column (or nil).
    ///
    /// Related SQLite: `sqlite3_column_decltype`
    @inlinable public func columnDeclaredType(at index: Int32) -> String? {
        let cString = sqlite3_column_decltype(rawValue, index)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        guard !string.isEmpty else {
            return nil
        }
        return string
    }

    /// Number of columns with data in the current row (after stepping).
    ///
    /// Related SQLite: `sqlite3_data_count`
    @inlinable public var dataCount: Int32 {
        sqlite3_data_count(rawValue)
    }

    /// Blob pointer for the column value in the current row.
    ///
    /// Related SQLite: `sqlite3_column_blob`, `sqlite3_column_bytes`
    @inlinable public func columnBlob(at index: Int32) -> UnsafeRawPointer? {
        sqlite3_column_blob(rawValue, index)
    }

    /// Column value coerced to Double.
    ///
    /// Related SQLite: `sqlite3_column_double`
    @inlinable public func columnDouble(at index: Int32) -> Double {
        sqlite3_column_double(rawValue, index)
    }

    /// Column value coerced to 32-bit Int.
    ///
    /// Related SQLite: `sqlite3_column_int`
    @inlinable public func columnInt(at index: Int32) -> Int32 {
        sqlite3_column_int(rawValue, index)
    }

    /// Column value coerced to 64-bit Int.
    ///
    /// Related SQLite: `sqlite3_column_int64`
    @inlinable public func columnInt64(at index: Int32) -> sqlite3_int64 {
        sqlite3_column_int64(rawValue, index)
    }

    /// UTF-8 text for the column value.
    ///
    /// Related SQLite: `sqlite3_column_text`, `sqlite3_column_bytes`
    @inlinable public func columnText(at index: Int32) -> String? {
        let cString = sqlite3_column_text(rawValue, index)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        guard !string.isEmpty else {
            return nil
        }
        return string
    }

    /// Byte length of the column value for text/blob in the current row.
    ///
    /// Related SQLite: `sqlite3_column_bytes`
    @inlinable public func columnBytes(at index: Int32) -> Int32 {
        sqlite3_column_bytes(rawValue, index)
    }

    /// Datatype code for the column value in the current row.
    ///
    /// Related SQLite: `sqlite3_column_type`
    @inlinable public func columnType(at index: Int32) -> Datatype {
        Datatype(rawValue: sqlite3_column_type(rawValue, index))
    }
}
