import MissedSwiftSQLite

extension Context {
    public typealias AuxiliaryDataDestructor = @convention(c) (UnsafeMutableRawPointer?) -> Void

    @inlinable public func getAuxiliaryData(forArgument argument: Int32) -> UnsafeMutableRawPointer? {
        sqlite3_get_auxdata(rawValue, argument)
    }

    @inlinable public func setAuxiliaryData(_ data: UnsafeMutableRawPointer?, forArgument argument: Int32, destructor: AuxiliaryDataDestructor? = nil) {
        sqlite3_set_auxdata(rawValue, argument, data, destructor)
    }
}
