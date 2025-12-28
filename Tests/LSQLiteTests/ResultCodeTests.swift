import LSQLite
import MissedSwiftSQLite
import Testing

@Suite("ResultCode")
struct ResultCodeRawValueTests {
    @Test("init(rawValue:) preserves rawValue")
    func rawValueRoundTrip() {
        let rawValue = Int32(123)
        let resultCode = ResultCode(rawValue: rawValue)
        #expect(resultCode.rawValue == rawValue)
    }

    @Test("static result codes match SQLite")
    func staticResultCodesMatchSQLite() {
        #expect(ResultCode.ok.rawValue == SQLITE_OK)
        #expect(ResultCode.error.rawValue == SQLITE_ERROR)
        #expect(ResultCode.`internal`.rawValue == SQLITE_INTERNAL)
        #expect(ResultCode.permission.rawValue == SQLITE_PERM)
        #expect(ResultCode.abort.rawValue == SQLITE_ABORT)
        #expect(ResultCode.busy.rawValue == SQLITE_BUSY)
        #expect(ResultCode.locked.rawValue == SQLITE_LOCKED)
        #expect(ResultCode.noMemory.rawValue == SQLITE_NOMEM)
        #expect(ResultCode.readonly.rawValue == SQLITE_READONLY)
        #expect(ResultCode.interrupt.rawValue == SQLITE_INTERRUPT)
        #expect(ResultCode.ioError.rawValue == SQLITE_IOERR)
        #expect(ResultCode.corrupt.rawValue == SQLITE_CORRUPT)
        #expect(ResultCode.notFound.rawValue == SQLITE_NOTFOUND)
        #expect(ResultCode.full.rawValue == SQLITE_FULL)
        #expect(ResultCode.cantOpen.rawValue == SQLITE_CANTOPEN)
        #expect(ResultCode.`protocol`.rawValue == SQLITE_PROTOCOL)
        #expect(ResultCode.empty.rawValue == SQLITE_EMPTY)
        #expect(ResultCode.schema.rawValue == SQLITE_SCHEMA)
        #expect(ResultCode.tooBig.rawValue == SQLITE_TOOBIG)
        #expect(ResultCode.constraint.rawValue == SQLITE_CONSTRAINT)
        #expect(ResultCode.mismatch.rawValue == SQLITE_MISMATCH)
        #expect(ResultCode.misuse.rawValue == SQLITE_MISUSE)
        #expect(ResultCode.noLFS.rawValue == SQLITE_NOLFS)
        #expect(ResultCode.auth.rawValue == SQLITE_AUTH)
        #expect(ResultCode.format.rawValue == SQLITE_FORMAT)
        #expect(ResultCode.range.rawValue == SQLITE_RANGE)
        #expect(ResultCode.notADB.rawValue == SQLITE_NOTADB)
        #expect(ResultCode.notice.rawValue == SQLITE_NOTICE)
        #expect(ResultCode.warning.rawValue == SQLITE_WARNING)
        #expect(ResultCode.row.rawValue == SQLITE_ROW)
        #expect(ResultCode.done.rawValue == SQLITE_DONE)
    }

    @Test("extended result codes match SQLite")
    func extendedResultCodesMatchSQLite() {
        #expect(ResultCode.errorMissingCollSeq.rawValue == LSQLITE_ERROR_MISSING_COLLSEQ)
        #expect(ResultCode.errorRetry.rawValue == LSQLITE_ERROR_RETRY)
        #expect(ResultCode.errorSnapshot.rawValue == LSQLITE_ERROR_SNAPSHOT)
        #expect(ResultCode.ioErrorRead.rawValue == LSQLITE_IOERR_READ)
        #expect(ResultCode.ioErrorShortRead.rawValue == LSQLITE_IOERR_SHORT_READ)
        #expect(ResultCode.ioErrorWrite.rawValue == LSQLITE_IOERR_WRITE)
        #expect(ResultCode.ioErrorFSync.rawValue == LSQLITE_IOERR_FSYNC)
        #expect(ResultCode.ioErrorDirFSync.rawValue == LSQLITE_IOERR_DIR_FSYNC)
        #expect(ResultCode.ioErrorTruncate.rawValue == LSQLITE_IOERR_TRUNCATE)
        #expect(ResultCode.ioErrorFStat.rawValue == LSQLITE_IOERR_FSTAT)
        #expect(ResultCode.ioErrorUnlock.rawValue == LSQLITE_IOERR_UNLOCK)
        #expect(ResultCode.ioErrorRDLock.rawValue == LSQLITE_IOERR_RDLOCK)
        #expect(ResultCode.ioErrorDelete.rawValue == LSQLITE_IOERR_DELETE)
        #expect(ResultCode.ioErrorBlocked.rawValue == LSQLITE_IOERR_BLOCKED)
        #expect(ResultCode.ioErrorNoMem.rawValue == LSQLITE_IOERR_NOMEM)
        #expect(ResultCode.ioErrorAccess.rawValue == LSQLITE_IOERR_ACCESS)
        #expect(ResultCode.ioErrorCheckReservedLock.rawValue == LSQLITE_IOERR_CHECKRESERVEDLOCK)
        #expect(ResultCode.ioErrorLock.rawValue == LSQLITE_IOERR_LOCK)
        #expect(ResultCode.ioErrorClose.rawValue == LSQLITE_IOERR_CLOSE)
        #expect(ResultCode.ioErrorDirClose.rawValue == LSQLITE_IOERR_DIR_CLOSE)
        #expect(ResultCode.ioErrorShMOpen.rawValue == LSQLITE_IOERR_SHMOPEN)
        #expect(ResultCode.ioErrorShMSize.rawValue == LSQLITE_IOERR_SHMSIZE)
        #expect(ResultCode.ioErrorShMLock.rawValue == LSQLITE_IOERR_SHMLOCK)
        #expect(ResultCode.ioErrorShMMap.rawValue == LSQLITE_IOERR_SHMMAP)
        #expect(ResultCode.ioErrorSeek.rawValue == LSQLITE_IOERR_SEEK)
        #expect(ResultCode.ioErrorDeleteNoEnt.rawValue == LSQLITE_IOERR_DELETE_NOENT)
        #expect(ResultCode.ioErrorMMap.rawValue == LSQLITE_IOERR_MMAP)
        #expect(ResultCode.ioErrorGetTempPath.rawValue == LSQLITE_IOERR_GETTEMPPATH)
        #expect(ResultCode.ioErrorConvPath.rawValue == LSQLITE_IOERR_CONVPATH)
        #expect(ResultCode.ioErrorVNode.rawValue == LSQLITE_IOERR_VNODE)
        #expect(ResultCode.ioErrorAuth.rawValue == LSQLITE_IOERR_AUTH)
        #expect(ResultCode.ioErrorBeginAtomic.rawValue == LSQLITE_IOERR_BEGIN_ATOMIC)
        #expect(ResultCode.ioErrorCommitAtomic.rawValue == LSQLITE_IOERR_COMMIT_ATOMIC)
        #expect(ResultCode.ioErrorRollbackAtomic.rawValue == LSQLITE_IOERR_ROLLBACK_ATOMIC)
        #expect(ResultCode.lockedSharedCache.rawValue == LSQLITE_LOCKED_SHAREDCACHE)
        #expect(ResultCode.lockedVTab.rawValue == LSQLITE_LOCKED_VTAB)
        #expect(ResultCode.busyRecovery.rawValue == LSQLITE_BUSY_RECOVERY)
        #expect(ResultCode.busySnapshot.rawValue == LSQLITE_BUSY_SNAPSHOT)
        #expect(ResultCode.cantOpenNoTempDir.rawValue == LSQLITE_CANTOPEN_NOTEMPDIR)
        #expect(ResultCode.cantOpenIsDir.rawValue == LSQLITE_CANTOPEN_ISDIR)
        #expect(ResultCode.cantOpenFullPath.rawValue == LSQLITE_CANTOPEN_FULLPATH)
        #expect(ResultCode.cantOpenConvPath.rawValue == LSQLITE_CANTOPEN_CONVPATH)
        #expect(ResultCode.cantOpenDirtyWAL.rawValue == LSQLITE_CANTOPEN_DIRTYWAL)
        #expect(ResultCode.corruptVTab.rawValue == LSQLITE_CORRUPT_VTAB)
        #expect(ResultCode.corruptSequence.rawValue == LSQLITE_CORRUPT_SEQUENCE)
        #expect(ResultCode.readonlyRecovery.rawValue == LSQLITE_READONLY_RECOVERY)
        #expect(ResultCode.readonlyCantLock.rawValue == LSQLITE_READONLY_CANTLOCK)
        #expect(ResultCode.readonlyRollback.rawValue == LSQLITE_READONLY_ROLLBACK)
        #expect(ResultCode.readonlyDBMoved.rawValue == LSQLITE_READONLY_DBMOVED)
        #expect(ResultCode.readonlyCantInit.rawValue == LSQLITE_READONLY_CANTINIT)
        #expect(ResultCode.readonlyDirectory.rawValue == LSQLITE_READONLY_DIRECTORY)
        #expect(ResultCode.abortRollback.rawValue == LSQLITE_ABORT_ROLLBACK)
        #expect(ResultCode.constraintCheck.rawValue == LSQLITE_CONSTRAINT_CHECK)
        #expect(ResultCode.constraintCommitHook.rawValue == LSQLITE_CONSTRAINT_COMMITHOOK)
        #expect(ResultCode.constraintForeignKey.rawValue == LSQLITE_CONSTRAINT_FOREIGNKEY)
        #expect(ResultCode.constraintFunction.rawValue == LSQLITE_CONSTRAINT_FUNCTION)
        #expect(ResultCode.constraintNotNull.rawValue == LSQLITE_CONSTRAINT_NOTNULL)
        #expect(ResultCode.constraintPrimaryKey.rawValue == LSQLITE_CONSTRAINT_PRIMARYKEY)
        #expect(ResultCode.constraintTrigger.rawValue == LSQLITE_CONSTRAINT_TRIGGER)
        #expect(ResultCode.constraintUnique.rawValue == LSQLITE_CONSTRAINT_UNIQUE)
        #expect(ResultCode.constraintVTab.rawValue == LSQLITE_CONSTRAINT_VTAB)
        #expect(ResultCode.constraintRowID.rawValue == LSQLITE_CONSTRAINT_ROWID)
        #expect(ResultCode.noticeRecoverWAL.rawValue == LSQLITE_NOTICE_RECOVER_WAL)
        #expect(ResultCode.noticeRecoverRollback.rawValue == LSQLITE_NOTICE_RECOVER_ROLLBACK)
        #expect(ResultCode.warningAutoIndex.rawValue == LSQLITE_WARNING_AUTOINDEX)
        #expect(ResultCode.authUser.rawValue == LSQLITE_AUTH_USER)
        #expect(ResultCode.okLoadPermanently.rawValue == LSQLITE_OK_LOAD_PERMANENTLY)
    }

    @Test("description and debugDescription cover known result codes")
    func descriptionsCoverKnownResultCodes() {
        for code in allResultCodes {
            #expect(!code.description.isEmpty)
            #expect(!code.debugDescription.isEmpty)
        }
    }

    @Test("unknown result codes use fallback strings")
    func unknownResultCodesUseFallbackStrings() {
        let unknown = ResultCode(rawValue: -12345)
        #expect(unknown.description == "unknown")
        #expect(unknown.debugDescription == "-12345")
    }

    @Test("errorString returns a message when available")
    func errorStringProvidesMessage() {
        let message = ResultCode.ok.errorString
        #expect(message != nil)
        #expect(message != "")
    }
}

private let allResultCodes: [ResultCode] = [
    .ok,
    .error,
    .internal,
    .permission,
    .abort,
    .busy,
    .locked,
    .noMemory,
    .readonly,
    .interrupt,
    .ioError,
    .corrupt,
    .notFound,
    .full,
    .cantOpen,
    .protocol,
    .empty,
    .schema,
    .tooBig,
    .constraint,
    .mismatch,
    .misuse,
    .noLFS,
    .auth,
    .format,
    .range,
    .notADB,
    .notice,
    .warning,
    .row,
    .done,
    .errorMissingCollSeq,
    .errorRetry,
    .errorSnapshot,
    .ioErrorRead,
    .ioErrorShortRead,
    .ioErrorWrite,
    .ioErrorFSync,
    .ioErrorDirFSync,
    .ioErrorTruncate,
    .ioErrorFStat,
    .ioErrorUnlock,
    .ioErrorRDLock,
    .ioErrorDelete,
    .ioErrorBlocked,
    .ioErrorNoMem,
    .ioErrorAccess,
    .ioErrorCheckReservedLock,
    .ioErrorLock,
    .ioErrorClose,
    .ioErrorDirClose,
    .ioErrorShMOpen,
    .ioErrorShMSize,
    .ioErrorShMLock,
    .ioErrorShMMap,
    .ioErrorSeek,
    .ioErrorDeleteNoEnt,
    .ioErrorMMap,
    .ioErrorGetTempPath,
    .ioErrorConvPath,
    .ioErrorVNode,
    .ioErrorAuth,
    .ioErrorBeginAtomic,
    .ioErrorCommitAtomic,
    .ioErrorRollbackAtomic,
    .lockedSharedCache,
    .lockedVTab,
    .busyRecovery,
    .busySnapshot,
    .cantOpenNoTempDir,
    .cantOpenIsDir,
    .cantOpenFullPath,
    .cantOpenConvPath,
    .cantOpenDirtyWAL,
    .corruptVTab,
    .corruptSequence,
    .readonlyRecovery,
    .readonlyCantLock,
    .readonlyRollback,
    .readonlyDBMoved,
    .readonlyCantInit,
    .readonlyDirectory,
    .abortRollback,
    .constraintCheck,
    .constraintCommitHook,
    .constraintForeignKey,
    .constraintFunction,
    .constraintNotNull,
    .constraintPrimaryKey,
    .constraintTrigger,
    .constraintUnique,
    .constraintVTab,
    .constraintRowID,
    .noticeRecoverWAL,
    .noticeRecoverRollback,
    .warningAutoIndex,
    .authUser,
    .okLoadPermanently,
]
