import MissedSwiftSQLite

extension Database {
    @frozen public struct OpenBlobFlag: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let readonly = Self(rawValue: 0)
        public static let readwrite = Self(rawValue: 1)

        public var debugDescription: String {
            switch self {
            case .readonly: return "LSQLITE_READONLY"
            case .readwrite: return "LSQLITE_READWRITE"
            default: return "OpenBlobFlag(rawValue: \(rawValue))"
            }
        }
    }

    @inlinable public func openBlob(_ blob: inout Blob?, databaseName: UnsafePointer<Int8>, tableName: UnsafePointer<Int8>, columnName: UnsafePointer<Int8>, rowID: RowID, flags: OpenBlobFlag) -> ResultCode {
        var blobPointer: OpaquePointer? = nil
        let resultCode = sqlite3_blob_open(rawValue, databaseName, tableName, columnName, rowID.rawValue, flags.rawValue, &blobPointer).resultCode
        if let blobPointer = blobPointer {
            blob = Blob(rawValue: blobPointer)
        }
        return resultCode
    }
}
