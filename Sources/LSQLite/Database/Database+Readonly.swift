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

    @inlinable public func readWriteAccessState(forDatabaseNamed name: UnsafePointer<Int8>) -> ReadWriteAccessState {
        ReadWriteAccessState(rawValue: sqlite3_db_readonly(rawValue, name))
    }
}
