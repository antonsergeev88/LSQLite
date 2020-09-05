import SQLite3

extension Database {
    @inlinable public var changes: Int32 {
        sqlite3_changes(rawValue)
    }
    
    @inlinable public var totalChanges: Int32 {
        sqlite3_total_changes(rawValue)
    }
}
