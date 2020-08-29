import SQLite3

extension Database {
    @inlinable public func interrupt() {
        sqlite3_interrupt(rawValue)
    }
}
