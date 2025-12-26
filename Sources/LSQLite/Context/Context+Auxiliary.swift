import SQLite3

extension Context {
    /// Destructor invoked when SQLite frees auxiliary data attached to a function argument.
    ///
    /// Related SQLite: `sqlite3_set_auxdata`, `sqlite3_get_auxdata`
    public typealias AuxiliaryDataDestructor = @convention(c) (UnsafeMutableRawPointer?) -> Void

    /// Returns per-argument auxiliary data previously set for the given parameter index.
    ///
    /// Related SQLite: `sqlite3_get_auxdata`
    @inlinable public func getAuxiliaryData(forArgument argument: Int32) -> UnsafeMutableRawPointer? {
        sqlite3_get_auxdata(rawValue, argument)
    }

    /// Attaches auxiliary data to the given parameter index with optional destructor.
    ///
    /// Related SQLite: `sqlite3_set_auxdata`
    @inlinable public func setAuxiliaryData(_ data: UnsafeMutableRawPointer?, forArgument argument: Int32, destructor: AuxiliaryDataDestructor? = nil) {
        sqlite3_set_auxdata(rawValue, argument, data, destructor)
    }
}
