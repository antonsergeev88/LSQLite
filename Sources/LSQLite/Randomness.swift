import MissedSwiftSQLite

/// Fills a buffer with pseudo-random bytes from SQLite's internal generator (same as `random()`/`randomblob()`).
/// - Parameters:
///   - count: Number of bytes to write.
///   - buffer: Destination buffer; must have space for `count` bytes.
///
/// Related SQLite: `sqlite3_randomness`, `random()`, `randomblob()`, `sqlite3_vfs.xRandomness`
@inlinable public func randomness(byteCount count: Int32, into buffer: UnsafeMutableRawPointer) {
    sqlite3_randomness(count, buffer)
}
