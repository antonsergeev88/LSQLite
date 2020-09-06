import MissedSwiftSQLite

/**
 CAPI3REF: Name Of The Folder Holding Database Files

 ^(If this global variable is made to point to a string which is
 the name of a folder (a.k.a. directory), then all database files
 specified with a relative pathname and created or accessed by
 SQLite when using a built-in windows [sqlite3_vfs | VFS] will be assumed
 to be relative to that directory.)^ ^If this variable is a NULL
 pointer, then SQLite assumes that all database files specified
 with a relative pathname are relative to the current directory
 for the process.  Only the windows VFS makes use of this global
 variable; it is ignored by the unix VFS.

 Changing the value of this variable while a database connection is
 open can result in a corrupt database.
 
 It is not safe to read or modify this variable in more than one
 thread at a time.  It is not safe to read or modify this variable
 if a [database connection] is being used at the same time in a separate
 thread.
 It is intended that this variable be set once
 as part of process initialization and before any SQLite interface
 routines have been called and that this variable remain unchanged
 thereafter.

 ^The [data_store_directory pragma] may modify this variable and cause
 it to point to memory obtained from [sqlite3_malloc].  ^Furthermore,
 the [data_store_directory pragma] always assumes that any string
 that this variable points to is held in memory obtained from
 [sqlite3_malloc] and the pragma may attempt to free that memory
 using [sqlite3_free].
 Hence, if this variable is modified directly, either it should be
 made NULL or made to point to memory obtained from [sqlite3_malloc]
 or else the use of the [data_store_directory pragma] should be avoided.
 */
@inlinable public var dataDirectory: UnsafeMutablePointer<Int8>? {
    get {
        sqlite3_data_directory
    }
    set {
        sqlite3_data_directory = newValue
    }
}
