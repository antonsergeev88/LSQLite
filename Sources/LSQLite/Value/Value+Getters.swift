import SQLite3

extension Value {
    /// Pointer to the BLOB bytes for this value, or nil if not a BLOB.
    ///
    /// Related SQLite: `sqlite3_value_blob`, `sqlite3_value_bytes`
    @inlinable public var blob: UnsafeRawPointer? {
        sqlite3_value_blob(rawValue)
    }

    /// Value coerced to Double.
    ///
    /// Related SQLite: `sqlite3_value_double`
    @inlinable public var double: Double {
        sqlite3_value_double(rawValue)
    }

    /// Value coerced to 32-bit Int.
    ///
    /// Related SQLite: `sqlite3_value_int`
    @inlinable public var int: Int32 {
        sqlite3_value_int(rawValue)
    }

    /// Value coerced to 64-bit Int.
    ///
    /// Related SQLite: `sqlite3_value_int64`
    @inlinable public var int64: Int64 {
        sqlite3_value_int64(rawValue)
    }

    /// UTF-8 text for this value, or nil if not text.
    ///
    /// Related SQLite: `sqlite3_value_text`, `sqlite3_value_bytes`
    @inlinable public var text: String? {
        let cString = sqlite3_value_text(rawValue)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        return string
    }
}
