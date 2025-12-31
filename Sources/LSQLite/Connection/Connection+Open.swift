import MissedSwiftSQLite

extension Connection {
    /// Filename wrapper used when opening a connection.
    ///
    /// For `file:` URIs, pass the full URI string as `rawValue` and include `.uri` in the open flags.
    ///
    /// Related SQLite: `sqlite3_open`, `sqlite3_open_v2`, `sqlite3_temp_directory`, `SQLITE_OPEN_URI`
    @frozen public struct FileName: RawRepresentable, CustomStringConvertible {
        public let rawValue: String

        /// Creates a filename wrapper from a Swift string.
        /// - Parameter rawValue: Database path or URI string to open.
        ///
        /// Related SQLite: `sqlite3_open`, `sqlite3_open_v2`
        @inlinable public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Filename for a private in-memory database.
        ///
        /// The database exists only for the lifetime of the connection.
        ///
        /// Related SQLite: `":memory:"`, `sqlite3_open`, `sqlite3_open_v2`
        public static let memory = Self(rawValue: ":memory:")

        /// Filename for a private temporary on-disk database.
        ///
        /// The file is deleted automatically when the connection closes.
        ///
        /// Related SQLite: `sqlite3_open`, `sqlite3_open_v2`, `sqlite3_temp_directory`
        public static let temporary = Self(rawValue: "")

        public var description: String {
            rawValue.description
        }
    }

    /// Flags passed to `open(_:at:withOpenFlags:)` and to custom VFS open calls.
    ///
    /// Related SQLite: `sqlite3_open_v2`, `sqlite3_vfs.xOpen`, `SQLITE_OPEN_*`
    @frozen public struct OpenFlag: OptionSet, CustomStringConvertible, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        /// Opens the database in read-only mode.
        ///
        /// Related SQLite: `SQLITE_OPEN_READONLY`
        public static let readonly = Self(rawValue: SQLITE_OPEN_READONLY)
        /// Opens the database for read/write access when possible.
        ///
        /// Related SQLite: `SQLITE_OPEN_READWRITE`
        public static let readwrite = Self(rawValue: SQLITE_OPEN_READWRITE)
        /// Creates the database file if it does not exist.
        ///
        /// Related SQLite: `SQLITE_OPEN_CREATE`
        public static let create = Self(rawValue: SQLITE_OPEN_CREATE)
        /// VFS-only flag that deletes the file when it is closed.
        ///
        /// Related SQLite: `SQLITE_OPEN_DELETEONCLOSE`
        public static let deleteOnClose = Self(rawValue: SQLITE_OPEN_DELETEONCLOSE)
        /// VFS-only flag indicating the file should be created exclusively.
        ///
        /// Related SQLite: `SQLITE_OPEN_EXCLUSIVE`
        public static let exclusive = Self(rawValue: SQLITE_OPEN_EXCLUSIVE)
        /// Enables auto-proxy for shared cache mode.
        ///
        /// Related SQLite: `SQLITE_OPEN_AUTOPROXY`
        public static let autoproxy = Self(rawValue: SQLITE_OPEN_AUTOPROXY)
        /// Interprets the filename as a URI.
        ///
        /// Related SQLite: `SQLITE_OPEN_URI`
        public static let uri = Self(rawValue: SQLITE_OPEN_URI)
        /// Opens a pure in-memory database.
        ///
        /// Related SQLite: `SQLITE_OPEN_MEMORY`
        public static let memory = Self(rawValue: SQLITE_OPEN_MEMORY)
        /// VFS-only flag for the main database file.
        ///
        /// Related SQLite: `SQLITE_OPEN_MAIN_DB`
        public static let mainDB = Self(rawValue: SQLITE_OPEN_MAIN_DB)
        /// VFS-only flag for the temp database file.
        ///
        /// Related SQLite: `SQLITE_OPEN_TEMP_DB`
        public static let tempDB = Self(rawValue: SQLITE_OPEN_TEMP_DB)
        /// VFS-only flag for transient database files.
        ///
        /// Related SQLite: `SQLITE_OPEN_TRANSIENT_DB`
        public static let transientDB = Self(rawValue: SQLITE_OPEN_TRANSIENT_DB)
        /// VFS-only flag for the main journal file.
        ///
        /// Related SQLite: `SQLITE_OPEN_MAIN_JOURNAL`
        public static let mainJournal = Self(rawValue: SQLITE_OPEN_MAIN_JOURNAL)
        /// VFS-only flag for the temp journal file.
        ///
        /// Related SQLite: `SQLITE_OPEN_TEMP_JOURNAL`
        public static let tempJournal = Self(rawValue: SQLITE_OPEN_TEMP_JOURNAL)
        /// VFS-only flag for subjournal files.
        ///
        /// Related SQLite: `SQLITE_OPEN_SUBJOURNAL`
        public static let subjournal = Self(rawValue: SQLITE_OPEN_SUBJOURNAL)
        /// VFS-only flag for the super/master journal file.
        ///
        /// Related SQLite: `SQLITE_OPEN_MASTER_JOURNAL`
        public static let masterJournal = Self(rawValue: SQLITE_OPEN_MASTER_JOURNAL)
        /// Opens the connection in multi-thread mode without per-connection mutexes.
        ///
        /// Related SQLite: `SQLITE_OPEN_NOMUTEX`
        public static let noMutex = Self(rawValue: SQLITE_OPEN_NOMUTEX)
        /// Opens the connection in serialized mode with full mutexes.
        ///
        /// Related SQLite: `SQLITE_OPEN_FULLMUTEX`
        public static let fullMutex = Self(rawValue: SQLITE_OPEN_FULLMUTEX)
        /// Enables shared cache for this connection.
        ///
        /// Related SQLite: `SQLITE_OPEN_SHAREDCACHE`
        public static let sharedCache = Self(rawValue: SQLITE_OPEN_SHAREDCACHE)
        /// Disables shared cache for this connection.
        ///
        /// Related SQLite: `SQLITE_OPEN_PRIVATECACHE`
        public static let privateCache = Self(rawValue: SQLITE_OPEN_PRIVATECACHE)
        /// VFS-only flag for the WAL file.
        ///
        /// Related SQLite: `SQLITE_OPEN_WAL`
        public static let wal = Self(rawValue: SQLITE_OPEN_WAL)
        /// Applies complete file protection on Apple platforms.
        ///
        /// Related SQLite: `SQLITE_OPEN_FILEPROTECTION_COMPLETE`
        public static let fileProtectionComplete = Self(rawValue: SQLITE_OPEN_FILEPROTECTION_COMPLETE)
        /// Applies complete-unless-open file protection on Apple platforms.
        ///
        /// Related SQLite: `SQLITE_OPEN_FILEPROTECTION_COMPLETEUNLESSOPEN`
        public static let fileProtectionCompleteUnlessOpen = Self(rawValue: SQLITE_OPEN_FILEPROTECTION_COMPLETEUNLESSOPEN)
        /// Applies complete-until-first-user-authentication file protection on Apple platforms.
        ///
        /// Related SQLite: `SQLITE_OPEN_FILEPROTECTION_COMPLETEUNTILFIRSTUSERAUTHENTICATION`
        public static let fileProtectionCompleteUntilFirstUserAuthentication = Self(rawValue: SQLITE_OPEN_FILEPROTECTION_COMPLETEUNTILFIRSTUSERAUTHENTICATION)
        /// Disables file protection on Apple platforms.
        ///
        /// Related SQLite: `SQLITE_OPEN_FILEPROTECTION_NONE`
        public static let fileProtectionNone = Self(rawValue: SQLITE_OPEN_FILEPROTECTION_NONE)
        /// Mask for file protection flags on Apple platforms.
        ///
        /// Related SQLite: `SQLITE_OPEN_FILEPROTECTION_MASK`
        public static let fileProtectionMask = Self(rawValue: SQLITE_OPEN_FILEPROTECTION_MASK)

        private static let knownMask: UInt32 = {
            var mask = UInt32(bitPattern: Self.readonly.rawValue)
            mask |= UInt32(bitPattern: Self.readwrite.rawValue)
            mask |= UInt32(bitPattern: Self.create.rawValue)
            mask |= UInt32(bitPattern: Self.deleteOnClose.rawValue)
            mask |= UInt32(bitPattern: Self.exclusive.rawValue)
            mask |= UInt32(bitPattern: Self.autoproxy.rawValue)
            mask |= UInt32(bitPattern: Self.uri.rawValue)
            mask |= UInt32(bitPattern: Self.memory.rawValue)
            mask |= UInt32(bitPattern: Self.mainDB.rawValue)
            mask |= UInt32(bitPattern: Self.tempDB.rawValue)
            mask |= UInt32(bitPattern: Self.transientDB.rawValue)
            mask |= UInt32(bitPattern: Self.mainJournal.rawValue)
            mask |= UInt32(bitPattern: Self.tempJournal.rawValue)
            mask |= UInt32(bitPattern: Self.subjournal.rawValue)
            mask |= UInt32(bitPattern: Self.masterJournal.rawValue)
            mask |= UInt32(bitPattern: Self.noMutex.rawValue)
            mask |= UInt32(bitPattern: Self.fullMutex.rawValue)
            mask |= UInt32(bitPattern: Self.sharedCache.rawValue)
            mask |= UInt32(bitPattern: Self.privateCache.rawValue)
            mask |= UInt32(bitPattern: Self.wal.rawValue)
            mask |= UInt32(bitPattern: Self.fileProtectionComplete.rawValue)
            mask |= UInt32(bitPattern: Self.fileProtectionCompleteUnlessOpen.rawValue)
            mask |= UInt32(bitPattern: Self.fileProtectionCompleteUntilFirstUserAuthentication.rawValue)
            mask |= UInt32(bitPattern: Self.fileProtectionNone.rawValue)
            mask |= UInt32(bitPattern: Self.fileProtectionMask.rawValue)
            return mask
        }()

        private static func hexString(_ rawValue: UInt32) -> String {
            "0x" + String(rawValue, radix: 16, uppercase: true)
        }

        public var description: String {
            var parts: [String] = []
            if contains(.readonly) { parts.append(".readonly") }
            if contains(.readwrite) { parts.append(".readwrite") }
            if contains(.create) { parts.append(".create") }
            if contains(.deleteOnClose) { parts.append(".deleteOnClose") }
            if contains(.exclusive) { parts.append(".exclusive") }
            if contains(.autoproxy) { parts.append(".autoproxy") }
            if contains(.uri) { parts.append(".uri") }
            if contains(.memory) { parts.append(".memory") }
            if contains(.mainDB) { parts.append(".mainDB") }
            if contains(.tempDB) { parts.append(".tempDB") }
            if contains(.transientDB) { parts.append(".transientDB") }
            if contains(.mainJournal) { parts.append(".mainJournal") }
            if contains(.tempJournal) { parts.append(".tempJournal") }
            if contains(.subjournal) { parts.append(".subjournal") }
            if contains(.masterJournal) { parts.append(".masterJournal") }
            if contains(.noMutex) { parts.append(".noMutex") }
            if contains(.fullMutex) { parts.append(".fullMutex") }
            if contains(.sharedCache) { parts.append(".sharedCache") }
            if contains(.privateCache) { parts.append(".privateCache") }
            if contains(.wal) { parts.append(".wal") }
            if contains(.fileProtectionComplete) { parts.append(".fileProtectionComplete") }
            if contains(.fileProtectionCompleteUnlessOpen) { parts.append(".fileProtectionCompleteUnlessOpen") }
            if contains(.fileProtectionCompleteUntilFirstUserAuthentication) { parts.append(".fileProtectionCompleteUntilFirstUserAuthentication") }
            if contains(.fileProtectionNone) { parts.append(".fileProtectionNone") }
            if contains(.fileProtectionMask) { parts.append(".fileProtectionMask") }

            let rawBits = UInt32(bitPattern: rawValue)
            let unknownBits = rawBits & ~Self.knownMask
            if unknownBits != 0 {
                if parts.isEmpty { return "unknown" }
                parts.append("unknown")
            }
            if parts.isEmpty { return "[]" }
            return "[\(parts.joined(separator: ", "))]"
        }

        public var debugDescription: String {
            var parts: [String] = []
            if contains(.readonly) { parts.append("SQLITE_OPEN_READONLY") }
            if contains(.readwrite) { parts.append("SQLITE_OPEN_READWRITE") }
            if contains(.create) { parts.append("SQLITE_OPEN_CREATE") }
            if contains(.deleteOnClose) { parts.append("SQLITE_OPEN_DELETEONCLOSE") }
            if contains(.exclusive) { parts.append("SQLITE_OPEN_EXCLUSIVE") }
            if contains(.autoproxy) { parts.append("SQLITE_OPEN_AUTOPROXY") }
            if contains(.uri) { parts.append("SQLITE_OPEN_URI") }
            if contains(.memory) { parts.append("SQLITE_OPEN_MEMORY") }
            if contains(.mainDB) { parts.append("SQLITE_OPEN_MAIN_DB") }
            if contains(.tempDB) { parts.append("SQLITE_OPEN_TEMP_DB") }
            if contains(.transientDB) { parts.append("SQLITE_OPEN_TRANSIENT_DB") }
            if contains(.mainJournal) { parts.append("SQLITE_OPEN_MAIN_JOURNAL") }
            if contains(.tempJournal) { parts.append("SQLITE_OPEN_TEMP_JOURNAL") }
            if contains(.subjournal) { parts.append("SQLITE_OPEN_SUBJOURNAL") }
            if contains(.masterJournal) { parts.append("SQLITE_OPEN_MASTER_JOURNAL") }
            if contains(.noMutex) { parts.append("SQLITE_OPEN_NOMUTEX") }
            if contains(.fullMutex) { parts.append("SQLITE_OPEN_FULLMUTEX") }
            if contains(.sharedCache) { parts.append("SQLITE_OPEN_SHAREDCACHE") }
            if contains(.privateCache) { parts.append("SQLITE_OPEN_PRIVATECACHE") }
            if contains(.wal) { parts.append("SQLITE_OPEN_WAL") }
            if contains(.fileProtectionComplete) { parts.append("SQLITE_OPEN_FILEPROTECTION_COMPLETE") }
            if contains(.fileProtectionCompleteUnlessOpen) { parts.append("SQLITE_OPEN_FILEPROTECTION_COMPLETEUNLESSOPEN") }
            if contains(.fileProtectionCompleteUntilFirstUserAuthentication) { parts.append("SQLITE_OPEN_FILEPROTECTION_COMPLETEUNTILFIRSTUSERAUTHENTICATION") }
            if contains(.fileProtectionNone) { parts.append("SQLITE_OPEN_FILEPROTECTION_NONE") }
            if contains(.fileProtectionMask) { parts.append("SQLITE_OPEN_FILEPROTECTION_MASK") }

            let rawBits = UInt32(bitPattern: rawValue)
            let unknownBits = rawBits & ~Self.knownMask
            if unknownBits != 0 {
                let hexValue = Self.hexString(rawBits)
                if parts.isEmpty { return hexValue }
                parts.append(hexValue)
            }
            if parts.isEmpty { return "[]" }
            return parts.joined(separator: "|")
        }
    }

    /// Opens a database connection at the given filename using the supplied flags.
    ///
    /// The `openFlag` value must include one of: `.readonly`, `.readwrite`, or `.readwrite` + `.create`.
    /// Additional flags control URI handling, caching, mutex mode, and other options.
    /// When using `.readonly`, the database must already exist. When using `.readwrite` without
    /// `.create`, the database must already exist and the connection may still open read-only if
    /// the file is write-protected. Use `readWriteAccessState(forDatabaseNamed:)` to check the
    /// actual access mode.
    ///
    /// On success, `connection` is set to a new handle and the result is `.ok`.
    /// On failure, `connection` may still be set to a handle unless the open fails due to
    /// an out-of-memory condition. When a handle is returned, the caller is responsible
    /// for closing it to release resources.
    ///
    /// `FileName.memory` opens a private in-memory database that disappears when the
    /// connection closes. The `.memory` flag also forces an in-memory database, in which
    /// case the filename is used only for cache sharing. `FileName.temporary` creates a
    /// private on-disk database that is deleted on close.
    /// - Parameters:
    ///   - connection: Receives the connection handle; may be set even when the result is an error.
    ///   - filename: Target database path or special filename like `.memory`.
    ///   - openFlag: Flags controlling the open mode and options.
    /// - Returns: Result code from the open attempt.
    ///
    /// Related SQLite: `sqlite3_open`, `sqlite3_open_v2`, `SQLITE_OPEN_*`, `sqlite3_temp_directory`
    @inlinable public static func open(_ connection: inout Connection?, at filename: FileName, withOpenFlags openFlag: OpenFlag) -> ResultCode {
        var connectionPointer: OpaquePointer? = nil
        let resultCode = sqlite3_open_v2(filename.rawValue, &connectionPointer, openFlag.rawValue, nil).resultCode
        connection = connectionPointer.map(Connection.init(rawValue:))
        return resultCode
    }
}
