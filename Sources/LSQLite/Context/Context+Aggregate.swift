import MissedSwiftSQLite

extension Context {
    @inlinable public func aggregateContext(size: Int32) -> UnsafeMutableRawPointer? {
        sqlite3_aggregate_context(rawValue, size)
    }
}
