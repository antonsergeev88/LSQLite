import MissedSwiftSQLite

extension Database {
    @inlinable public func filename(forDatabaseNamed name: UnsafePointer<Int8>) -> UnsafePointer<Int8>? {
        sqlite3_db_filename(rawValue, name)
    }
}
