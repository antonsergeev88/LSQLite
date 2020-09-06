import MissedSwiftSQLite

extension Context {
    /**
     CAPI3REF: Database Connection For Functions
     METHOD: sqlite3_context

     ^The sqlite3_context_db_handle() interface returns a copy of
     the pointer to the [database connection] (the 1st parameter)
     of the [sqlite3_create_function()]
     and [sqlite3_create_function16()] routines that originally
     registered the application defined function.
     */
    @inlinable public var database: Database? {
        return sqlite3_context_db_handle(rawValue).map(Database.init(rawValue:))
    }
}
