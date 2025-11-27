import MissedSwiftSQLite

/// Global folder path used for relative database files when the Windows VFS is in play.
/// Set `dataDirectory` once during startup; mutating it while connections are open can corrupt databases.
///
/// Related SQLite: `sqlite3_data_directory`, `data_store_directory pragma`
@inlinable public var dataDirectory: UnsafeMutablePointer<Int8>? {
    get {
        sqlite3_data_directory
    }
    set {
        sqlite3_data_directory = newValue
    }
}
