import MissedSwiftSQLite

extension Context {
    /**
     CAPI3REF: User Data For Functions
     METHOD: sqlite3_context

     ^The sqlite3_user_data() interface returns a copy of
     the pointer that was the pUserData parameter (the 5th parameter)
     of the [sqlite3_create_function()]
     and [sqlite3_create_function16()] routines that originally
     registered the application defined function.

     This routine must be called from the same thread in which
     the application-defined function is running.
     */
    @inlinable public var userData: UnsafeMutableRawPointer? {
        sqlite3_user_data(rawValue)
    }
}
