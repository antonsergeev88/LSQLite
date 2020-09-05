import SQLite3

extension Database {
    public typealias FuncHandler = @convention(c) (_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) -> Void
    public typealias StepHandler = @convention(c) (_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) -> Void
    public typealias FinalHandler = @convention(c) (_ context: OpaquePointer?) -> Void
    public typealias ValueHandler = @convention(c) (_ context: OpaquePointer?) -> Void
    public typealias InverseHandler = @convention(c) (_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) -> Void
    public typealias DestroyHandler = @convention(c) (_ userData: UnsafeMutableRawPointer?) -> Void

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

    @inlinable public func createFunction(name: UnsafePointer<Int8>, argumentCount: Int32, flags flag: FunctionFlag, userData: UnsafeMutableRawPointer?, funcHandler: FuncHandler? = nil, stepHandler: StepHandler? = nil, finalHandler: FinalHandler? = nil, destroyHandler: DestroyHandler? = nil) -> ResultCode {
        sqlite3_create_function_v2(rawValue, name, argumentCount, flag.rawValue, userData, funcHandler, stepHandler, finalHandler, destroyHandler).resultCode
    }

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    @inlinable public func createWindowFunction(name: UnsafePointer<Int8>, argumentCount: Int32, flags flag: FunctionFlag, userData: UnsafeMutableRawPointer?, stepHandler: StepHandler? = nil, finalHandler: FinalHandler? = nil, valueHandler: ValueHandler? = nil, inverseHandler: InverseHandler? = nil, destroyHandler: DestroyHandler? = nil) -> ResultCode {
        sqlite3_create_window_function(rawValue, name, argumentCount, flag.rawValue, userData, stepHandler, finalHandler, valueHandler, inverseHandler, destroyHandler).resultCode
    }
}
