import MissedSwiftSQLite

extension Context {
    /// Retrieves the user data pointer supplied when the function was registered.
    ///
    /// The returned pointer is the same for every invocation of the function.
    /// - Returns: The registered user-data pointer, or `nil` if none was provided.
    ///
    /// Related SQLite: `sqlite3_user_data`, `sqlite3_create_function_v2`
    @inlinable public var userData: UnsafeMutableRawPointer? {
        sqlite3_user_data(rawValue)
    }
}
