import SQLite3

extension Database {
    @frozen public struct FileName: RawRepresentable {
        public typealias StringLiteralType = String

        public let rawValue: UnsafePointer<Int8>

        @inlinable public init(rawValue: UnsafePointer<Int8>) {
            self.rawValue = rawValue
        }

        public static let memory = Self(rawValue: ":memory:")
        public static let temporary = Self(rawValue: "")
    }

    @frozen public struct OpenFlag: OptionSet {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let readonly = Self(rawValue: SQLITE_OPEN_READONLY)
        public static let readwrite = Self(rawValue: SQLITE_OPEN_READWRITE)
        public static let create = Self(rawValue: SQLITE_OPEN_CREATE)
        public static let deleteOnClose = Self(rawValue: SQLITE_OPEN_DELETEONCLOSE)
        public static let exclusive = Self(rawValue: SQLITE_OPEN_EXCLUSIVE)
        public static let autoproxy = Self(rawValue: SQLITE_OPEN_AUTOPROXY)
        public static let uri = Self(rawValue: SQLITE_OPEN_URI)
        public static let memory = Self(rawValue: SQLITE_OPEN_MEMORY)
        public static let mainDB = Self(rawValue: SQLITE_OPEN_MAIN_DB)
        public static let tempDB = Self(rawValue: SQLITE_OPEN_TEMP_DB)
        public static let transientDB = Self(rawValue: SQLITE_OPEN_TRANSIENT_DB)
        public static let mainJournal = Self(rawValue: SQLITE_OPEN_MAIN_JOURNAL)
        public static let tempJournal = Self(rawValue: SQLITE_OPEN_TEMP_JOURNAL)
        public static let subjournal = Self(rawValue: SQLITE_OPEN_SUBJOURNAL)
        public static let masterJournal = Self(rawValue: SQLITE_OPEN_MASTER_JOURNAL)
        public static let noMutex = Self(rawValue: SQLITE_OPEN_NOMUTEX)
        public static let fullMutex = Self(rawValue: SQLITE_OPEN_FULLMUTEX)
        public static let sharedCache = Self(rawValue: SQLITE_OPEN_SHAREDCACHE)
        public static let privateCache = Self(rawValue: SQLITE_OPEN_PRIVATECACHE)
        public static let wal = Self(rawValue: SQLITE_OPEN_WAL)
        public static let fileProtectionComplete = Self(rawValue: SQLITE_OPEN_FILEPROTECTION_COMPLETE)
        public static let fileProtectionCompleteUnlessOpen = Self(rawValue: SQLITE_OPEN_FILEPROTECTION_COMPLETEUNLESSOPEN)
        public static let fileProtectionCompleteUntilFirstUserAuthentication = Self(rawValue: SQLITE_OPEN_FILEPROTECTION_COMPLETEUNTILFIRSTUSERAUTHENTICATION)
        public static let fileProtectionNone = Self(rawValue: SQLITE_OPEN_FILEPROTECTION_NONE)
        public static let fileProtectionMask = Self(rawValue: SQLITE_OPEN_FILEPROTECTION_MASK)
    }

    public mutating func open(at filename: FileName, withOpenFlags openFlag: OpenFlag) -> ResultCode {
        sqlite3_open_v2(filename.rawValue, &rawValue, openFlag.rawValue, nil).resultCode
    }
}
