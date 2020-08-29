import SQLite3

@frozen public struct MemoryHighWaterResetFlag: Equatable, RawRepresentable, CustomDebugStringConvertible {
    public let rawValue: Int32

    @inlinable public init(rawValue: Int32) {
        self.rawValue = rawValue
    }

    public static let safe = Self(rawValue: 0)
    public static let reset = Self(rawValue: 1)

    public var debugDescription: String {
        switch self {
        case .safe: return "LSQLITE_SAFE"
        case .reset: return "LSQLITE_RESET"
        default: return "MemoryHighWaterResetFlag(rawValue: \(rawValue))"
        }
    }
}

@inlinable public func malloc(_ size: Int32) -> UnsafeMutableRawPointer? {
    sqlite3_malloc(size)
}

@available(iOS 9.0, macOS 10.11, tvOS 9.0, watchOS 2.0, *)
@inlinable public func malloc64(_ size: UInt64) -> UnsafeMutableRawPointer? {
    sqlite3_malloc64(size)
}

@inlinable public func realloc(_ buffer: UnsafeMutableRawPointer?, _ size: Int32) -> UnsafeMutableRawPointer? {
    sqlite3_realloc(buffer, size)
}

@available(iOS 9.0, macOS 10.11, tvOS 9.0, watchOS 2.0, *)
@inlinable public func realloc64(_ buffer: UnsafeMutableRawPointer?, _ size: UInt64) -> UnsafeMutableRawPointer? {
    sqlite3_realloc64(buffer, size)
}

@inlinable public func free(_ buffer: UnsafeMutableRawPointer?) {
    sqlite3_free(buffer)
}

@available(iOS 9.0, macOS 10.11, tvOS 9.0, watchOS 2.0, *)
@inlinable public func msize(_ buffer: UnsafeMutableRawPointer?) -> UInt64 {
    sqlite3_msize(buffer)
}

@inlinable public var memoryUsed: Int64 {
    sqlite3_memory_used()
}

@inlinable public func memoryHighwater(_ resetFlag: MemoryHighWaterResetFlag) -> Int64 {
    sqlite3_memory_highwater(resetFlag.rawValue)
}
