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

    /// Preferred text encoding for user-defined SQL functions.
    ///
    /// Related SQLite: `sqlite3_create_function_v2`, `sqlite3_create_function`, `sqlite3_create_function16`, `SQLITE_UTF8`, `SQLITE_UTF16LE`, `SQLITE_UTF16BE`, `SQLITE_UTF16`, `SQLITE_ANY`, `SQLITE_UTF16_ALIGNED`
    @frozen public struct TextEncoding: Hashable, RawRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        /// UTF-8 text encoding.
        ///
        /// Related SQLite: `SQLITE_UTF8`
        public static let utf8 = Self(rawValue: SQLITE_UTF8)

        /// UTF-16 little-endian text encoding.
        ///
        /// Related SQLite: `SQLITE_UTF16LE`
        public static let utf16le = Self(rawValue: SQLITE_UTF16LE)

        /// UTF-16 big-endian text encoding.
        ///
        /// Related SQLite: `SQLITE_UTF16BE`
        public static let utf16be = Self(rawValue: SQLITE_UTF16BE)

        /// UTF-16 text encoding using native byte order.
        ///
        /// Related SQLite: `SQLITE_UTF16`
        public static let utf16 = Self(rawValue: SQLITE_UTF16)

        /// Deprecated encoding sentinel that lets SQLite choose a text representation.
        ///
        /// Related SQLite: `SQLITE_ANY`
        public static let any = Self(rawValue: SQLITE_ANY)

        public var description: String {
            switch self {
            case .utf8: "utf8"
            case .utf16le: "utf16le"
            case .utf16be: "utf16be"
            case .utf16: "utf16"
            case .any: "any"
            default: "unknown"
            }
        }

        public var debugDescription: String {
            switch self {
            case .utf8: "SQLITE_UTF8"
            case .utf16le: "SQLITE_UTF16LE"
            case .utf16be: "SQLITE_UTF16BE"
            case .utf16: "SQLITE_UTF16"
            case .any: "SQLITE_ANY"
            default: rawValue.description
            }
        }
    }

    /// Function flags describing determinism and security properties for user-defined SQL functions.
    ///
    /// Related SQLite: `sqlite3_create_function_v2`, `sqlite3_create_window_function`, `SQLITE_DETERMINISTIC`, `SQLITE_DIRECTONLY`, `SQLITE_SUBTYPE`, `SQLITE_INNOCUOUS`, `SQLITE_RESULT_SUBTYPE`, `SQLITE_SELFORDER1`
    @frozen public struct FunctionFlag: Hashable, OptionSet, CustomStringConvertible, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        /// Marks a function as deterministic so SQLite can apply optimizations.
        ///
        /// Related SQLite: `SQLITE_DETERMINISTIC`
        public static let deterministic = Self(rawValue: SQLITE_DETERMINISTIC)

        /// Restricts the function to top-level SQL only.
        ///
        /// Related SQLite: `SQLITE_DIRECTONLY`
        public static let directOnly = Self(rawValue: SQLITE_DIRECTONLY)

        /// Indicates the function inspects argument subtypes via `sqlite3_value_subtype`.
        ///
        /// Related SQLite: `SQLITE_SUBTYPE`
        public static let subtype = Self(rawValue: SQLITE_SUBTYPE)

        /// Marks the function as innocuous for trusted schema checks.
        ///
        /// Related SQLite: `SQLITE_INNOCUOUS`
        public static let innocuous = Self(rawValue: SQLITE_INNOCUOUS)

        /// Indicates the function may call `sqlite3_result_subtype`.
        ///
        /// Related SQLite: `SQLITE_RESULT_SUBTYPE`
        public static let resultSubtype = Self(rawValue: SQLITE_RESULT_SUBTYPE)

        private static let knownMask: UInt32 = {
            var mask = UInt32(bitPattern: Self.deterministic.rawValue)
            mask |= UInt32(bitPattern: Self.directOnly.rawValue)
            mask |= UInt32(bitPattern: Self.subtype.rawValue)
            mask |= UInt32(bitPattern: Self.innocuous.rawValue)
            mask |= UInt32(bitPattern: Self.resultSubtype.rawValue)
            return mask
        }()

        private static func hexString(_ rawValue: UInt32) -> String {
            "0x" + String(rawValue, radix: 16, uppercase: true)
        }

        public var description: String {
            var parts: [String] = []
            if contains(.deterministic) { parts.append(".deterministic") }
            if contains(.directOnly) { parts.append(".directOnly") }
            if contains(.subtype) { parts.append(".subtype") }
            if contains(.innocuous) { parts.append(".innocuous") }
            if contains(.resultSubtype) { parts.append(".resultSubtype") }

            let rawBits = UInt32(bitPattern: rawValue)
            let unknownBits = rawBits & ~Self.knownMask
            if unknownBits != 0 {
                if parts.isEmpty { return "unknown" }
                parts.append("unknown")
            }
            if parts.isEmpty { return "[]" }
            return "[\(parts.joined(separator: ", "))]"
        }

        public var debugDescription: String {
            var parts: [String] = []
            if contains(.deterministic) { parts.append("SQLITE_DETERMINISTIC") }
            if contains(.directOnly) { parts.append("SQLITE_DIRECTONLY") }
            if contains(.subtype) { parts.append("SQLITE_SUBTYPE") }
            if contains(.innocuous) { parts.append("SQLITE_INNOCUOUS") }
            if contains(.resultSubtype) { parts.append("SQLITE_RESULT_SUBTYPE") }

            let rawBits = UInt32(bitPattern: rawValue)
            let unknownBits = rawBits & ~Self.knownMask
            if unknownBits != 0 {
                let hexValue = Self.hexString(rawBits)
                if parts.isEmpty { return hexValue }
                parts.append(hexValue)
            }
            if parts.isEmpty { return "[]" }
            return parts.joined(separator: "|")
        }
    }

    /// Registers or redefines a scalar or aggregate SQL function on this connection.
    /// - Parameters:
    ///   - name: Function name (UTF-8).
    ///   - argumentCount: Allowed argument count; `-1` permits variable arguments.
    ///   - textEncoding: Preferred text encoding for the function.
    ///   - flags: Function behavior flags.
    ///   - userData: Context pointer available via `Context.userData`.
    ///   - funcHandler: Scalar implementation; set when defining a scalar function.
    ///   - stepHandler: Aggregate step implementation; set when defining an aggregate or window function.
    ///   - finalHandler: Aggregate finalizer; set when defining an aggregate or window function.
    ///   - destroyHandler: Optional cleanup for `userData` when the function is replaced or the connection closes.
    /// - Returns: Result of `sqlite3_create_function_v2`.
    ///
    /// Related SQLite: `sqlite3_create_function_v2`, `sqlite3_user_data`, `SQLITE_UTF8`, `SQLITE_DETERMINISTIC`, `SQLITE_LIMIT_FUNCTION_ARG`
    @inlinable public func createFunction(name: String, argumentCount: Int32, textEncoding: TextEncoding, flags: FunctionFlag = [], userData: UnsafeMutableRawPointer? = nil, funcHandler: FunctionFuncHandler? = nil, stepHandler: FunctionStepHandler? = nil, finalHandler: FunctionFinalHandler? = nil, destroyHandler: FunctionDestroyHandler? = nil) -> ResultCode {
        let combinedFlags = textEncoding.rawValue | flags.rawValue
        return sqlite3_create_function_v2(rawValue, name, argumentCount, combinedFlags, userData, funcHandler, stepHandler, finalHandler, destroyHandler).resultCode
    }

    /// Registers or redefines an aggregate or window function on this connection.
    /// - Parameters:
    ///   - name: Function name (UTF-8).
    ///   - argumentCount: Allowed argument count; `-1` permits variable arguments.
    ///   - textEncoding: Preferred text encoding for the function.
    ///   - flags: Function behavior flags.
    ///   - userData: Context pointer available via `Context.userData`.
    ///   - stepHandler: Aggregate step implementation (required).
    ///   - finalHandler: Aggregate finalizer (required).
    ///   - valueHandler: Window value callback; set with `inverseHandler` for window behavior.
    ///   - inverseHandler: Window inverse step; set with `valueHandler` for window behavior.
    ///   - destroyHandler: Optional cleanup for `userData` when the function is dropped.
    /// - Returns: Result of `sqlite3_create_window_function`.
    ///
    /// Related SQLite: `sqlite3_create_window_function`, `sqlite3_create_function_v2`, `sqlite3_user_data`, `SQLITE_UTF8`
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    @inlinable public func createWindowFunction(name: String, argumentCount: Int32, textEncoding: TextEncoding, flags: FunctionFlag = [], userData: UnsafeMutableRawPointer? = nil, stepHandler: FunctionStepHandler? = nil, finalHandler: FunctionFinalHandler? = nil, valueHandler: FunctionValueHandler? = nil, inverseHandler: FunctionInverseHandler? = nil, destroyHandler: FunctionDestroyHandler? = nil) -> ResultCode {
        let combinedFlags = textEncoding.rawValue | flags.rawValue
        return sqlite3_create_window_function(rawValue, name, argumentCount, combinedFlags, userData, stepHandler, finalHandler, valueHandler, inverseHandler, destroyHandler).resultCode
    }
}
