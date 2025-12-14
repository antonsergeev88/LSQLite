/// Wrapper around an SQLite mutex handle.
///
/// Related SQLite: `sqlite3_mutex`, `sqlite3_mutex_alloc`
@frozen public struct Mutex: RawRepresentable, @unchecked Sendable {
    public let rawValue: OpaquePointer

    @inlinable public init(rawValue: OpaquePointer) {
        self.rawValue = rawValue
    }
}
