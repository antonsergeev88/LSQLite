import MissedSwiftSQLite

extension Database {
    public typealias ExecCallback = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ count: Int32, _ values: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>?, _ columns: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>?) -> Int32

    @frozen public struct ExecCallbackResult: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let `continue` = Self(rawValue: 0)
        public static let abort = Self(rawValue: 1)

        public var debugDescription: String {
            switch self {
            case .continue: return "LSQLITE_CONTINUE"
            case .abort: return "LSQLITE_ABORT"
            default: return "ExecCallbackResult(rawValue: \(rawValue))"
            }
        }
    }

    /**
     CAPI3REF: One-Step Query Execution Interface
     METHOD: sqlite3

     The sqlite3_exec() interface is a convenience wrapper around
     [sqlite3_prepare_v2()], [sqlite3_step()], and [sqlite3_finalize()],
     that allows an application to run multiple statements of SQL
     without having to use a lot of C code.

     ^The sqlite3_exec() interface runs zero or more UTF-8 encoded,
     semicolon-separate SQL statements passed into its 2nd argument,
     in the context of the [database connection] passed in as its 1st
     argument.  ^If the callback function of the 3rd argument to
     sqlite3_exec() is not NULL, then it is invoked for each result row
     coming out of the evaluated SQL statements.  ^The 4th argument to
     sqlite3_exec() is relayed through to the 1st argument of each
     callback invocation.  ^If the callback pointer to sqlite3_exec()
     is NULL, then no callback is ever invoked and result rows are
     ignored.

     ^If an error occurs while evaluating the SQL statements passed into
     sqlite3_exec(), then execution of the current statement stops and
     subsequent statements are skipped.  ^If the 5th parameter to sqlite3_exec()
     is not NULL then any error message is written into memory obtained
     from [sqlite3_malloc()] and passed back through the 5th parameter.
     To avoid memory leaks, the application should invoke [sqlite3_free()]
     on error message strings returned through the 5th parameter of
     sqlite3_exec() after the error message string is no longer needed.
     ^If the 5th parameter to sqlite3_exec() is not NULL and no errors
     occur, then sqlite3_exec() sets the pointer in its 5th parameter to
     NULL before returning.

     ^If an sqlite3_exec() callback returns non-zero, the sqlite3_exec()
     routine returns SQLITE_ABORT without invoking the callback again and
     without running any subsequent SQL statements.

     ^The 2nd argument to the sqlite3_exec() callback function is the
     number of columns in the result.  ^The 3rd argument to the sqlite3_exec()
     callback is an array of pointers to strings obtained as if from
     [sqlite3_column_text()], one for each column.  ^If an element of a
     result row is NULL then the corresponding string pointer for the
     sqlite3_exec() callback is a NULL pointer.  ^The 4th argument to the
     sqlite3_exec() callback is an array of pointers to strings where each
     entry represents the name of corresponding result column as obtained
     from [sqlite3_column_name()].

     ^If the 2nd parameter to sqlite3_exec() is a NULL pointer, a pointer
     to an empty string, or a pointer that contains only whitespace and/or
     SQL comments, then no SQL statements are evaluated and the database
     is not changed.

     Restrictions:

     
      The application must ensure that the 1st parameter to sqlite3_exec()
     is a valid and open [database connection].
      The application must not close the [database connection] specified by
     the 1st parameter to sqlite3_exec() while sqlite3_exec() is running.
      The application must not modify the SQL statement text passed into
     the 2nd parameter of sqlite3_exec() while sqlite3_exec() is running.
     
     */
    @inlinable public func exec(_ sql: UnsafePointer<Int8>, errorMessage: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>? = nil, userData: UnsafeMutableRawPointer? = nil, callback: ExecCallback? = nil) -> ResultCode {
        sqlite3_exec(rawValue, sql, callback, userData, errorMessage).resultCode
    }
}
