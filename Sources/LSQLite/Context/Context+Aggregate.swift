import MissedSwiftSQLite

extension Context {
    /// Provides per-aggregate state storage of the given size for this context.
    /// - Parameter size: Bytes to allocate on first call; pass `0` to fetch without allocating.
    /// - Returns: Stable buffer pointer for the aggregate instance, or `nil` on allocation failure.
    ///
    /// Related SQLite: `sqlite3_aggregate_context`
    @inlinable public func aggregateContext(size: Int32) -> UnsafeMutableRawPointer? {
        sqlite3_aggregate_context(rawValue, size)
    }
}
