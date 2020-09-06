import MissedSwiftSQLite

extension Database {
    @inlinable public var lastInsertRowid: RowID {
        get {
            RowID(rawValue: sqlite3_last_insert_rowid(rawValue))
        }
        set {
            sqlite3_set_last_insert_rowid(rawValue, newValue.rawValue)
        }
    }
}
