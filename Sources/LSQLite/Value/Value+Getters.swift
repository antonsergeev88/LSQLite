import MissedSwiftSQLite

extension Value {
    @inlinable public var blob: UnsafeRawPointer? {
        sqlite3_value_blob(rawValue)
    }

    @inlinable public var double: Double {
        sqlite3_value_double(rawValue)
    }

    @inlinable public var int: Int32 {
        sqlite3_value_int(rawValue)
    }

    @inlinable public var int64: sqlite3_int64 {
        sqlite3_value_int64(rawValue)
    }

    @inlinable public var text: UnsafePointer<UInt8>? {
        sqlite3_value_text(rawValue)
    }
}
