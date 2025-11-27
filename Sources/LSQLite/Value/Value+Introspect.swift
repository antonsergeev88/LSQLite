import MissedSwiftSQLite

extension Value {
    /// Number of bytes in the value for BLOB or text; 0 for other types.
    ///
    /// Related SQLite: `sqlite3_value_bytes`, `sqlite3_value_bytes16`
    @inlinable public func byteCount() -> Int32 {
        sqlite3_value_bytes(rawValue)
    }

    /// Datatype code for this value.
    ///
    /// Related SQLite: `sqlite3_value_type`
    @inlinable public var type: Datatype {
        Datatype(rawValue: sqlite3_value_type(rawValue))
    }

    /// Applies numeric affinity and returns the resulting type code.
    ///
    /// Related SQLite: `sqlite3_value_numeric_type`
    @inlinable public func convertToNumericType() -> Datatype {
        Datatype(rawValue: sqlite3_value_numeric_type(rawValue))
    }

    @available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
    /// Whether the column value is marked as unchanged during an UPDATE.
    ///
    /// Related SQLite: `sqlite3_value_nochange`
    @inlinable public var noChange: Bool {
        sqlite3_value_nochange(rawValue) != 0
    }

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    /// Indicates that the value originated from a bound parameter rather than stored data.
    ///
    /// Related SQLite: `sqlite3_value_frombind`
    @inlinable public var isFromBind: Bool {
        sqlite3_value_frombind(rawValue) != 0
    }

    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    /// User-defined subtype associated with this value.
    ///
    /// Related SQLite: `sqlite3_value_subtype`, `sqlite3_result_subtype`
    @inlinable public var subtype: Subtype {
        Subtype(rawValue: sqlite3_value_subtype(rawValue))
    }
}
