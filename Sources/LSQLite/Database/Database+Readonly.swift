import MissedSwiftSQLite

extension Database {
    @frozen public struct ReadWriteAccessState: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let noDatabase = Self(rawValue: -1)
        public static let readwrite = Self(rawValue: 0)
        public static let readonly = Self(rawValue: 1)

        public var debugDescription: String {
            switch self {
            case .noDatabase: return "LSQLITE_NO_DATABASE"
            case .readwrite: return "LSQLITE_READWRITE)"
            case .readonly: return "LSQLITE_READONLY)"
            default: return "ReadWriteAccessState(rawValue: \(rawValue))"
            }
        }
    }

    /**
     CAPI3REF: Determine if a database is read-only
     METHOD: sqlite3

     ^The sqlite3_db_readonly(D,N) interface returns 1 if the database N
     of connection D is read-only, 0 if it is read/write, or -1 if N is not
     the name of a database on connection D.
    */
    @inlinable public func readWriteAccessState(forDatabaseNamed name: UnsafePointer<Int8>) -> ReadWriteAccessState {
        ReadWriteAccessState(rawValue: sqlite3_db_readonly(rawValue, name))
    }
}
