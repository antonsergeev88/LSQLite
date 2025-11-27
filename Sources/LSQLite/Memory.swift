import MissedSwiftSQLite

/// Flag controlling whether `memoryHighwater(_:)` resets the high-water mark.
///
/// Related SQLite: `sqlite3_memory_highwater`
@frozen public struct MemoryHighWaterResetFlag: Equatable, RawRepresentable, CustomDebugStringConvertible {
    public let rawValue: Int32

    /// Creates a reset flag from its raw integer value.
    ///
    /// Related SQLite: `sqlite3_memory_highwater`
    @inlinable public init(rawValue: Int32) {
        self.rawValue = rawValue
    }

    public static let safe = Self(rawValue: 0)
    public static let reset = Self(rawValue: 1)

    /// Debug label for the reset flag.
    ///
    /// Related SQLite: `sqlite3_memory_highwater`
    public var debugDescription: String {
        switch self {
        case .safe: return "LSQLITE_SAFE"
        case .reset: return "LSQLITE_RESET"
        default: return "MemoryHighWaterResetFlag(rawValue: \(rawValue))"
        }
    }
}

/// Allocates the requested number of bytes using SQLite's allocator; returns nil on OOM.
///
/// Related SQLite: `sqlite3_malloc`
@inlinable public func malloc(_ size: Int32) -> UnsafeMutableRawPointer? {
    sqlite3_malloc(size)
}

/// Allocates the requested number of bytes (64-bit length) using SQLite's allocator; returns nil on OOM.
///
/// Related SQLite: `sqlite3_malloc64`
@available(iOS 9.0, macOS 10.11, tvOS 9.0, watchOS 2.0, *)
@inlinable public func malloc64(_ size: UInt64) -> UnsafeMutableRawPointer? {
    sqlite3_malloc64(size)
}

/// Resizes or allocates memory using SQLite's allocator; nil frees the buffer.
///
/// Related SQLite: `sqlite3_realloc`
@inlinable public func realloc(_ buffer: UnsafeMutableRawPointer?, _ size: Int32) -> UnsafeMutableRawPointer? {
    sqlite3_realloc(buffer, size)
}

/// Resizes or allocates memory using SQLite's allocator with a 64-bit length.
///
/// Related SQLite: `sqlite3_realloc64`
@available(iOS 9.0, macOS 10.11, tvOS 9.0, watchOS 2.0, *)
@inlinable public func realloc64(_ buffer: UnsafeMutableRawPointer?, _ size: UInt64) -> UnsafeMutableRawPointer? {
    sqlite3_realloc64(buffer, size)
}

/// Frees memory allocated by SQLite's allocation routines (no-op on nil).
///
/// Related SQLite: `sqlite3_free`
@inlinable public func free(_ buffer: UnsafeMutableRawPointer?) {
    sqlite3_free(buffer)
}

/// Returns the size of an allocation obtained from SQLite's allocator.
///
/// Related SQLite: `sqlite3_msize`
@available(iOS 9.0, macOS 10.11, tvOS 9.0, watchOS 2.0, *)
@inlinable public func msize(_ buffer: UnsafeMutableRawPointer?) -> UInt64 {
    sqlite3_msize(buffer)
}

/// Total bytes currently allocated by SQLite's memory subsystem.
///
/// Related SQLite: `sqlite3_memory_used`
@inlinable public var memoryUsed: Int64 {
    sqlite3_memory_used()
}

/// High-water mark of bytes allocated; use reset flag to optionally reset.
///
/// Related SQLite: `sqlite3_memory_highwater`
@inlinable public func memoryHighwater(_ resetFlag: MemoryHighWaterResetFlag) -> Int64 {
    sqlite3_memory_highwater(resetFlag.rawValue)
}
