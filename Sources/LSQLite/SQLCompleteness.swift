import SQLite3

@inlinable public func sqlIsComplete(_ sql: UnsafePointer<Int8>) -> Bool {
    sqlite3_complete(sql) != 0
}