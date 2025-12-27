import MissedSwiftSQLite

/// Strongly typed wrapper around SQLite primary and extended result codes returned by API calls.
///
/// Related SQLite: `sqlite3_errcode`, `sqlite3_extended_errcode`, `sqlite3_errstr`, `SQLITE_OK`, `SQLITE_BUSY`, `SQLITE_IOERR_*`
@frozen public struct ResultCode: Hashable, RawRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
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
    @inlinable public var errorString: String? {
        let cString = sqlite3_errstr(rawValue)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        guard !string.isEmpty else {
            return nil
        }
        return string
    }

    public var description: String {
        switch self {
        case .ok: "ok"
        case .error: "error"
        case .internal: "internal"
        case .permission: "permission"
        case .abort: "abort"
        case .busy: "busy"
        case .locked: "locked"
        case .noMemory: "no memory"
        case .readonly: "readonly"
        case .interrupt: "interrupt"
        case .ioError: "io error"
        case .corrupt: "corrupt"
        case .notFound: "not found"
        case .full: "full"
        case .cantOpen: "can't open"
        case .protocol: "protocol"
        case .empty: "empty"
        case .schema: "schema"
        case .tooBig: "too big"
        case .constraint: "constraint"
        case .mismatch: "mismatch"
        case .misuse: "misuse"
        case .noLFS: "no LFS"
        case .auth: "auth"
        case .format: "format"
        case .range: "range"
        case .notADB: "not ADB"
        case .notice: "notice"
        case .warning: "warning"
        case .row: "row"
        case .done: "done"

        case .errorMissingCollSeq: "error: missing coll seq"
        case .errorRetry: "error: retry"
        case .errorSnapshot: "error: snapshot"

        case .ioErrorRead: "io error: read"
        case .ioErrorShortRead: "io error: short read"
        case .ioErrorWrite: "io error: write"
        case .ioErrorFSync: "io error: fsync"
        case .ioErrorDirFSync: "io error: dir fsync"
        case .ioErrorTruncate: "io error: truncate"
        case .ioErrorFStat: "io error: fstat"
        case .ioErrorUnlock: "io error: unlock"
        case .ioErrorRDLock: "io error: rdlock"
        case .ioErrorDelete: "io error: delete"
        case .ioErrorBlocked: "io error: blocked"
        case .ioErrorNoMem: "io error: no memory"
        case .ioErrorAccess: "io error: access"
        case .ioErrorCheckReservedLock: "io error: check reserved lock"
        case .ioErrorLock: "io error: lock"
        case .ioErrorClose: "io error: close"
        case .ioErrorDirClose: "io error: dir close"
        case .ioErrorShMOpen: "io error: shm open"
        case .ioErrorShMSize: "io error: shm size"
        case .ioErrorShMLock: "io error: shm lock"
        case .ioErrorShMMap: "io error: shm map"
        case .ioErrorSeek: "io error: seek"
        case .ioErrorDeleteNoEnt: "io error: delete no entry"
        case .ioErrorMMap: "io error: mmap"
        case .ioErrorGetTempPath: "io error: get temp path"
        case .ioErrorConvPath: "io error: conv path"
        case .ioErrorVNode: "io error: vnode"
        case .ioErrorAuth: "io error: auth"
        case .ioErrorBeginAtomic: "io error: begin atomic"
        case .ioErrorCommitAtomic: "io error: commit atomic"
        case .ioErrorRollbackAtomic: "io error: rollback atomic"

        case .lockedSharedCache: "locked: shared cache"
        case .lockedVTab: "locked: vtab"

        case .busyRecovery: "busy: recovery"
        case .busySnapshot: "busy: snapshot"

        case .cantOpenNoTempDir: "can't open: no temp dir"
        case .cantOpenIsDir: "can't open: is dir"
        case .cantOpenFullPath: "can't open: full path"
        case .cantOpenConvPath: "can't open: conv path"
        case .cantOpenDirtyWAL: "can't open: dirty wal"

        case .corruptVTab: "corrupt: vtab"
        case .corruptSequence: "corrupt: sequence"

        case .readonlyRecovery: "readonly: recovery"
        case .readonlyCantLock: "readonly: can't lock"
        case .readonlyRollback: "readonly: rollback"
        case .readonlyDBMoved: "readonly: db moved"
        case .readonlyCantInit: "readonly: can't init"
        case .readonlyDirectory: "readonly: directory"

        case .abortRollback: "abort: rollback"

        case .constraintCheck: "constraint: check"
        case .constraintCommitHook: "constraint: commit hook"
        case .constraintForeignKey: "constraint: foreign key"
        case .constraintFunction: "constraint: function"
        case .constraintNotNull: "constraint: not null"
        case .constraintPrimaryKey: "constraint: primary key"
        case .constraintTrigger: "constraint: trigger"
        case .constraintUnique: "constraint: unique"
        case .constraintVTab: "constraint: vtab"
        case .constraintRowID: "constraint: rowid"

        case .noticeRecoverWAL: "notice: recover wal"
        case .noticeRecoverRollback: "notice: recover rollback"

        case .warningAutoIndex: "warning: auto index"

        case .authUser: "auth: user"

        case .okLoadPermanently: "ok: load permanently"

        default: "unknown"
        }
    }

    public var debugDescription: String {
        switch self {
        case .ok: "SQLITE_OK"
        case .error: "SQLITE_ERROR"
        case .internal: "SQLITE_INTERNAL"
        case .permission: "SQLITE_PERM"
        case .abort: "SQLITE_ABORT"
        case .busy: "SQLITE_BUSY"
        case .locked: "SQLITE_LOCKED"
        case .noMemory: "SQLITE_NOMEM"
        case .readonly: "SQLITE_READONLY"
        case .interrupt: "SQLITE_INTERRUPT"
        case .ioError: "SQLITE_IOERR"
        case .corrupt: "SQLITE_CORRUPT"
        case .notFound: "SQLITE_NOTFOUND"
        case .full: "SQLITE_FULL"
        case .cantOpen: "SQLITE_CANTOPEN"
        case .protocol: "SQLITE_PROTOCOL"
        case .empty: "SQLITE_EMPTY"
        case .schema: "SQLITE_SCHEMA"
        case .tooBig: "SQLITE_TOOBIG"
        case .constraint: "SQLITE_CONSTRAINT"
        case .mismatch: "SQLITE_MISMATCH"
        case .misuse: "SQLITE_MISUSE"
        case .noLFS: "SQLITE_NOLFS"
        case .auth: "SQLITE_AUTH"
        case .format: "SQLITE_FORMAT"
        case .range: "SQLITE_RANGE"
        case .notADB: "SQLITE_NOTADB"
        case .notice: "SQLITE_NOTICE"
        case .warning: "SQLITE_WARNING"
        case .row: "SQLITE_ROW"
        case .done: "SQLITE_DONE"

        case .errorMissingCollSeq: "SQLITE_ERROR_MISSING_COLLSEQ"
        case .errorRetry: "SQLITE_ERROR_RETRY"
        case .errorSnapshot: "SQLITE_ERROR_SNAPSHOT"
        case .ioErrorRead: "SQLITE_IOERR_READ"
        case .ioErrorShortRead: "SQLITE_IOERR_SHORT_READ"
        case .ioErrorWrite: "SQLITE_IOERR_WRITE"
        case .ioErrorFSync: "SQLITE_IOERR_FSYNC"
        case .ioErrorDirFSync: "SQLITE_IOERR_DIR_FSYNC"
        case .ioErrorTruncate: "SQLITE_IOERR_TRUNCATE"
        case .ioErrorFStat: "SQLITE_IOERR_FSTAT"
        case .ioErrorUnlock: "SQLITE_IOERR_UNLOCK"
        case .ioErrorRDLock: "SQLITE_IOERR_RDLOCK"
        case .ioErrorDelete: "SQLITE_IOERR_DELETE"
        case .ioErrorBlocked: "SQLITE_IOERR_BLOCKED"
        case .ioErrorNoMem: "SQLITE_IOERR_NOMEM"
        case .ioErrorAccess: "SQLITE_IOERR_ACCESS"
        case .ioErrorCheckReservedLock: "SQLITE_IOERR_CHECKRESERVEDLOCK"
        case .ioErrorLock: "SQLITE_IOERR_LOCK"
        case .ioErrorClose: "SQLITE_IOERR_CLOSE"
        case .ioErrorDirClose: "SQLITE_IOERR_DIR_CLOSE"
        case .ioErrorShMOpen: "SQLITE_IOERR_SHMOPEN"
        case .ioErrorShMSize: "SQLITE_IOERR_SHMSIZE"
        case .ioErrorShMLock: "SQLITE_IOERR_SHMLOCK"
        case .ioErrorShMMap: "SQLITE_IOERR_SHMMAP"
        case .ioErrorSeek: "SQLITE_IOERR_SEEK"
        case .ioErrorDeleteNoEnt: "SQLITE_IOERR_DELETE_NOENT"
        case .ioErrorMMap: "SQLITE_IOERR_MMAP"
        case .ioErrorGetTempPath: "SQLITE_IOERR_GETTEMPPATH"
        case .ioErrorConvPath: "SQLITE_IOERR_CONVPATH"
        case .ioErrorVNode: "SQLITE_IOERR_VNODE"
        case .ioErrorAuth: "SQLITE_IOERR_AUTH"
        case .ioErrorBeginAtomic: "SQLITE_IOERR_BEGIN_ATOMIC"
        case .ioErrorCommitAtomic: "SQLITE_IOERR_COMMIT_ATOMIC"
        case .ioErrorRollbackAtomic: "SQLITE_IOERR_ROLLBACK_ATOMIC"
        case .lockedSharedCache: "SQLITE_LOCKED_SHAREDCACHE"
        case .lockedVTab: "SQLITE_LOCKED_VTAB"
        case .busyRecovery: "SQLITE_BUSY_RECOVERY"
        case .busySnapshot: "SQLITE_BUSY_SNAPSHOT"
        case .cantOpenNoTempDir: "SQLITE_CANTOPEN_NOTEMPDIR"
        case .cantOpenIsDir: "SQLITE_CANTOPEN_ISDIR"
        case .cantOpenFullPath: "SQLITE_CANTOPEN_FULLPATH"
        case .cantOpenConvPath: "SQLITE_CANTOPEN_CONVPATH"
        case .cantOpenDirtyWAL: "SQLITE_CANTOPEN_DIRTYWAL"
        case .corruptVTab: "SQLITE_CORRUPT_VTAB"
        case .corruptSequence: "SQLITE_CORRUPT_SEQUENCE"
        case .readonlyRecovery: "SQLITE_READONLY_RECOVERY"
        case .readonlyCantLock: "SQLITE_READONLY_CANTLOCK"
        case .readonlyRollback: "SQLITE_READONLY_ROLLBACK"
        case .readonlyDBMoved: "SQLITE_READONLY_DBMOVED"
        case .readonlyCantInit: "SQLITE_READONLY_CANTINIT"
        case .readonlyDirectory: "SQLITE_READONLY_DIRECTORY"
        case .abortRollback: "SQLITE_ABORT_ROLLBACK"
        case .constraintCheck: "SQLITE_CONSTRAINT_CHECK"
        case .constraintCommitHook: "SQLITE_CONSTRAINT_COMMITHOOK"
        case .constraintForeignKey: "SQLITE_CONSTRAINT_FOREIGNKEY"
        case .constraintFunction: "SQLITE_CONSTRAINT_FUNCTION"
        case .constraintNotNull: "SQLITE_CONSTRAINT_NOTNULL"
        case .constraintPrimaryKey: "SQLITE_CONSTRAINT_PRIMARYKEY"
        case .constraintTrigger: "SQLITE_CONSTRAINT_TRIGGER"
        case .constraintUnique: "SQLITE_CONSTRAINT_UNIQUE"
        case .constraintVTab: "SQLITE_CONSTRAINT_VTAB"
        case .constraintRowID: "SQLITE_CONSTRAINT_ROWID"
        case .noticeRecoverWAL: "SQLITE_NOTICE_RECOVER_WAL"
        case .noticeRecoverRollback: "SQLITE_NOTICE_RECOVER_ROLLBACK"
        case .warningAutoIndex: "SQLITE_WARNING_AUTOINDEX"
        case .authUser: "SQLITE_AUTH_USER"
        case .okLoadPermanently: "SQLITE_OK_LOAD_PERMANENTLY"
        default: rawValue.description
        }
    }
}

extension Int32 {
    @usableFromInline var resultCode: ResultCode {
        .init(rawValue: self)
    }
}
