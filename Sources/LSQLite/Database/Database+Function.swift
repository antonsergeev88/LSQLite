import MissedSwiftSQLite

extension Database {
    /// C callback invoked to compute a scalar SQL function result.
    ///
    /// Related SQLite: `sqlite3_create_function_v2`, `sqlite3_user_data`
    public typealias FunctionFuncHandler = @convention(c) (_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) -> Void

    /// C callback invoked for each row of an aggregate or window function.
    ///
    /// Related SQLite: `sqlite3_create_function_v2`, `sqlite3_create_window_function`
    public typealias FunctionStepHandler = @convention(c) (_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) -> Void

    /// Finalizer for aggregate or window function state.
    ///
    /// Related SQLite: `sqlite3_create_function_v2`, `sqlite3_create_window_function`
    public typealias FunctionFinalHandler = @convention(c) (_ context: OpaquePointer?) -> Void

    /// Window function callback that produces a value for the current frame.
    ///
    /// Related SQLite: `sqlite3_create_window_function`
    public typealias FunctionValueHandler = @convention(c) (_ context: OpaquePointer?) -> Void

    /// Window function callback that reverses a prior step invocation.
    ///
    /// Related SQLite: `sqlite3_create_window_function`
    public typealias FunctionInverseHandler = @convention(c) (_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) -> Void

    /// Cleanup callback executed when a user-defined function is destroyed.
    ///
    /// Related SQLite: `sqlite3_create_function_v2`, `sqlite3_create_window_function`
    public typealias FunctionDestroyHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?) -> Void

    /// Options describing text encoding and determinism for user-defined SQL functions.
    ///
    /// Related SQLite: `sqlite3_create_function_v2`, `sqlite3_create_window_function`, `SQLITE_UTF8`, `SQLITE_UTF16LE`, `SQLITE_UTF16BE`, `SQLITE_UTF16`, `SQLITE_UTF16_ALIGNED`, `SQLITE_DETERMINISTIC`
    @frozen public struct FunctionFlag: Hashable, OptionSet, CustomDebugStringConvertible {
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

        /// Debug label for the function flag value.
        ///
        /// Related SQLite: `sqlite3_create_function_v2`, `SQLITE_UTF8`, `SQLITE_UTF16LE`, `SQLITE_UTF16BE`, `SQLITE_UTF16`, `SQLITE_UTF16_ALIGNED`, `SQLITE_DETERMINISTIC`
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

    /// Registers or redefines a scalar or aggregate SQL function on this connection.
    /// - Parameters:
    ///   - name: Function name (UTF-8).
    ///   - argumentCount: Allowed argument count; `-1` permits variable arguments.
    ///   - flag: Encoding and determinism options.
    ///   - userData: Context pointer available via `Context.userData`.
    ///   - funcHandler: Scalar implementation; set when defining a scalar function.
    ///   - stepHandler: Aggregate step implementation; set when defining an aggregate or window function.
    ///   - finalHandler: Aggregate finalizer; set when defining an aggregate or window function.
    ///   - destroyHandler: Optional cleanup for `userData` when the function is replaced or the connection closes.
    /// - Returns: Result of `sqlite3_create_function_v2`.
    ///
    /// Related SQLite: `sqlite3_create_function_v2`, `sqlite3_user_data`, `SQLITE_DETERMINISTIC`, `SQLITE_LIMIT_FUNCTION_ARG`
    @inlinable public func createFunction(name: String, argumentCount: Int32, flags flag: FunctionFlag, userData: UnsafeMutableRawPointer? = nil, funcHandler: FunctionFuncHandler? = nil, stepHandler: FunctionStepHandler? = nil, finalHandler: FunctionFinalHandler? = nil, destroyHandler: FunctionDestroyHandler? = nil) -> ResultCode {
        sqlite3_create_function_v2(rawValue, name, argumentCount, flag.rawValue, userData, funcHandler, stepHandler, finalHandler, destroyHandler).resultCode
    }

    /// Registers or redefines an aggregate or window function on this connection.
    /// - Parameters:
    ///   - name: Function name (UTF-8).
    ///   - argumentCount: Allowed argument count; `-1` permits variable arguments.
    ///   - flag: Encoding and determinism options.
    ///   - userData: Context pointer available via `Context.userData`.
    ///   - stepHandler: Aggregate step implementation (required).
    ///   - finalHandler: Aggregate finalizer (required).
    ///   - valueHandler: Window value callback; set with `inverseHandler` for window behavior.
    ///   - inverseHandler: Window inverse step; set with `valueHandler` for window behavior.
    ///   - destroyHandler: Optional cleanup for `userData` when the function is dropped.
    /// - Returns: Result of `sqlite3_create_window_function`.
    ///
    /// Related SQLite: `sqlite3_create_window_function`, `sqlite3_create_function_v2`, `sqlite3_user_data`
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    @inlinable public func createWindowFunction(name: String, argumentCount: Int32, flags flag: FunctionFlag, userData: UnsafeMutableRawPointer? = nil, stepHandler: FunctionStepHandler? = nil, finalHandler: FunctionFinalHandler? = nil, valueHandler: FunctionValueHandler? = nil, inverseHandler: FunctionInverseHandler? = nil, destroyHandler: FunctionDestroyHandler? = nil) -> ResultCode {
        sqlite3_create_window_function(rawValue, name, argumentCount, flag.rawValue, userData, stepHandler, finalHandler, valueHandler, inverseHandler, destroyHandler).resultCode
    }
}
