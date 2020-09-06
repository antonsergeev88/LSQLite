import MissedSwiftSQLite

extension Database {
    @frozen public struct ExtendedResultCodeStatus: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let off = Self(rawValue: 0)
        public static let on = Self(rawValue: 1)

        public var debugDescription: String {
            switch self {
            case .off: return "LSQLITE_OFF"
            case .on: return "LSQLITE_ON"
            default: return "ExtendedResultCodeStatus(rawValue: \(rawValue))"
            }
        }
    }

    /**
     CAPI3REF: Error Codes And Messages
     METHOD: sqlite3

     ^If the most recent sqlite3_* API call associated with
     [database connection] D failed, then the sqlite3_errcode(D) interface
     returns the numeric [result code] or [extended result code] for that
     API call.
     ^The sqlite3_extended_errcode()
     interface is the same except that it always returns the
     [extended result code] even when extended result codes are
     disabled.

     The values returned by sqlite3_errcode() and/or
     sqlite3_extended_errcode() might change with each API call.
     Except, there are some interfaces that are guaranteed to never
     change the value of the error code.  The error-code preserving
     interfaces are:

     
      sqlite3_errcode()
      sqlite3_extended_errcode()
      sqlite3_errmsg()
      sqlite3_errmsg16()
     

     ^The sqlite3_errmsg() and sqlite3_errmsg16() return English-language
     text that describes the error, as either UTF-8 or UTF-16 respectively.
     ^(Memory to hold the error message string is managed internally.
     The application does not need to worry about freeing the result.
     However, the error string might be overwritten or deallocated by
     subsequent calls to other SQLite interface functions.)^

     ^The sqlite3_errstr() interface returns the English-language text
     that describes the [result code], as UTF-8.
     ^(Memory to hold the error message string is managed internally
     and must not be freed by the application)^.

     When the serialized [threading mode] is in use, it might be the
     case that a second error occurs on a separate thread in between
     the time of the first error and the call to these interfaces.
     When that happens, the second error will be reported since these
     interfaces always report the most recent result.  To avoid
     this, each thread can obtain exclusive use of the [database connection] D
     by invoking [sqlite3_mutex_enter]([sqlite3_db_mutex](D)) before beginning
     to use D and invoking [sqlite3_mutex_leave]([sqlite3_db_mutex](D)) after
     all calls to the interfaces listed here are completed.

     If an interface fails with SQLITE_MISUSE, that means the interface
     was invoked incorrectly by the application.  In that case, the
     error code and message may or may not be set.
     */
    @inlinable public var lastErrorCode: ResultCode {
        sqlite3_errcode(rawValue).resultCode
    }

    /**
     CAPI3REF: Error Codes And Messages
     METHOD: sqlite3

     ^If the most recent sqlite3_* API call associated with
     [database connection] D failed, then the sqlite3_errcode(D) interface
     returns the numeric [result code] or [extended result code] for that
     API call.
     ^The sqlite3_extended_errcode()
     interface is the same except that it always returns the
     [extended result code] even when extended result codes are
     disabled.

     The values returned by sqlite3_errcode() and/or
     sqlite3_extended_errcode() might change with each API call.
     Except, there are some interfaces that are guaranteed to never
     change the value of the error code.  The error-code preserving
     interfaces are:

     
      sqlite3_errcode()
      sqlite3_extended_errcode()
      sqlite3_errmsg()
      sqlite3_errmsg16()
     

     ^The sqlite3_errmsg() and sqlite3_errmsg16() return English-language
     text that describes the error, as either UTF-8 or UTF-16 respectively.
     ^(Memory to hold the error message string is managed internally.
     The application does not need to worry about freeing the result.
     However, the error string might be overwritten or deallocated by
     subsequent calls to other SQLite interface functions.)^

     ^The sqlite3_errstr() interface returns the English-language text
     that describes the [result code], as UTF-8.
     ^(Memory to hold the error message string is managed internally
     and must not be freed by the application)^.

     When the serialized [threading mode] is in use, it might be the
     case that a second error occurs on a separate thread in between
     the time of the first error and the call to these interfaces.
     When that happens, the second error will be reported since these
     interfaces always report the most recent result.  To avoid
     this, each thread can obtain exclusive use of the [database connection] D
     by invoking [sqlite3_mutex_enter]([sqlite3_db_mutex](D)) before beginning
     to use D and invoking [sqlite3_mutex_leave]([sqlite3_db_mutex](D)) after
     all calls to the interfaces listed here are completed.

     If an interface fails with SQLITE_MISUSE, that means the interface
     was invoked incorrectly by the application.  In that case, the
     error code and message may or may not be set.
     */
    @inlinable public var lastExtendedErrorCode: ResultCode {
        sqlite3_extended_errcode(rawValue).resultCode
    }

    /**
     CAPI3REF: Error Codes And Messages
     METHOD: sqlite3

     ^If the most recent sqlite3_* API call associated with
     [database connection] D failed, then the sqlite3_errcode(D) interface
     returns the numeric [result code] or [extended result code] for that
     API call.
     ^The sqlite3_extended_errcode()
     interface is the same except that it always returns the
     [extended result code] even when extended result codes are
     disabled.

     The values returned by sqlite3_errcode() and/or
     sqlite3_extended_errcode() might change with each API call.
     Except, there are some interfaces that are guaranteed to never
     change the value of the error code.  The error-code preserving
     interfaces are:

     
      sqlite3_errcode()
      sqlite3_extended_errcode()
      sqlite3_errmsg()
      sqlite3_errmsg16()
     

     ^The sqlite3_errmsg() and sqlite3_errmsg16() return English-language
     text that describes the error, as either UTF-8 or UTF-16 respectively.
     ^(Memory to hold the error message string is managed internally.
     The application does not need to worry about freeing the result.
     However, the error string might be overwritten or deallocated by
     subsequent calls to other SQLite interface functions.)^

     ^The sqlite3_errstr() interface returns the English-language text
     that describes the [result code], as UTF-8.
     ^(Memory to hold the error message string is managed internally
     and must not be freed by the application)^.

     When the serialized [threading mode] is in use, it might be the
     case that a second error occurs on a separate thread in between
     the time of the first error and the call to these interfaces.
     When that happens, the second error will be reported since these
     interfaces always report the most recent result.  To avoid
     this, each thread can obtain exclusive use of the [database connection] D
     by invoking [sqlite3_mutex_enter]([sqlite3_db_mutex](D)) before beginning
     to use D and invoking [sqlite3_mutex_leave]([sqlite3_db_mutex](D)) after
     all calls to the interfaces listed here are completed.

     If an interface fails with SQLITE_MISUSE, that means the interface
     was invoked incorrectly by the application.  In that case, the
     error code and message may or may not be set.
     */
    @inlinable public var lastErrorMessage: UnsafePointer<Int8> {
        sqlite3_errmsg(rawValue)
    }

    /**
     CAPI3REF: Error Codes And Messages
     METHOD: sqlite3

     ^If the most recent sqlite3_* API call associated with
     [database connection] D failed, then the sqlite3_errcode(D) interface
     returns the numeric [result code] or [extended result code] for that
     API call.
     ^The sqlite3_extended_errcode()
     interface is the same except that it always returns the
     [extended result code] even when extended result codes are
     disabled.

     The values returned by sqlite3_errcode() and/or
     sqlite3_extended_errcode() might change with each API call.
     Except, there are some interfaces that are guaranteed to never
     change the value of the error code.  The error-code preserving
     interfaces are:

     
      sqlite3_errcode()
      sqlite3_extended_errcode()
      sqlite3_errmsg()
      sqlite3_errmsg16()
     

     ^The sqlite3_errmsg() and sqlite3_errmsg16() return English-language
     text that describes the error, as either UTF-8 or UTF-16 respectively.
     ^(Memory to hold the error message string is managed internally.
     The application does not need to worry about freeing the result.
     However, the error string might be overwritten or deallocated by
     subsequent calls to other SQLite interface functions.)^

     ^The sqlite3_errstr() interface returns the English-language text
     that describes the [result code], as UTF-8.
     ^(Memory to hold the error message string is managed internally
     and must not be freed by the application)^.

     When the serialized [threading mode] is in use, it might be the
     case that a second error occurs on a separate thread in between
     the time of the first error and the call to these interfaces.
     When that happens, the second error will be reported since these
     interfaces always report the most recent result.  To avoid
     this, each thread can obtain exclusive use of the [database connection] D
     by invoking [sqlite3_mutex_enter]([sqlite3_db_mutex](D)) before beginning
     to use D and invoking [sqlite3_mutex_leave]([sqlite3_db_mutex](D)) after
     all calls to the interfaces listed here are completed.

     If an interface fails with SQLITE_MISUSE, that means the interface
     was invoked incorrectly by the application.  In that case, the
     error code and message may or may not be set.
     */
    @inlinable public func setExtendedResultCodes(_ status: ExtendedResultCodeStatus) -> ResultCode {
        sqlite3_extended_result_codes(rawValue, status.rawValue).resultCode
    }
}
