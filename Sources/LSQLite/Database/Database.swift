/**
 CAPI3REF: Database Connection Handle
 KEYWORDS: {database connection} {database connections}

 Each open SQLite database is represented by a pointer to an instance of
 the opaque structure named "sqlite3".  It is useful to think of an sqlite3
 pointer as an object.  The [sqlite3_open()], [sqlite3_open16()], and
 [sqlite3_open_v2()] interfaces are its constructors, and [sqlite3_close()]
 and [sqlite3_close_v2()] are its destructors.  There are many other
 interfaces (such as
 [sqlite3_prepare_v2()], [sqlite3_create_function()], and
 [sqlite3_busy_timeout()] to name but three) that are methods on an
 sqlite3 object.
 */
@frozen public struct Database: RawRepresentable {
    public let rawValue: OpaquePointer

    @inlinable public init(rawValue: OpaquePointer) {
        self.rawValue = rawValue
    }
}
