import MissedSwiftSQLite

extension Database {
    /// Read/write state values returned by `readWriteAccessState(forDatabaseNamed:)`.
    ///
    /// Related SQLite: `sqlite3_db_readonly`
    @frozen public struct ReadWriteAccessState: Hashable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let noDatabase = Self(rawValue: -1)
        public static let readwrite = Self(rawValue: 0)
        public static let readonly = Self(rawValue: 1)

        /// Debug label for the access state.
        ///
        /// Related SQLite: `sqlite3_db_readonly`
        public var debugDescription: String {
            switch self {
            case .noDatabase: return "LSQLITE_NO_DATABASE"
            case .readwrite: return "LSQLITE_READWRITE)"
            case .readonly: return "LSQLITE_READONLY)"
            default: return "ReadWriteAccessState(rawValue: \(rawValue))"
            }
        }
    }

    /// Reports whether the named database is read-only, read/write, or missing on this connection.
    /// - Parameter name: Database name (e.g. `"main"` or an attached alias).
    /// - Returns: A `ReadWriteAccessState` describing access mode.
    ///
    /// Related SQLite: `sqlite3_db_readonly`
    @inlinable public func readWriteAccessState(forDatabaseNamed name: String) -> ReadWriteAccessState {
        ReadWriteAccessState(rawValue: sqlite3_db_readonly(rawValue, name))
    }
}
