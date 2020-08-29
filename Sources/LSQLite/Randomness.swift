import SQLite3

@inlinable public func randomness(byteCount count: Int32, into buffer: UnsafeMutableRawPointer) {
    sqlite3_randomness(count, buffer)
}