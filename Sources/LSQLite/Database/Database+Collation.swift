import MissedSwiftSQLite

extension Database {
    public typealias CollationCompareHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ lhsLength: Int32, _ lhs: UnsafeRawPointer?, _ rhsLength: Int32, _ rhs: UnsafeRawPointer?) -> Int32
    public typealias CollationDestroyHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?) -> Void
    public typealias CollationNeededHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?, _ database: OpaquePointer?, _ collationFlag: Int32, _ name: UnsafePointer<Int8>?) -> Void

    @frozen public struct CollationFlag: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let utf8 = Self(rawValue: SQLITE_UTF8)
        public static let utf16le = Self(rawValue: SQLITE_UTF16LE)
        public static let utf16be = Self(rawValue: SQLITE_UTF16BE)
        public static let utf16 = Self(rawValue: SQLITE_UTF16)
        public static let utf16Aligned = Self(rawValue: SQLITE_UTF16_ALIGNED)

        public static let deterministic = Self(rawValue: SQLITE_DETERMINISTIC)

        public var debugDescription: String {
            switch self {
            case .utf8: return "SQLITE_UTF8"
            case .utf16le: return "SQLITE_UTF16LE"
            case .utf16be: return "SQLITE_UTF16BE"
            case .utf16: return "SQLITE_UTF16"
            case .utf16Aligned: return "SQLITE_UTF16_ALIGNED"
            default: return "FunctionFlag(rawValue: \(rawValue))"
            }
        }
    }

    /**
     CAPI3REF: Define New Collating Sequences
     METHOD: sqlite3

     ^These functions add, remove, or modify a [collation] associated
     with the [database connection] specified as the first argument.

     ^The name of the collation is a UTF-8 string
     for sqlite3_create_collation() and sqlite3_create_collation_v2()
     and a UTF-16 string in native byte order for sqlite3_create_collation16().
     ^Collation names that compare equal according to [sqlite3_strnicmp()] are
     considered to be the same name.

     ^(The third argument (eTextRep) must be one of the constants:
     
      [SQLITE_UTF8],
      [SQLITE_UTF16LE],
      [SQLITE_UTF16BE],
      [SQLITE_UTF16], or
      [SQLITE_UTF16_ALIGNED].
     )^
     ^The eTextRep argument determines the encoding of strings passed
     to the collating function callback, xCallback.
     ^The [SQLITE_UTF16] and [SQLITE_UTF16_ALIGNED] values for eTextRep
     force strings to be UTF16 with native byte order.
     ^The [SQLITE_UTF16_ALIGNED] value for eTextRep forces strings to begin
     on an even byte address.

     ^The fourth argument, pArg, is an application data pointer that is passed
     through as the first argument to the collating function callback.

     ^The fifth argument, xCallback, is a pointer to the collating function.
     ^Multiple collating functions can be registered using the same name but
     with different eTextRep parameters and SQLite will use whichever
     function requires the least amount of data transformation.
     ^If the xCallback argument is NULL then the collating function is
     deleted.  ^When all collating functions having the same name are deleted,
     that collation is no longer usable.

     ^The collating function callback is invoked with a copy of the pArg
     application data pointer and with two strings in the encoding specified
     by the eTextRep argument.  The collating function must return an
     integer that is negative, zero, or positive
     if the first string is less than, equal to, or greater than the second,
     respectively.  A collating function must always return the same answer
     given the same inputs.  If two or more collating functions are registered
     to the same collation name (using different eTextRep values) then all
     must give an equivalent answer when invoked with equivalent strings.
     The collating function must obey the following properties for all
     strings A, B, and C:

     
      If A==B then B==A.
      If A==B and B==C then A==C.
      If A&lt;B THEN B&gt;A.
      If A&lt;B and B&lt;C then A&lt;C.
     

     If a collating function fails any of the above constraints and that
     collating function is  registered and used, then the behavior of SQLite
     is undefined.

     ^The sqlite3_create_collation_v2() works like sqlite3_create_collation()
     with the addition that the xDestroy callback is invoked on pArg when
     the collating function is deleted.
     ^Collating functions are deleted when they are overridden by later
     calls to the collation creation functions or when the
     [database connection] is closed using [sqlite3_close()].

     ^The xDestroy callback is <u>not</u> called if the
     sqlite3_create_collation_v2() function fails.  Applications that invoke
     sqlite3_create_collation_v2() with a non-NULL xDestroy argument should
     check the return code and dispose of the application data pointer
     themselves rather than expecting SQLite to deal with it for them.
     This is different from every other SQLite interface.  The inconsistency
     is unfortunate but cannot be changed without breaking backwards
     compatibility.

     See also:  [sqlite3_collation_needed()] and [sqlite3_collation_needed16()].
     */
    @inlinable public func createCollation(name: UnsafePointer<Int8>, flag: CollationFlag, userData: UnsafeMutableRawPointer? = nil, compareHandler: CollationCompareHandler? = nil, destroyHandler: CollationDestroyHandler? = nil) -> ResultCode {
        sqlite3_create_collation_v2(rawValue, name, flag.rawValue, userData, compareHandler, destroyHandler).resultCode
    }

    /**
     CAPI3REF: Collation Needed Callbacks
     METHOD: sqlite3

     ^To avoid having to register all collation sequences before a database
     can be used, a single callback function may be registered with the
     [database connection] to be invoked whenever an undefined collation
     sequence is required.

     ^If the function is registered using the sqlite3_collation_needed() API,
     then it is passed the names of undefined collation sequences as strings
     encoded in UTF-8. ^If sqlite3_collation_needed16() is used,
     the names are passed as UTF-16 in machine native byte order.
     ^A call to either function replaces the existing collation-needed callback.

     ^(When the callback is invoked, the first argument passed is a copy
     of the second argument to sqlite3_collation_needed() or
     sqlite3_collation_needed16().  The second argument is the database
     connection.  The third argument is one of [SQLITE_UTF8], [SQLITE_UTF16BE],
     or [SQLITE_UTF16LE], indicating the most desirable form of the collation
     sequence function required.  The fourth parameter is the name of the
     required collation sequence.)^

     The callback function should register the desired collation using
     [sqlite3_create_collation()], [sqlite3_create_collation16()], or
     [sqlite3_create_collation_v2()].
     */
    @inlinable public func collationNeeded(userData: UnsafeMutableRawPointer? = nil, neededHandler: CollationNeededHandler? = nil) -> ResultCode {
        sqlite3_collation_needed(rawValue, userData, neededHandler).resultCode
    }
}
