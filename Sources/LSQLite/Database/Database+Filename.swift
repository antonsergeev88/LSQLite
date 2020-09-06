import MissedSwiftSQLite

extension Database {
    /**
     CAPI3REF: Return The Filename For A Database Connection
     METHOD: sqlite3

     ^The sqlite3_db_filename(D,N) interface returns a pointer to a filename
     associated with database N of connection D.  ^The main database file
     has the name "main".  If there is no attached database N on the database
     connection D, or if database N is a temporary or in-memory database, then
     this function will return either a NULL pointer or an empty string.

     ^The filename returned by this function is the output of the
     xFullPathname method of the [VFS].  ^In other words, the filename
     will be an absolute pathname, even if the filename used
     to open the database originally was a URI or relative pathname.
    */
    @inlinable public func filename(forDatabaseNamed name: UnsafePointer<Int8>) -> UnsafePointer<Int8>? {
        sqlite3_db_filename(rawValue, name)
    }
}
