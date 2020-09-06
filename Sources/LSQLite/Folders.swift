import MissedSwiftSQLite

@inlinable public var dataDirectory: UnsafeMutablePointer<Int8>? {
    get {
        sqlite3_data_directory
    }
    set {
        sqlite3_data_directory = newValue
    }
}
