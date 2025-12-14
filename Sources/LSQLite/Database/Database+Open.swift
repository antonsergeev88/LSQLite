import MissedSwiftSQLite

extension Database {
    /// SQLite filename wrapper used when opening a connection.
    ///
    /// Related SQLite: `sqlite3_open`, `sqlite3_open_v2`, `sqlite3_temp_directory`
    @frozen public struct FileName: RawRepresentable, @unchecked Sendable {
        public let rawValue: UnsafePointer<Int8>

        /// Creates a filename wrapper from an existing C string.
        ///
        /// Related SQLite: `sqlite3_open`, `sqlite3_open_v2`
        @inlinable public init(rawValue: UnsafePointer<Int8>) {
            self.rawValue = rawValue
        }

        private static let memoryCString: StaticString = ":memory:"
        private static let temporaryCString: StaticString = ""
        private static func staticCStringPointer(from staticString: StaticString) -> UnsafePointer<Int8> {
            UnsafeRawPointer(staticString.utf8Start).assumingMemoryBound(to: Int8.self)
        }

        /// Filename for an in-memory database.
        ///
        /// Related SQLite: `":memory:"`, `sqlite3_open`, `sqlite3_open_v2`
        public static let memory = Self(rawValue: staticCStringPointer(from: memoryCString))

        /// Filename for a temporary on-disk database.
        ///
        /// Related SQLite: `sqlite3_open`, `sqlite3_open_v2`, `sqlite3_temp_directory`
        public static let temporary = Self(rawValue: staticCStringPointer(from: temporaryCString))
    }

    /// Flags passed to `open(_:at:withOpenFlags:)` and custom VFS xOpen calls.
    ///
    /// Related SQLite: `sqlite3_open_v2`, `sqlite3_vfs.xOpen`, `SQLITE_OPEN_*`
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
#if canImport(Darwin)
        public static let fileProtectionComplete = Self(rawValue: SQLITE_OPEN_FILEPROTECTION_COMPLETE)
        public static let fileProtectionCompleteUnlessOpen = Self(rawValue: SQLITE_OPEN_FILEPROTECTION_COMPLETEUNLESSOPEN)
        public static let fileProtectionCompleteUntilFirstUserAuthentication = Self(rawValue: SQLITE_OPEN_FILEPROTECTION_COMPLETEUNTILFIRSTUSERAUTHENTICATION)
        public static let fileProtectionNone = Self(rawValue: SQLITE_OPEN_FILEPROTECTION_NONE)
        public static let fileProtectionMask = Self(rawValue: SQLITE_OPEN_FILEPROTECTION_MASK)
#endif
    }

    /// Opens a database connection at the given filename using the supplied flags.
    /// - Parameters:
    ///   - database: Output connection handle when opening succeeds.
    ///   - filename: Target database path or helper filename like `.memory`.
    ///   - openFlag: Flags controlling open mode and options.
    /// - Returns: Result code from `sqlite3_open_v2`.
    ///
    /// Related SQLite: `sqlite3_open`, `sqlite3_open_v2`, `SQLITE_OPEN_*`, `sqlite3_temp_directory`
    @inlinable public static func open(_ database: inout Database?, at filename: FileName, withOpenFlags openFlag: OpenFlag) -> ResultCode {
        var databasePointer: OpaquePointer? = nil
        let resultCode = sqlite3_open_v2(filename.rawValue, &databasePointer, openFlag.rawValue, nil).resultCode
        database = databasePointer.map(Database.init(rawValue:))
        return resultCode
    }
}
