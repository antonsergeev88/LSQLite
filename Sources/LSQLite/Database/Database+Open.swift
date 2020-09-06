import MissedSwiftSQLite

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

    /**
     CAPI3REF: Flags For File Open Operations

     These bit values are intended for use in the
     3rd parameter to the [sqlite3_open_v2()] interface and
     in the 4th parameter to the [sqlite3_vfs.xOpen] method.
    */
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

    /**
     CAPI3REF: Opening A New Database Connection
     CONSTRUCTOR: sqlite3

     ^These routines open an SQLite database file as specified by the
     filename argument. ^The filename argument is interpreted as UTF-8 for
     sqlite3_open() and sqlite3_open_v2() and as UTF-16 in the native byte
     order for sqlite3_open16(). ^(A [database connection] handle is usually
     returned in *ppDb, even if an error occurs.  The only exception is that
     if SQLite is unable to allocate memory to hold the [sqlite3] object,
     a NULL will be written into *ppDb instead of a pointer to the [sqlite3]
     object.)^ ^(If the database is opened (and/or created) successfully, then
     [SQLITE_OK] is returned.  Otherwise an [error code] is returned.)^ ^The
     [sqlite3_errmsg()] or [sqlite3_errmsg16()] routines can be used to obtain
     an English language description of the error following a failure of any
     of the sqlite3_open() routines.

     ^The default encoding will be UTF-8 for databases created using
     sqlite3_open() or sqlite3_open_v2().  ^The default encoding for databases
     created using sqlite3_open16() will be UTF-16 in the native byte order.

     Whether or not an error occurs when it is opened, resources
     associated with the [database connection] handle should be released by
     passing it to [sqlite3_close()] when it is no longer required.

     The sqlite3_open_v2() interface works like sqlite3_open()
     except that it accepts two additional parameters for additional control
     over the new database connection.  ^(The flags parameter to
     sqlite3_open_v2() can take one of
     the following three values, optionally combined with the
     [SQLITE_OPEN_NOMUTEX], [SQLITE_OPEN_FULLMUTEX], [SQLITE_OPEN_SHAREDCACHE],
     [SQLITE_OPEN_PRIVATECACHE], and/or [SQLITE_OPEN_URI] flags:)^


     ^([SQLITE_OPEN_READONLY]
     The database is opened in read-only mode.  If the database does not
     already exist, an error is returned.)^

     ^([SQLITE_OPEN_READWRITE]
     The database is opened for reading and writing if possible, or reading
     only if the file is write protected by the operating system.  In either
     case the database must already exist, otherwise an error is returned.)^

     ^([SQLITE_OPEN_READWRITE] | [SQLITE_OPEN_CREATE]
     The database is opened for reading and writing, and is created if
     it does not already exist. This is the behavior that is always used for
     sqlite3_open() and sqlite3_open16().)^


     If the 3rd parameter to sqlite3_open_v2() is not one of the
     combinations shown above optionally combined with other
     [SQLITE_OPEN_READONLY | SQLITE_OPEN_* bits]
     then the behavior is undefined.

     ^If the [SQLITE_OPEN_NOMUTEX] flag is set, then the database connection
     opens in the multi-thread [threading mode] as long as the single-thread
     mode has not been set at compile-time or start-time.  ^If the
     [SQLITE_OPEN_FULLMUTEX] flag is set then the database connection opens
     in the serialized [threading mode] unless single-thread was
     previously selected at compile-time or start-time.
     ^The [SQLITE_OPEN_SHAREDCACHE] flag causes the database connection to be
     eligible to use [shared cache mode], regardless of whether or not shared
     cache is enabled using [sqlite3_enable_shared_cache()].  ^The
     [SQLITE_OPEN_PRIVATECACHE] flag causes the database connection to not
     participate in [shared cache mode] even if it is enabled.

     ^The fourth parameter to sqlite3_open_v2() is the name of the
     [sqlite3_vfs] object that defines the operating system interface that
     the new database connection should use.  ^If the fourth parameter is
     a NULL pointer then the default [sqlite3_vfs] object is used.

     ^If the filename is ":memory:", then a private, temporary in-memory database
     is created for the connection.  ^This in-memory database will vanish when
     the database connection is closed.  Future versions of SQLite might
     make use of additional special filenames that begin with the ":" character.
     It is recommended that when a database filename actually does begin with
     a ":" character you should prefix the filename with a pathname such as
     "./" to avoid ambiguity.

     ^If the filename is an empty string, then a private, temporary
     on-disk database will be created.  ^This private database will be
     automatically deleted as soon as the database connection is closed.

     [[URI filenames in sqlite3_open()]] URI Filenames

     ^If [URI filename] interpretation is enabled, and the filename argument
     begins with "file:", then the filename is interpreted as a URI. ^URI
     filename interpretation is enabled if the [SQLITE_OPEN_URI] flag is
     set in the third argument to sqlite3_open_v2(), or if it has
     been enabled globally using the [SQLITE_CONFIG_URI] option with the
     [sqlite3_config()] method or by the [SQLITE_USE_URI] compile-time option.
     URI filename interpretation is turned off
     by default, but future releases of SQLite might enable URI filename
     interpretation by default.  See "[URI filenames]" for additional
     information.

     URI filenames are parsed according to RFC 3986. ^If the URI contains an
     authority, then it must be either an empty string or the string
     "localhost". ^If the authority is not an empty string or "localhost", an
     error is returned to the caller. ^The fragment component of a URI, if
     present, is ignored.

     ^SQLite uses the path component of the URI as the name of the disk file
     which contains the database. ^If the path begins with a '/' character,
     then it is interpreted as an absolute path. ^If the path does not begin
     with a '/' (meaning that the authority section is omitted from the URI)
     then the path is interpreted as a relative path.
     ^(On windows, the first component of an absolute path
     is a drive specification (e.g. "C:").)^

     [[core URI query parameters]]
     The query component of a URI may contain parameters that are interpreted
     either by SQLite itself, or by a [VFS | custom VFS implementation].
     SQLite and its built-in [VFSes] interpret the
     following query parameters:


        vfs: ^The "vfs" parameter may be used to specify the name of
         a VFS object that provides the operating system interface that should
         be used to access the database file on disk. ^If this option is set to
         an empty string the default VFS object is used. ^Specifying an unknown
         VFS is an error. ^If sqlite3_open_v2() is used and the vfs option is
         present, then the VFS specified by the option takes precedence over
         the value passed as the fourth parameter to sqlite3_open_v2().

        mode: ^(The mode parameter may be set to either "ro", "rw",
         "rwc", or "memory". Attempting to set it to any other value is
         an error)^.
         ^If "ro" is specified, then the database is opened for read-only
         access, just as if the [SQLITE_OPEN_READONLY] flag had been set in the
         third argument to sqlite3_open_v2(). ^If the mode option is set to
         "rw", then the database is opened for read-write (but not create)
         access, as if SQLITE_OPEN_READWRITE (but not SQLITE_OPEN_CREATE) had
         been set. ^Value "rwc" is equivalent to setting both
         SQLITE_OPEN_READWRITE and SQLITE_OPEN_CREATE.  ^If the mode option is
         set to "memory" then a pure [in-memory database] that never reads
         or writes from disk is used. ^It is an error to specify a value for
         the mode parameter that is less restrictive than that specified by
         the flags passed in the third parameter to sqlite3_open_v2().

        cache: ^The cache parameter may be set to either "shared" or
         "private". ^Setting it to "shared" is equivalent to setting the
         SQLITE_OPEN_SHAREDCACHE bit in the flags argument passed to
         sqlite3_open_v2(). ^Setting the cache parameter to "private" is
         equivalent to setting the SQLITE_OPEN_PRIVATECACHE bit.
         ^If sqlite3_open_v2() is used and the "cache" parameter is present in
         a URI filename, its value overrides any behavior requested by setting
         SQLITE_OPEN_PRIVATECACHE or SQLITE_OPEN_SHAREDCACHE flag.

       psow: ^The psow parameter indicates whether or not the
         [powersafe overwrite] property does or does not apply to the
         storage media on which the database file resides.

       nolock: ^The nolock parameter is a boolean query parameter
         which if set disables file locking in rollback journal modes.  This
         is useful for accessing a database on a filesystem that does not
         support locking.  Caution:  Database corruption might result if two
         or more processes write to the same database and any one of those
         processes uses nolock=1.

       immutable: ^The immutable parameter is a boolean query
         parameter that indicates that the database file is stored on
         read-only media.  ^When immutable is set, SQLite assumes that the
         database file cannot be changed, even by a process with higher
         privilege, and so the database is opened read-only and all locking
         and change detection is disabled.  Caution: Setting the immutable
         property on a database file that does in fact change can result
         in incorrect query results and/or [SQLITE_CORRUPT] errors.
         See also: [SQLITE_IOCAP_IMMUTABLE].



     ^Specifying an unknown parameter in the query component of a URI is not an
     error.  Future versions of SQLite might understand additional query
     parameters.  See "[query parameters with special meaning to SQLite]" for
     additional information.

     [[URI filename examples]] URI filename examples


      URI filenames  Results
      file:data.db
              Open the file "data.db" in the current directory.
      file:/home/fred/data.db
              file:///home/fred/data.db
              file://localhost/home/fred/data.db
              Open the database file "/home/fred/data.db".
      file://darkstar/home/fred/data.db
              An error. "darkstar" is not a recognized authority.

              file:///C:/Documents%20and%20Settings/fred/Desktop/data.db
          Windows only: Open the file "data.db" on fred's desktop on drive
              C:. Note that the %20 escaping in this example is not strictly
              necessary - space characters can be used literally
              in URI filenames.
      file:data.db?mode=ro&cache=private
              Open file "data.db" in the current directory for read-only access.
              Regardless of whether or not shared-cache mode is enabled by
              default, use a private cache.
      file:/home/fred/data.db?vfs=unix-dotfile
              Open file "/home/fred/data.db". Use the special VFS "unix-dotfile"
              that uses dot-files in place of posix advisory locking.
      file:data.db?mode=readonly
              An error. "readonly" is not a valid option for the "mode" parameter.


     ^URI hexadecimal escape sequences (%HH) are supported within the path and
     query components of a URI. A hexadecimal escape sequence consists of a
     percent sign - "%" - followed by exactly two hexadecimal digits
     specifying an octet value. ^Before the path or query components of a
     URI filename are interpreted, they are encoded using UTF-8 and all
     hexadecimal escape sequences replaced by a single byte containing the
     corresponding octet. If this process generates an invalid UTF-8 encoding,
     the results are undefined.

     Note to Windows users:  The encoding used for the filename argument
     of sqlite3_open() and sqlite3_open_v2() must be UTF-8, not whatever
     codepage is currently defined.  Filenames containing international
     characters must be converted to UTF-8 prior to passing them into
     sqlite3_open() or sqlite3_open_v2().

     Note to Windows Runtime users:  The temporary directory must be set
     prior to calling sqlite3_open() or sqlite3_open_v2().  Otherwise, various
     features that require the use of temporary files may fail.

     See also: [sqlite3_temp_directory]
    */
    @inlinable public static func open(_ database: inout Database?, at filename: FileName, withOpenFlags openFlag: OpenFlag) -> ResultCode {
        var databasePointer: OpaquePointer? = nil
        let resultCode = sqlite3_open_v2(filename.rawValue, &databasePointer, openFlag.rawValue, nil).resultCode
        database = databasePointer.map(Database.init(rawValue:))
        return resultCode
    }
}
