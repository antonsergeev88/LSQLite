import MissedSwiftSQLite

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
    @inlinable public var int64: sqlite3_int64 {
        sqlite3_value_int64(rawValue)
    }

    /// UTF-8 text pointer for this value, or nil if not text; content may be invalidated by later calls.
    ///
    /// Related SQLite: `sqlite3_value_text`, `sqlite3_value_bytes`
    @inlinable public var text: UnsafePointer<UInt8>? {
        sqlite3_value_text(rawValue)
    }
}
