import MissedSwiftSQLite

extension Value {
    /// Byte length of the value's UTF-8 text or blob representation.
    ///
    /// Requires a protected value; using an unprotected value is not thread-safe.
    /// Numeric values are converted to UTF-8 text before counting bytes.
    /// UTF-16 text is converted to UTF-8. NULL returns 0.
    /// This call can change the value's internal representation and invalidate
    /// pointers previously returned by `blob` or `text`. For a stable
    /// pointer-size pair, call `blob` or `text` first, then `byteCount()`.
    /// - Returns: Number of bytes in the UTF-8 text or blob representation.
    ///
    /// Related SQLite: `sqlite3_value_bytes`
    @inlinable public func byteCount() -> Int32 {
        sqlite3_value_bytes(rawValue)
    }

    /// Current datatype code for this value.
    ///
    /// Requires a protected value; using an unprotected value is not thread-safe.
    /// The reported type can change after calls that coerce or convert the value.
    /// - Returns: Datatype describing the current storage class.
    ///
    /// Related SQLite: `sqlite3_value_type`
    @inlinable public var type: Datatype {
        Datatype(rawValue: sqlite3_value_type(rawValue))
    }

    /// Applies numeric affinity and returns the resulting datatype code.
    ///
    /// Requires a protected value; using an unprotected value is not thread-safe.
    /// If the value looks like a number, it is converted to integer or real.
    /// Otherwise the value is left unchanged.
    /// - Returns: Datatype after numeric affinity is applied.
    ///
    /// Related SQLite: `sqlite3_value_numeric_type`
    @inlinable public func convertToNumericType() -> Datatype {
        Datatype(rawValue: sqlite3_value_numeric_type(rawValue))
    }

    /// Whether a column value is marked as unchanged during a virtual table UPDATE.
    ///
    /// Requires a protected value; using an unprotected value is not thread-safe.
    /// Only meaningful inside a virtual table update callback; otherwise the
    /// result is arbitrary.
    /// - Returns: `true` if the value is marked as unchanged.
    ///
    /// Related SQLite: `sqlite3_value_nochange`
    @available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
    @inlinable public var noChange: Bool {
        sqlite3_value_nochange(rawValue) != 0
    }

    /// Indicates that the value originated from a bound parameter.
    ///
    /// Requires a protected value; using an unprotected value is not thread-safe.
    /// Returns false for literals, column values, or expression results.
    /// - Returns: `true` if the value comes from binding.
    ///
    /// Related SQLite: `sqlite3_value_frombind`
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    @inlinable public var isFromBind: Bool {
        sqlite3_value_frombind(rawValue) != 0
    }

    /// Application-defined subtype associated with this value.
    ///
    /// Requires a protected value; using an unprotected value is not thread-safe.
    /// Subtypes are preserved for SQL functions registered with
    /// `Connection.FunctionFlag.subtype`.
    /// - Returns: Subtype tag for the value, or 0 if none is set.
    ///
    /// Related SQLite: `sqlite3_value_subtype`
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    @inlinable public var subtype: Subtype {
        Subtype(rawValue: sqlite3_value_subtype(rawValue))
    }
}
