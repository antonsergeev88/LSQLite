import MissedSwiftSQLite

extension Value {
    @inlinable public func byteCount() -> Int32 {
        sqlite3_value_bytes(rawValue)
    }

    @inlinable public var type: Datatype {
        Datatype(rawValue: sqlite3_value_type(rawValue))
    }

    @inlinable public func convertToNumericType() -> Datatype {
        Datatype(rawValue: sqlite3_value_numeric_type(rawValue))
    }

    @available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
    @inlinable public var noChange: Bool {
        sqlite3_value_nochange(rawValue) != 0
    }

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    @inlinable public var isFromBind: Bool {
        sqlite3_value_frombind(rawValue) != 0
    }

    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    @inlinable public var subtype: Subtype {
        Subtype(rawValue: sqlite3_value_subtype(rawValue))
    }
}
