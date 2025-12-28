import MissedSwiftSQLite

extension Statement {
    /// Number of columns in the result set.
    /// - Returns: Column count for the prepared statement, or 0 when the
    ///   statement returns no data.
    ///
    /// Related SQLite: `sqlite3_column_count`
    @inlinable public var columnCount: Int32 {
        sqlite3_column_count(rawValue)
    }

    /// Column name for a 0-based result index.
    /// - Parameter index: 0-based column index.
    /// - Returns: The column name, or nil if unavailable.
    ///
    /// Related SQLite: `sqlite3_column_name`
    @inlinable public func columnName(at index: Int32) -> String? {
        let cString = sqlite3_column_name(rawValue, index)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        return string
    }

    /// Database name for a result column.
    /// - Parameter index: 0-based column index.
    /// - Returns: The database name, or nil if unavailable.
    ///
    /// This requires column metadata support in the SQLite build.
    ///
    /// Related SQLite: `sqlite3_column_database_name`
    @inlinable public func columnDatabaseName(at index: Int32) -> String? {
        let cString = sqlite3_column_database_name(rawValue, index)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        return string
    }

    /// Table name for a result column.
    /// - Parameter index: 0-based column index.
    /// - Returns: The table name, or nil if unavailable.
    ///
    /// This requires column metadata support in the SQLite build.
    ///
    /// Related SQLite: `sqlite3_column_table_name`
    @inlinable public func columnTableName(at index: Int32) -> String? {
        let cString = sqlite3_column_table_name(rawValue, index)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        return string
    }

    /// Original column name before any alias.
    /// - Parameter index: 0-based column index.
    /// - Returns: The original column name, or nil if unavailable.
    ///
    /// This requires column metadata support in the SQLite build.
    ///
    /// Related SQLite: `sqlite3_column_origin_name`
    @inlinable public func columnOriginName(at index: Int32) -> String? {
        let cString = sqlite3_column_origin_name(rawValue, index)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        return string
    }

    /// Declared type of the table column for a result column.
    /// - Parameter index: 0-based column index.
    /// - Returns: The declared type string, or nil if the result column is an
    ///   expression or metadata is unavailable.
    ///
    /// Related SQLite: `sqlite3_column_decltype`
    @inlinable public func columnDeclaredType(at index: Int32) -> String? {
        let cString = sqlite3_column_decltype(rawValue, index)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        return string
    }

    /// Number of columns with data in the current row.
    /// - Returns: Column count for the current row, or 0 when no row is available.
    ///
    /// Related SQLite: `sqlite3_data_count`
    @inlinable public var dataCount: Int32 {
        sqlite3_data_count(rawValue)
    }

    /// Raw BLOB bytes for the column value in the current row.
    /// - Parameter index: 0-based column index.
    /// - Returns: Pointer to the BLOB bytes, or nil for NULL values.
    ///
    /// The pointer is valid until the next `step()`, `reset()`, or `finalize()`
    /// call, or until a conversion is triggered by another column accessor.
    /// Zero-length BLOBs may also yield a nil pointer.
    ///
    /// Related SQLite: `sqlite3_column_blob`
    @inlinable public func columnBlob(at index: Int32) -> UnsafeRawPointer? {
        sqlite3_column_blob(rawValue, index)
    }

    /// Column value coerced to Double.
    /// - Parameter index: 0-based column index.
    /// - Returns: The value converted to Double.
    ///
    /// Related SQLite: `sqlite3_column_double`
    @inlinable public func columnDouble(at index: Int32) -> Double {
        sqlite3_column_double(rawValue, index)
    }

    /// Column value coerced to 32-bit Int.
    /// - Parameter index: 0-based column index.
    /// - Returns: The value converted to Int32.
    ///
    /// Related SQLite: `sqlite3_column_int`
    @inlinable public func columnInt(at index: Int32) -> Int32 {
        sqlite3_column_int(rawValue, index)
    }

    /// Column value coerced to 64-bit Int.
    /// - Parameter index: 0-based column index.
    /// - Returns: The value converted to Int64.
    ///
    /// Related SQLite: `sqlite3_column_int64`
    @inlinable public func columnInt64(at index: Int32) -> Int64 {
        sqlite3_column_int64(rawValue, index)
    }

    /// UTF-8 text for the column value in the current row.
    /// - Parameter index: 0-based column index.
    /// - Returns: The text value, or nil for NULL values.
    ///
    /// Embedded NUL bytes truncate the returned string.
    ///
    /// Related SQLite: `sqlite3_column_text`
    @inlinable public func columnText(at index: Int32) -> String? {
        let cString = sqlite3_column_text(rawValue, index)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        return string
    }

    /// Byte length of the column value in the current row.
    /// - Parameter index: 0-based column index.
    /// - Returns: Size in bytes of the value, or 0 for NULL values.
    ///
    /// Text lengths are in UTF-8 bytes and exclude the terminator.
    /// Numeric values are converted to text before sizing.
    ///
    /// Related SQLite: `sqlite3_column_bytes`
    @inlinable public func columnBytes(at index: Int32) -> Int32 {
        sqlite3_column_bytes(rawValue, index)
    }

    /// Datatype code for the column value in the current row.
    /// - Parameter index: 0-based column index.
    /// - Returns: The datatype of the value before any conversion.
    ///
    /// Related SQLite: `sqlite3_column_type`
    @inlinable public func columnType(at index: Int32) -> Datatype {
        Datatype(rawValue: sqlite3_column_type(rawValue, index))
    }
}
