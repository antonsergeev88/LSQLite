import MissedSwiftSQLite

extension Context {
    /// Provides per-aggregate state storage for this context.
    ///
    /// The first successful call with `size` greater than zero allocates a
    /// zeroed buffer and returns it. Subsequent calls return the same buffer
    /// and ignore changes to `size`.
    /// If `size` is zero or negative and no buffer exists yet, this returns `nil`.
    /// The buffer is released automatically when aggregate evaluation finishes.
    /// - Parameter size: Byte count to allocate on first use; pass `0` to fetch without allocating.
    /// - Returns: Stable buffer pointer for the aggregate instance, or `nil` if no buffer exists or allocation fails.
    ///
    /// Related SQLite: `sqlite3_aggregate_context`
    @inlinable public func aggregateContext(size: Int32) -> UnsafeMutableRawPointer? {
        sqlite3_aggregate_context(rawValue, size)
    }
}
