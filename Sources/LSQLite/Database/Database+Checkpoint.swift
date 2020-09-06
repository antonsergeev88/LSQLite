import MissedSwiftSQLite

extension Database {
    @frozen public struct CheckpointMode: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let passive = Self(rawValue: SQLITE_CHECKPOINT_PASSIVE)
        public static let full = Self(rawValue: SQLITE_CHECKPOINT_FULL)
        public static let restart = Self(rawValue: SQLITE_CHECKPOINT_RESTART)
        public static let truncate = Self(rawValue: SQLITE_CHECKPOINT_TRUNCATE)

        public var debugDescription: String {
            switch self {
            case .passive: return "SQLITE_CHECKPOINT_PASSIVE"
            case .full: return "SQLITE_CHECKPOINT_FULL"
            case .restart: return "SQLITE_CHECKPOINT_RESTART"
            case .truncate: return "SQLITE_CHECKPOINT_TRUNCATE"
            default: return "CheckpointMode(rawValue: \(rawValue))"
            }
        }
    }

    /**
     CAPI3REF: Configure an auto-checkpoint
     METHOD: sqlite3

     ^The [sqlite3_wal_autocheckpoint(D,N)] is a wrapper around
     [sqlite3_wal_hook()] that causes any database on [database connection] D
     to automatically [checkpoint]
     after committing a transaction if there are N or
     more frames in the [write-ahead log] file.  ^Passing zero or
     a negative value as the nFrame parameter disables automatic
     checkpoints entirely.

     ^The callback registered by this function replaces any existing callback
     registered using [sqlite3_wal_hook()].  ^Likewise, registering a callback
     using [sqlite3_wal_hook()] disables the automatic checkpoint mechanism
     configured by this function.

     ^The [wal_autocheckpoint pragma] can be used to invoke this interface
     from SQL.

     ^Checkpoints initiated by this mechanism are
     [sqlite3_wal_checkpoint_v2|PASSIVE].

     ^Every new [database connection] defaults to having the auto-checkpoint
     enabled with a threshold of 1000 or [SQLITE_DEFAULT_WAL_AUTOCHECKPOINT]
     pages.  The use of this interface
     is only necessary if the default setting is found to be suboptimal
     for a particular application.
    */
    @inlinable public func autoWALCheckpoint(pageInWALFileCount: Int32) -> ResultCode {
        sqlite3_wal_autocheckpoint(rawValue, pageInWALFileCount).resultCode
    }

    /**
     CAPI3REF: Checkpoint a database
     METHOD: sqlite3

     ^(The sqlite3_wal_checkpoint_v2(D,X,M,L,C) interface runs a checkpoint
     operation on database X of [database connection] D in mode M.  Status
     information is written back into integers pointed to by L and C.)^
     ^(The M parameter must be a valid [checkpoint mode]:)^

     
     <dt>SQLITE_CHECKPOINT_PASSIVE<dd>
       ^Checkpoint as many frames as possible without waiting for any database
       readers or writers to finish, then sync the database file if all frames
       in the log were checkpointed. ^The [busy-handler callback]
       is never invoked in the SQLITE_CHECKPOINT_PASSIVE mode.
       ^On the other hand, passive mode might leave the checkpoint unfinished
       if there are concurrent readers or writers.

     <dt>SQLITE_CHECKPOINT_FULL<dd>
       ^This mode blocks (it invokes the
       [sqlite3_busy_handler|busy-handler callback]) until there is no
       database writer and all readers are reading from the most recent database
       snapshot. ^It then checkpoints all frames in the log file and syncs the
       database file. ^This mode blocks new database writers while it is pending,
       but new database readers are allowed to continue unimpeded.

     <dt>SQLITE_CHECKPOINT_RESTART<dd>
       ^This mode works the same way as SQLITE_CHECKPOINT_FULL with the addition
       that after checkpointing the log file it blocks (calls the
       [busy-handler callback])
       until all readers are reading from the database file only. ^This ensures
       that the next writer will restart the log file from the beginning.
       ^Like SQLITE_CHECKPOINT_FULL, this mode blocks new
       database writer attempts while it is pending, but does not impede readers.

     <dt>SQLITE_CHECKPOINT_TRUNCATE<dd>
       ^This mode works the same way as SQLITE_CHECKPOINT_RESTART with the
       addition that it also truncates the log file to zero bytes just prior
       to a successful return.
     

     ^If pnLog is not NULL, then *pnLog is set to the total number of frames in
     the log file or to -1 if the checkpoint could not run because
     of an error or because the database is not in [WAL mode]. ^If pnCkpt is not
     NULL,then *pnCkpt is set to the total number of checkpointed frames in the
     log file (including any that were already checkpointed before the function
     was called) or to -1 if the checkpoint could not run due to an error or
     because the database is not in WAL mode. ^Note that upon successful
     completion of an SQLITE_CHECKPOINT_TRUNCATE, the log file will have been
     truncated to zero bytes and so both *pnLog and *pnCkpt will be set to zero.

     ^All calls obtain an exclusive "checkpoint" lock on the database file. ^If
     any other process is running a checkpoint operation at the same time, the
     lock cannot be obtained and SQLITE_BUSY is returned. ^Even if there is a
     busy-handler configured, it will not be invoked in this case.

     ^The SQLITE_CHECKPOINT_FULL, RESTART and TRUNCATE modes also obtain the
     exclusive "writer" lock on the database file. ^If the writer lock cannot be
     obtained immediately, and a busy-handler is configured, it is invoked and
     the writer lock retried until either the busy-handler returns 0 or the lock
     is successfully obtained. ^The busy-handler is also invoked while waiting for
     database readers as described above. ^If the busy-handler returns 0 before
     the writer lock is obtained or while waiting for database readers, the
     checkpoint operation proceeds from that point in the same way as
     SQLITE_CHECKPOINT_PASSIVE - checkpointing as many frames as possible
     without blocking any further. ^SQLITE_BUSY is returned in this case.

     ^If parameter zDb is NULL or points to a zero length string, then the
     specified operation is attempted on all WAL databases [attached] to
     [database connection] db.  In this case the
     values written to output parameters *pnLog and *pnCkpt are undefined. ^If
     an SQLITE_BUSY error is encountered when processing one or more of the
     attached WAL databases, the operation is still attempted on any remaining
     attached databases and SQLITE_BUSY is returned at the end. ^If any other
     error occurs while processing an attached database, processing is abandoned
     and the error code is returned to the caller immediately. ^If no error
     (SQLITE_BUSY or otherwise) is encountered while processing the attached
     databases, SQLITE_OK is returned.

     ^If database zDb is the name of an attached database that is not in WAL
     mode, SQLITE_OK is returned and both *pnLog and *pnCkpt set to -1. ^If
     zDb is not NULL (or a zero length string) and is not the name of any
     attached database, SQLITE_ERROR is returned to the caller.

     ^Unless it returns SQLITE_MISUSE,
     the sqlite3_wal_checkpoint_v2() interface
     sets the error information that is queried by
     [sqlite3_errcode()] and [sqlite3_errmsg()].

     ^The [PRAGMA wal_checkpoint] command can be used to invoke this interface
     from SQL.
    */
    @inlinable public func walCheckpoint(_ databaseName: UnsafePointer<Int8>, mode: CheckpointMode, frameCount: UnsafeMutablePointer<Int32>?, totalFrameCount: UnsafeMutablePointer<Int32>?) -> ResultCode {
        sqlite3_wal_checkpoint_v2(rawValue, databaseName, mode.rawValue, frameCount, totalFrameCount).resultCode
    }
}
