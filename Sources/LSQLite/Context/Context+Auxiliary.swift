import MissedSwiftSQLite

extension Context {
    /// Destructor invoked when auxiliary data attached to a function argument is discarded.
    /// - Parameter data: Auxiliary data pointer previously registered for the argument.
    /// - Returns: None.
    ///
    /// Related SQLite: `sqlite3_set_auxdata`, `sqlite3_get_auxdata`
    public typealias AuxiliaryDataDestructor = @convention(c) (UnsafeMutableRawPointer?) -> Void

    /// Returns per-argument auxiliary data previously set for the given parameter index.
    ///
    /// Cached data may be preserved across repeated calls of the same function
    /// within a single SQL statement, but it can be discarded at any time.
    /// - Parameter argument: Zero-based index of the function argument; must be non-negative.
    /// - Returns: The cached auxiliary data pointer, or `nil` if none is available.
    ///
    /// Related SQLite: `sqlite3_get_auxdata`
    @inlinable public func getAuxiliaryData(forArgument argument: Int32) -> UnsafeMutableRawPointer? {
        sqlite3_get_auxdata(rawValue, argument)
    }

    /// Attaches auxiliary data to the given parameter index with an optional destructor.
    ///
    /// The cache may be discarded if the argument value changes, the statement
    /// is reset or finalized, new data is set for the same argument, or storing
    /// the cache fails. SQLite may also discard the cache immediately if the
    /// function is evaluated during query planning.
    /// The destructor is called exactly once when the cache is discarded and
    /// may be invoked immediately if the cache cannot be stored. Do not access
    /// `data` after calling this method.
    /// - Parameters:
    ///   - data: Pointer to cache, or `nil` to clear it.
    ///   - argument: Zero-based index of the function argument; must be non-negative.
    ///   - destructor: Optional cleanup invoked when the cached data is discarded.
    /// - Returns: None.
    ///
    /// Related SQLite: `sqlite3_set_auxdata`
    @inlinable public func setAuxiliaryData(_ data: UnsafeMutableRawPointer?, forArgument argument: Int32, destructor: AuxiliaryDataDestructor? = nil) {
        sqlite3_set_auxdata(rawValue, argument, data, destructor)
    }
}
