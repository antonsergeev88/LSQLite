import MissedSwiftSQLite

/// Strongly typed wrapper around SQLite primary and extended result codes returned by API calls.
///
/// Related SQLite: `sqlite3_errcode`, `sqlite3_extended_errcode`, `sqlite3_errstr`, `SQLITE_OK`, `SQLITE_BUSY`, `SQLITE_IOERR_*`
@frozen public struct ResultCode: Equatable, RawRepresentable, CustomDebugStringConvertible {
    public let rawValue: Int32

    @inlinable public init(rawValue: Int32) {
        self.rawValue = rawValue
    }

    /// Successful result
    public static let ok = Self(rawValue: SQLITE_OK)
    /// Generic error
    public static let error = Self(rawValue: SQLITE_ERROR)
    /// Internal logic error in SQLite
    public static let `internal` = Self(rawValue: SQLITE_INTERNAL)
    /// Access permission denied
    public static let permission = Self(rawValue: SQLITE_PERM)
    /// Callback routine requested an abort
    public static let abort = Self(rawValue: SQLITE_ABORT)
    /// The database file is locked
    public static let busy = Self(rawValue: SQLITE_BUSY)
    /// A table in the database is locked
    public static let locked = Self(rawValue: SQLITE_LOCKED)
    /// A malloc() failed
    public static let noMemory = Self(rawValue: SQLITE_NOMEM)
    /// Attempt to write a readonly database
    public static let readonly = Self(rawValue: SQLITE_READONLY)
    /// Operation terminated by sqlite3_interrupt()
    public static let interrupt = Self(rawValue: SQLITE_INTERRUPT)
    /// Some kind of disk I/O error occurred
    public static let ioError = Self(rawValue: SQLITE_IOERR)
    /// The database disk image is malformed
    public static let corrupt = Self(rawValue: SQLITE_CORRUPT)
    /// Unknown opcode in sqlite3_file_control()
    public static let notFound = Self(rawValue: SQLITE_NOTFOUND)
    /// Insertion failed because database is full
    public static let full = Self(rawValue: SQLITE_FULL)
    /// Unable to open the database file
    public static let cantOpen = Self(rawValue: SQLITE_CANTOPEN)
    /// Database lock protocol error
    public static let `protocol` = Self(rawValue: SQLITE_PROTOCOL)
    /// Internal use only
    public static let empty = Self(rawValue: SQLITE_EMPTY)
    /// The database schema changed
    public static let schema = Self(rawValue: SQLITE_SCHEMA)
    /// String or BLOB exceeds size limit
    public static let tooBig = Self(rawValue: SQLITE_TOOBIG)
    /// Abort due to constraint violation
    public static let constraint = Self(rawValue: SQLITE_CONSTRAINT)
    /// Data type mismatch
    public static let mismatch = Self(rawValue: SQLITE_MISMATCH)
    /// Library used incorrectly
    public static let misuse = Self(rawValue: SQLITE_MISUSE)
    /// Uses OS features not supported on host
    public static let noLFS = Self(rawValue: SQLITE_NOLFS)
    /// Authorization denied
    public static let auth = Self(rawValue: SQLITE_AUTH)
    /// Not used
    public static let format = Self(rawValue: SQLITE_FORMAT)
    /// 2nd parameter to sqlite3_bind out of range
    public static let range = Self(rawValue: SQLITE_RANGE)
    /// File opened that is not a database file
    public static let notADB = Self(rawValue: SQLITE_NOTADB)
    /// Notifications from sqlite3_log()
    public static let notice = Self(rawValue: SQLITE_NOTICE)
    /// Warnings from sqlite3_log()
    public static let warning = Self(rawValue: SQLITE_WARNING)
    /// sqlite3_step() has another row ready
    public static let row = Self(rawValue: SQLITE_ROW)
    /// sqlite3_step() has finished executing
    public static let done = Self(rawValue: SQLITE_DONE)

    public static let errorMissingCollSeq = Self(rawValue: LSQLITE_ERROR_MISSING_COLLSEQ)
    public static let errorRetry = Self(rawValue: LSQLITE_ERROR_RETRY)
    public static let errorSnapshot = Self(rawValue: LSQLITE_ERROR_SNAPSHOT)
    public static let ioErrorRead = Self(rawValue: LSQLITE_IOERR_READ)
    public static let ioErrorShortRead = Self(rawValue: LSQLITE_IOERR_SHORT_READ)
    public static let ioErrorWrite = Self(rawValue: LSQLITE_IOERR_WRITE)
    public static let ioErrorFSync = Self(rawValue: LSQLITE_IOERR_FSYNC)
    public static let ioErrorDirFSync = Self(rawValue: LSQLITE_IOERR_DIR_FSYNC)
    public static let ioErrorTruncate = Self(rawValue: LSQLITE_IOERR_TRUNCATE)
    public static let ioErrorFStat = Self(rawValue: LSQLITE_IOERR_FSTAT)
    public static let ioErrorUnlock = Self(rawValue: LSQLITE_IOERR_UNLOCK)
    public static let ioErrorRDLock = Self(rawValue: LSQLITE_IOERR_RDLOCK)
    public static let ioErrorDelete = Self(rawValue: LSQLITE_IOERR_DELETE)
    public static let ioErrorBlocked = Self(rawValue: LSQLITE_IOERR_BLOCKED)
    public static let ioErrorNoMem = Self(rawValue: LSQLITE_IOERR_NOMEM)
    public static let ioErrorAccess = Self(rawValue: LSQLITE_IOERR_ACCESS)
    public static let ioErrorCheckReservedLock = Self(rawValue: LSQLITE_IOERR_CHECKRESERVEDLOCK)
    public static let ioErrorLock = Self(rawValue: LSQLITE_IOERR_LOCK)
    public static let ioErrorClose = Self(rawValue: LSQLITE_IOERR_CLOSE)
    public static let ioErrorDirClose = Self(rawValue: LSQLITE_IOERR_DIR_CLOSE)
    public static let ioErrorShMOpen = Self(rawValue: LSQLITE_IOERR_SHMOPEN)
    public static let ioErrorShMSize = Self(rawValue: LSQLITE_IOERR_SHMSIZE)
    public static let ioErrorShMLock = Self(rawValue: LSQLITE_IOERR_SHMLOCK)
    public static let ioErrorShMMap = Self(rawValue: LSQLITE_IOERR_SHMMAP)
    public static let ioErrorSeek = Self(rawValue: LSQLITE_IOERR_SEEK)
    public static let ioErrorDeleteNoEnt = Self(rawValue: LSQLITE_IOERR_DELETE_NOENT)
    public static let ioErrorMMap = Self(rawValue: LSQLITE_IOERR_MMAP)
    public static let ioErrorGetTempPath = Self(rawValue: LSQLITE_IOERR_GETTEMPPATH)
    public static let ioErrorConvPath = Self(rawValue: LSQLITE_IOERR_CONVPATH)
    public static let ioErrorVNode = Self(rawValue: LSQLITE_IOERR_VNODE)
    public static let ioErrorAuth = Self(rawValue: LSQLITE_IOERR_AUTH)
    public static let ioErrorBeginAtomic = Self(rawValue: LSQLITE_IOERR_BEGIN_ATOMIC)
    public static let ioErrorCommitAtomic = Self(rawValue: LSQLITE_IOERR_COMMIT_ATOMIC)
    public static let ioErrorRollbackAtomic = Self(rawValue: LSQLITE_IOERR_ROLLBACK_ATOMIC)
    public static let lockedSharedCache = Self(rawValue: LSQLITE_LOCKED_SHAREDCACHE)
    public static let lockedVTab = Self(rawValue: LSQLITE_LOCKED_VTAB)
    public static let busyRecovery = Self(rawValue: LSQLITE_BUSY_RECOVERY)
    public static let busySnapshot = Self(rawValue: LSQLITE_BUSY_SNAPSHOT)
    public static let cantOpenNoTempDir = Self(rawValue: LSQLITE_CANTOPEN_NOTEMPDIR)
    public static let cantOpenIsDir = Self(rawValue: LSQLITE_CANTOPEN_ISDIR)
    public static let cantOpenFullPath = Self(rawValue: LSQLITE_CANTOPEN_FULLPATH)
    public static let cantOpenConvPath = Self(rawValue: LSQLITE_CANTOPEN_CONVPATH)
    /// Not Used
    public static let cantOpenDirtyWAL = Self(rawValue: LSQLITE_CANTOPEN_DIRTYWAL)
    public static let corruptVTab = Self(rawValue: LSQLITE_CORRUPT_VTAB)
    public static let corruptSequence = Self(rawValue: LSQLITE_CORRUPT_SEQUENCE)
    public static let readonlyRecovery = Self(rawValue: LSQLITE_READONLY_RECOVERY)
    public static let readonlyCantLock = Self(rawValue: LSQLITE_READONLY_CANTLOCK)
    public static let readonlyRollback = Self(rawValue: LSQLITE_READONLY_ROLLBACK)
    public static let readonlyDBMoved = Self(rawValue: LSQLITE_READONLY_DBMOVED)
    public static let readonlyCantInit = Self(rawValue: LSQLITE_READONLY_CANTINIT)
    public static let readonlyDirectory = Self(rawValue: LSQLITE_READONLY_DIRECTORY)
    public static let abortRollback = Self(rawValue: LSQLITE_ABORT_ROLLBACK)
    public static let constraintCheck = Self(rawValue: LSQLITE_CONSTRAINT_CHECK)
    public static let constraintCommitHook = Self(rawValue: LSQLITE_CONSTRAINT_COMMITHOOK)
    public static let constraintForeignKey = Self(rawValue: LSQLITE_CONSTRAINT_FOREIGNKEY)
    public static let constraintFunction = Self(rawValue: LSQLITE_CONSTRAINT_FUNCTION)
    public static let constraintNotNull = Self(rawValue: LSQLITE_CONSTRAINT_NOTNULL)
    public static let constraintPrimaryKey = Self(rawValue: LSQLITE_CONSTRAINT_PRIMARYKEY)
    public static let constraintTrigger = Self(rawValue: LSQLITE_CONSTRAINT_TRIGGER)
    public static let constraintUnique = Self(rawValue: LSQLITE_CONSTRAINT_UNIQUE)
    public static let constraintVTab = Self(rawValue: LSQLITE_CONSTRAINT_VTAB)
    public static let constraintRowID = Self(rawValue: LSQLITE_CONSTRAINT_ROWID)
    public static let noticeRecoverWAL = Self(rawValue: LSQLITE_NOTICE_RECOVER_WAL)
    public static let noticeRecoverRollback = Self(rawValue: LSQLITE_NOTICE_RECOVER_ROLLBACK)
    public static let warningAutoIndex = Self(rawValue: LSQLITE_WARNING_AUTOINDEX)
    public static let authUser = Self(rawValue: LSQLITE_AUTH_USER)
    public static let okLoadPermanently = Self(rawValue: LSQLITE_OK_LOAD_PERMANENTLY)

    /// Human-readable description for this result code.
    ///
    /// Related SQLite: `sqlite3_errstr`, `sqlite3_errcode`, `sqlite3_extended_errcode`
    @available(iOS 8.2, macOS 10.10, tvOS 8.2, watchOS 2.0, *)
    @inlinable public var errorString: UnsafePointer<Int8> {
        sqlite3_errstr(rawValue)
    }

    /// Debug-friendly constant name for this result code.
    ///
    /// Related SQLite: `sqlite3_errcode`, `sqlite3_extended_errcode`, `SQLITE_*`
    public var debugDescription: String {
        switch self {
        case .ok: return "SQLITE_OK"
        case .error: return "SQLITE_ERROR"
        case .internal: return "SQLITE_INTERNAL"
        case .permission: return "SQLITE_PERM"
        case .abort: return "SQLITE_ABORT"
        case .busy: return "SQLITE_BUSY"
        case .locked: return "SQLITE_LOCKED"
        case .noMemory: return "SQLITE_NOMEM"
        case .readonly: return "SQLITE_READONLY"
        case .interrupt: return "SQLITE_INTERRUPT"
        case .ioError: return "SQLITE_IOERR"
        case .corrupt: return "SQLITE_CORRUPT"
        case .notFound: return "SQLITE_NOTFOUND"
        case .full: return "SQLITE_FULL"
        case .cantOpen: return "SQLITE_CANTOPEN"
        case .protocol: return "SQLITE_PROTOCOL"
        case .empty: return "SQLITE_EMPTY"
        case .schema: return "SQLITE_SCHEMA"
        case .tooBig: return "SQLITE_TOOBIG"
        case .constraint: return "SQLITE_CONSTRAINT"
        case .mismatch: return "SQLITE_MISMATCH"
        case .misuse: return "SQLITE_MISUSE"
        case .noLFS: return "SQLITE_NOLFS"
        case .auth: return "SQLITE_AUTH"
        case .format: return "SQLITE_FORMAT"
        case .range: return "SQLITE_RANGE"
        case .notADB: return "SQLITE_NOTADB"
        case .notice: return "SQLITE_NOTICE"
        case .warning: return "SQLITE_WARNING"
        case .row: return "SQLITE_ROW"
        case .done: return "SQLITE_DONE"

        case .errorMissingCollSeq: return "SQLITE_ERROR_MISSING_COLLSEQ"
        case .errorRetry: return "SQLITE_ERROR_RETRY"
        case .errorSnapshot: return "SQLITE_ERROR_SNAPSHOT"
        case .ioErrorRead: return "SQLITE_IOERR_READ"
        case .ioErrorShortRead: return "SQLITE_IOERR_SHORT_READ"
        case .ioErrorWrite: return "SQLITE_IOERR_WRITE"
        case .ioErrorFSync: return "SQLITE_IOERR_FSYNC"
        case .ioErrorDirFSync: return "SQLITE_IOERR_DIR_FSYNC"
        case .ioErrorTruncate: return "SQLITE_IOERR_TRUNCATE"
        case .ioErrorFStat: return "SQLITE_IOERR_FSTAT"
        case .ioErrorUnlock: return "SQLITE_IOERR_UNLOCK"
        case .ioErrorRDLock: return "SQLITE_IOERR_RDLOCK"
        case .ioErrorDelete: return "SQLITE_IOERR_DELETE"
        case .ioErrorBlocked: return "SQLITE_IOERR_BLOCKED"
        case .ioErrorNoMem: return "SQLITE_IOERR_NOMEM"
        case .ioErrorAccess: return "SQLITE_IOERR_ACCESS"
        case .ioErrorCheckReservedLock: return "SQLITE_IOERR_CHECKRESERVEDLOCK"
        case .ioErrorLock: return "SQLITE_IOERR_LOCK"
        case .ioErrorClose: return "SQLITE_IOERR_CLOSE"
        case .ioErrorDirClose: return "SQLITE_IOERR_DIR_CLOSE"
        case .ioErrorShMOpen: return "SQLITE_IOERR_SHMOPEN"
        case .ioErrorShMSize: return "SQLITE_IOERR_SHMSIZE"
        case .ioErrorShMLock: return "SQLITE_IOERR_SHMLOCK"
        case .ioErrorShMMap: return "SQLITE_IOERR_SHMMAP"
        case .ioErrorSeek: return "SQLITE_IOERR_SEEK"
        case .ioErrorDeleteNoEnt: return "SQLITE_IOERR_DELETE_NOENT"
        case .ioErrorMMap: return "SQLITE_IOERR_MMAP"
        case .ioErrorGetTempPath: return "SQLITE_IOERR_GETTEMPPATH"
        case .ioErrorConvPath: return "SQLITE_IOERR_CONVPATH"
        case .ioErrorVNode: return "SQLITE_IOERR_VNODE"
        case .ioErrorAuth: return "SQLITE_IOERR_AUTH"
        case .ioErrorBeginAtomic: return "SQLITE_IOERR_BEGIN_ATOMIC"
        case .ioErrorCommitAtomic: return "SQLITE_IOERR_COMMIT_ATOMIC"
        case .ioErrorRollbackAtomic: return "SQLITE_IOERR_ROLLBACK_ATOMIC"
        case .lockedSharedCache: return "SQLITE_LOCKED_SHAREDCACHE"
        case .lockedVTab: return "SQLITE_LOCKED_VTAB"
        case .busyRecovery: return "SQLITE_BUSY_RECOVERY"
        case .busySnapshot: return "SQLITE_BUSY_SNAPSHOT"
        case .cantOpenNoTempDir: return "SQLITE_CANTOPEN_NOTEMPDIR"
        case .cantOpenIsDir: return "SQLITE_CANTOPEN_ISDIR"
        case .cantOpenFullPath: return "SQLITE_CANTOPEN_FULLPATH"
        case .cantOpenConvPath: return "SQLITE_CANTOPEN_CONVPATH"
        case .cantOpenDirtyWAL: return "SQLITE_CANTOPEN_DIRTYWAL"
        case .corruptVTab: return "SQLITE_CORRUPT_VTAB"
        case .corruptSequence: return "SQLITE_CORRUPT_SEQUENCE"
        case .readonlyRecovery: return "SQLITE_READONLY_RECOVERY"
        case .readonlyCantLock: return "SQLITE_READONLY_CANTLOCK"
        case .readonlyRollback: return "SQLITE_READONLY_ROLLBACK"
        case .readonlyDBMoved: return "SQLITE_READONLY_DBMOVED"
        case .readonlyCantInit: return "SQLITE_READONLY_CANTINIT"
        case .readonlyDirectory: return "SQLITE_READONLY_DIRECTORY"
        case .abortRollback: return "SQLITE_ABORT_ROLLBACK"
        case .constraintCheck: return "SQLITE_CONSTRAINT_CHECK"
        case .constraintCommitHook: return "SQLITE_CONSTRAINT_COMMITHOOK"
        case .constraintForeignKey: return "SQLITE_CONSTRAINT_FOREIGNKEY"
        case .constraintFunction: return "SQLITE_CONSTRAINT_FUNCTION"
        case .constraintNotNull: return "SQLITE_CONSTRAINT_NOTNULL"
        case .constraintPrimaryKey: return "SQLITE_CONSTRAINT_PRIMARYKEY"
        case .constraintTrigger: return "SQLITE_CONSTRAINT_TRIGGER"
        case .constraintUnique: return "SQLITE_CONSTRAINT_UNIQUE"
        case .constraintVTab: return "SQLITE_CONSTRAINT_VTAB"
        case .constraintRowID: return "SQLITE_CONSTRAINT_ROWID"
        case .noticeRecoverWAL: return "SQLITE_NOTICE_RECOVER_WAL"
        case .noticeRecoverRollback: return "SQLITE_NOTICE_RECOVER_ROLLBACK"
        case .warningAutoIndex: return "SQLITE_WARNING_AUTOINDEX"
        case .authUser: return "SQLITE_AUTH_USER"
        case .okLoadPermanently: return "SQLITE_OK_LOAD_PERMANENTLY"
        default: return "ResultCode(rawValue: \(rawValue))"
        }
    }
}

extension Int32 {
    @usableFromInline var resultCode: ResultCode {
        .init(rawValue: self)
    }
}
