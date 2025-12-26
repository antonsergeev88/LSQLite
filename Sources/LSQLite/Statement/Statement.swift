/// Wrapper around a prepared SQLite statement handle.
///
/// Related SQLite: `sqlite3_stmt`, `sqlite3_prepare_v2`, `sqlite3_finalize`
@frozen public struct Statement: RawRepresentable {
    public let rawValue: OpaquePointer

    @inlinable public init(rawValue: OpaquePointer) {
        self.rawValue = rawValue
    }
}
