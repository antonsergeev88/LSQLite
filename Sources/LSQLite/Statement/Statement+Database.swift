import MissedSwiftSQLite

extension Statement {
    /**
     CAPI3REF: Find The Database Handle Of A Prepared Statement
     METHOD: sqlite3_stmt

     ^The sqlite3_db_handle interface returns the [database connection] handle
     to which a [prepared statement] belongs.  ^The [database connection]
     returned by sqlite3_db_handle is the same [database connection]
     that was the first argument
     to the [sqlite3_prepare_v2()] call (or its variants) that was used to
     create the statement in the first place.
    */
    @inlinable public var database: Database? {
        return sqlite3_db_handle(rawValue).map(Database.init(rawValue:))
    }
}
