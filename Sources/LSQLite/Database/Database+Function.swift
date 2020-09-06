import MissedSwiftSQLite

extension Database {
    public typealias FunctionFuncHandler = @convention(c) (_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) -> Void
    public typealias FunctionStepHandler = @convention(c) (_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) -> Void
    public typealias FunctionFinalHandler = @convention(c) (_ context: OpaquePointer?) -> Void
    public typealias FunctionValueHandler = @convention(c) (_ context: OpaquePointer?) -> Void
    public typealias FunctionInverseHandler = @convention(c) (_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) -> Void
    public typealias FunctionDestroyHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?) -> Void

    @frozen public struct FunctionFlag: Equatable, OptionSet, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let utf8 = Self(rawValue: SQLITE_UTF8)
        public static let utf16le = Self(rawValue: SQLITE_UTF16LE)
        public static let utf16be = Self(rawValue: SQLITE_UTF16BE)
        public static let utf16 = Self(rawValue: SQLITE_UTF16)
        public static let any = Self(rawValue: SQLITE_ANY)
        public static let utf16Aligned = Self(rawValue: SQLITE_UTF16_ALIGNED)

        public static let deterministic = Self(rawValue: SQLITE_DETERMINISTIC)

        public var debugDescription: String {
            switch self {
            case .utf8: return "SQLITE_UTF8"
            case .utf16le: return "SQLITE_UTF16LE"
            case .utf16be: return "SQLITE_UTF16BE"
            case .utf16: return "SQLITE_UTF16"
            case .any: return "SQLITE_ANY"
            case .utf16Aligned: return "SQLITE_UTF16_ALIGNED"
            default: return "FunctionFlag(rawValue: \(rawValue))"
            }
        }
    }

    /**
     CAPI3REF: Create Or Redefine SQL Functions
     KEYWORDS: {function creation routines}
     KEYWORDS: {application-defined SQL function}
     KEYWORDS: {application-defined SQL functions}
     METHOD: sqlite3

     ^These functions (collectively known as "function creation routines")
     are used to add SQL functions or aggregates or to redefine the behavior
     of existing SQL functions or aggregates. The only differences between
     the three "sqlite3_create_function*" routines are the text encoding
     expected for the second parameter (the name of the function being
     created) and the presence or absence of a destructor callback for
     the application data pointer. Function sqlite3_create_window_function()
     is similar, but allows the user to supply the extra callback functions
     needed by [aggregate window functions].

     ^The first parameter is the [database connection] to which the SQL
     function is to be added.  ^If an application uses more than one database
     connection then application-defined SQL functions must be added
     to each database connection separately.

     ^The second parameter is the name of the SQL function to be created or
     redefined.  ^The length of the name is limited to 255 bytes in a UTF-8
     representation, exclusive of the zero-terminator.  ^Note that the name
     length limit is in UTF-8 bytes, not characters nor UTF-16 bytes.
     ^Any attempt to create a function with a longer name
     will result in [SQLITE_MISUSE] being returned.

     ^The third parameter (nArg)
     is the number of arguments that the SQL function or
     aggregate takes. ^If this parameter is -1, then the SQL function or
     aggregate may take any number of arguments between 0 and the limit
     set by [sqlite3_limit]([SQLITE_LIMIT_FUNCTION_ARG]).  If the third
     parameter is less than -1 or greater than 127 then the behavior is
     undefined.

     ^The fourth parameter, eTextRep, specifies what
     [SQLITE_UTF8 | text encoding] this SQL function prefers for
     its parameters.  The application should set this parameter to
     [SQLITE_UTF16LE] if the function implementation invokes
     [sqlite3_value_text16le()] on an input, or [SQLITE_UTF16BE] if the
     implementation invokes [sqlite3_value_text16be()] on an input, or
     [SQLITE_UTF16] if [sqlite3_value_text16()] is used, or [SQLITE_UTF8]
     otherwise.  ^The same SQL function may be registered multiple times using
     different preferred text encodings, with different implementations for
     each encoding.
     ^When multiple implementations of the same function are available, SQLite
     will pick the one that involves the least amount of data conversion.

     ^The fourth parameter may optionally be ORed with [SQLITE_DETERMINISTIC]
     to signal that the function will always return the same result given
     the same inputs within a single SQL statement.  Most SQL functions are
     deterministic.  The built-in [random()] SQL function is an example of a
     function that is not deterministic.  The SQLite query planner is able to
     perform additional optimizations on deterministic functions, so use
     of the [SQLITE_DETERMINISTIC] flag is recommended where possible.

     ^(The fifth parameter is an arbitrary pointer.  The implementation of the
     function can gain access to this pointer using [sqlite3_user_data()].)^

     ^The sixth, seventh and eighth parameters passed to the three
     "sqlite3_create_function*" functions, xFunc, xStep and xFinal, are
     pointers to C-language functions that implement the SQL function or
     aggregate. ^A scalar SQL function requires an implementation of the xFunc
     callback only; NULL pointers must be passed as the xStep and xFinal
     parameters. ^An aggregate SQL function requires an implementation of xStep
     and xFinal and NULL pointer must be passed for xFunc. ^To delete an existing
     SQL function or aggregate, pass NULL pointers for all three function
     callbacks.

     ^The sixth, seventh, eighth and ninth parameters (xStep, xFinal, xValue
     and xInverse) passed to sqlite3_create_window_function are pointers to
     C-language callbacks that implement the new function. xStep and xFinal
     must both be non-NULL. xValue and xInverse may either both be NULL, in
     which case a regular aggregate function is created, or must both be
     non-NULL, in which case the new function may be used as either an aggregate
     or aggregate window function. More details regarding the implementation
     of aggregate window functions are
     [user-defined window functions|available here].

     ^(If the final parameter to sqlite3_create_function_v2() or
     sqlite3_create_window_function() is not NULL, then it is destructor for
     the application data pointer. The destructor is invoked when the function
     is deleted, either by being overloaded or when the database connection
     closes.)^ ^The destructor is also invoked if the call to
     sqlite3_create_function_v2() fails.  ^When the destructor callback is
     invoked, it is passed a single argument which is a copy of the application
     data pointer which was the fifth parameter to sqlite3_create_function_v2().

     ^It is permitted to register multiple implementations of the same
     functions with the same name but with either differing numbers of
     arguments or differing preferred text encodings.  ^SQLite will use
     the implementation that most closely matches the way in which the
     SQL function is used.  ^A function implementation with a non-negative
     nArg parameter is a better match than a function implementation with
     a negative nArg.  ^A function where the preferred text encoding
     matches the database encoding is a better
     match than a function where the encoding is different.
     ^A function where the encoding difference is between UTF16le and UTF16be
     is a closer match than a function where the encoding difference is
     between UTF8 and UTF16.

     ^Built-in functions may be overloaded by new application-defined functions.

     ^An application-defined function is permitted to call other
     SQLite interfaces.  However, such calls must not
     close the database connection nor finalize or reset the prepared
     statement in which the function is running.
     */
    @inlinable public func createFunction(name: UnsafePointer<Int8>, argumentCount: Int32, flags flag: FunctionFlag, userData: UnsafeMutableRawPointer? = nil, funcHandler: FunctionFuncHandler? = nil, stepHandler: FunctionStepHandler? = nil, finalHandler: FunctionFinalHandler? = nil, destroyHandler: FunctionDestroyHandler? = nil) -> ResultCode {
        sqlite3_create_function_v2(rawValue, name, argumentCount, flag.rawValue, userData, funcHandler, stepHandler, finalHandler, destroyHandler).resultCode
    }

    /**
     CAPI3REF: Create Or Redefine SQL Functions
     KEYWORDS: {function creation routines}
     KEYWORDS: {application-defined SQL function}
     KEYWORDS: {application-defined SQL functions}
     METHOD: sqlite3

     ^These functions (collectively known as "function creation routines")
     are used to add SQL functions or aggregates or to redefine the behavior
     of existing SQL functions or aggregates. The only differences between
     the three "sqlite3_create_function*" routines are the text encoding
     expected for the second parameter (the name of the function being
     created) and the presence or absence of a destructor callback for
     the application data pointer. Function sqlite3_create_window_function()
     is similar, but allows the user to supply the extra callback functions
     needed by [aggregate window functions].

     ^The first parameter is the [database connection] to which the SQL
     function is to be added.  ^If an application uses more than one database
     connection then application-defined SQL functions must be added
     to each database connection separately.

     ^The second parameter is the name of the SQL function to be created or
     redefined.  ^The length of the name is limited to 255 bytes in a UTF-8
     representation, exclusive of the zero-terminator.  ^Note that the name
     length limit is in UTF-8 bytes, not characters nor UTF-16 bytes.
     ^Any attempt to create a function with a longer name
     will result in [SQLITE_MISUSE] being returned.

     ^The third parameter (nArg)
     is the number of arguments that the SQL function or
     aggregate takes. ^If this parameter is -1, then the SQL function or
     aggregate may take any number of arguments between 0 and the limit
     set by [sqlite3_limit]([SQLITE_LIMIT_FUNCTION_ARG]).  If the third
     parameter is less than -1 or greater than 127 then the behavior is
     undefined.

     ^The fourth parameter, eTextRep, specifies what
     [SQLITE_UTF8 | text encoding] this SQL function prefers for
     its parameters.  The application should set this parameter to
     [SQLITE_UTF16LE] if the function implementation invokes
     [sqlite3_value_text16le()] on an input, or [SQLITE_UTF16BE] if the
     implementation invokes [sqlite3_value_text16be()] on an input, or
     [SQLITE_UTF16] if [sqlite3_value_text16()] is used, or [SQLITE_UTF8]
     otherwise.  ^The same SQL function may be registered multiple times using
     different preferred text encodings, with different implementations for
     each encoding.
     ^When multiple implementations of the same function are available, SQLite
     will pick the one that involves the least amount of data conversion.

     ^The fourth parameter may optionally be ORed with [SQLITE_DETERMINISTIC]
     to signal that the function will always return the same result given
     the same inputs within a single SQL statement.  Most SQL functions are
     deterministic.  The built-in [random()] SQL function is an example of a
     function that is not deterministic.  The SQLite query planner is able to
     perform additional optimizations on deterministic functions, so use
     of the [SQLITE_DETERMINISTIC] flag is recommended where possible.

     ^(The fifth parameter is an arbitrary pointer.  The implementation of the
     function can gain access to this pointer using [sqlite3_user_data()].)^

     ^The sixth, seventh and eighth parameters passed to the three
     "sqlite3_create_function*" functions, xFunc, xStep and xFinal, are
     pointers to C-language functions that implement the SQL function or
     aggregate. ^A scalar SQL function requires an implementation of the xFunc
     callback only; NULL pointers must be passed as the xStep and xFinal
     parameters. ^An aggregate SQL function requires an implementation of xStep
     and xFinal and NULL pointer must be passed for xFunc. ^To delete an existing
     SQL function or aggregate, pass NULL pointers for all three function
     callbacks.

     ^The sixth, seventh, eighth and ninth parameters (xStep, xFinal, xValue
     and xInverse) passed to sqlite3_create_window_function are pointers to
     C-language callbacks that implement the new function. xStep and xFinal
     must both be non-NULL. xValue and xInverse may either both be NULL, in
     which case a regular aggregate function is created, or must both be
     non-NULL, in which case the new function may be used as either an aggregate
     or aggregate window function. More details regarding the implementation
     of aggregate window functions are
     [user-defined window functions|available here].

     ^(If the final parameter to sqlite3_create_function_v2() or
     sqlite3_create_window_function() is not NULL, then it is destructor for
     the application data pointer. The destructor is invoked when the function
     is deleted, either by being overloaded or when the database connection
     closes.)^ ^The destructor is also invoked if the call to
     sqlite3_create_function_v2() fails.  ^When the destructor callback is
     invoked, it is passed a single argument which is a copy of the application
     data pointer which was the fifth parameter to sqlite3_create_function_v2().

     ^It is permitted to register multiple implementations of the same
     functions with the same name but with either differing numbers of
     arguments or differing preferred text encodings.  ^SQLite will use
     the implementation that most closely matches the way in which the
     SQL function is used.  ^A function implementation with a non-negative
     nArg parameter is a better match than a function implementation with
     a negative nArg.  ^A function where the preferred text encoding
     matches the database encoding is a better
     match than a function where the encoding is different.
     ^A function where the encoding difference is between UTF16le and UTF16be
     is a closer match than a function where the encoding difference is
     between UTF8 and UTF16.

     ^Built-in functions may be overloaded by new application-defined functions.

     ^An application-defined function is permitted to call other
     SQLite interfaces.  However, such calls must not
     close the database connection nor finalize or reset the prepared
     statement in which the function is running.
     */
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    @inlinable public func createWindowFunction(name: UnsafePointer<Int8>, argumentCount: Int32, flags flag: FunctionFlag, userData: UnsafeMutableRawPointer? = nil, stepHandler: FunctionStepHandler? = nil, finalHandler: FunctionFinalHandler? = nil, valueHandler: FunctionValueHandler? = nil, inverseHandler: FunctionInverseHandler? = nil, destroyHandler: FunctionDestroyHandler? = nil) -> ResultCode {
        sqlite3_create_window_function(rawValue, name, argumentCount, flag.rawValue, userData, stepHandler, finalHandler, valueHandler, inverseHandler, destroyHandler).resultCode
    }
}
