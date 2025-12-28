import MissedSwiftSQLite

extension Value {
    /// Raw bytes for the value as a blob.
    ///
    /// Requires a protected value; using an unprotected value is not thread-safe.
    /// SQLite may perform type conversions to produce a blob.
    /// The returned pointer is valid until another accessor causes a conversion
    /// or the value is released. A zero-length blob is returned as `nil`.
    /// For a stable size and pointer, call `blob` first, then `byteCount()`.
    /// - Returns: Pointer to blob bytes, or `nil` for NULL or zero-length blobs.
    ///
    /// Related SQLite: `sqlite3_value_blob`
    @inlinable public var blob: UnsafeRawPointer? {
        sqlite3_value_blob(rawValue)
    }

    /// Numeric value coerced to `Double`.
    ///
    /// Requires a protected value; using an unprotected value is not thread-safe.
    /// SQLite applies numeric conversion rules; NULL yields 0.0.
    /// - Returns: The value coerced to `Double`.
    ///
    /// Related SQLite: `sqlite3_value_double`
    @inlinable public var double: Double {
        sqlite3_value_double(rawValue)
    }

    /// Numeric value coerced to `Int32`.
    ///
    /// Requires a protected value; using an unprotected value is not thread-safe.
    /// SQLite applies numeric conversion rules; NULL yields 0.
    /// - Returns: The value coerced to `Int32`.
    ///
    /// Related SQLite: `sqlite3_value_int`
    @inlinable public var int: Int32 {
        sqlite3_value_int(rawValue)
    }

    /// Numeric value coerced to `Int64`.
    ///
    /// Requires a protected value; using an unprotected value is not thread-safe.
    /// SQLite applies numeric conversion rules; NULL yields 0.
    /// - Returns: The value coerced to `Int64`.
    ///
    /// Related SQLite: `sqlite3_value_int64`
    @inlinable public var int64: Int64 {
        sqlite3_value_int64(rawValue)
    }

    /// UTF-8 text for this value.
    ///
    /// Requires a protected value; using an unprotected value is not thread-safe.
    /// SQLite may perform type conversions to produce text.
    /// If the text contains embedded NUL bytes, only the prefix before the first
    /// NUL is returned. Use `byteCount()` for the full UTF-8 byte length.
    /// - Returns: UTF-8 string, or `nil` for NULL.
    ///
    /// Related SQLite: `sqlite3_value_text`
    @inlinable public var text: String? {
        let cString = sqlite3_value_text(rawValue)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        return string
    }
}
