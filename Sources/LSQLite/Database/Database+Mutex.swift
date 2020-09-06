import MissedSwiftSQLite

extension Database {
    /**
     CAPI3REF: Retrieve the mutex for a database connection
     METHOD: sqlite3

     ^This interface returns a pointer the [sqlite3_mutex] object that
     serializes access to the [database connection] given in the argument
     when the [threading mode] is Serialized.
     ^If the [threading mode] is Single-thread or Multi-thread then this
     routine returns a NULL pointer.
     */
    @inlinable public var mutex: Mutex? {
        return sqlite3_db_mutex(rawValue).map(Mutex.init(rawValue:))
    }
}
