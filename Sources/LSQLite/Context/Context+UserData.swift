import SQLite3

extension Context {
    /// Retrieves the user data pointer supplied when the function was registered.
    ///
    /// Related SQLite: `sqlite3_user_data`, `sqlite3_create_function_v2`
    @inlinable public var userData: UnsafeMutableRawPointer? {
        sqlite3_user_data(rawValue)
    }
}
