/**
 CAPI3REF: A Handle To An Open BLOB
 KEYWORDS: {BLOB handle} {BLOB handles}

 An instance of this object represents an open BLOB on which
 [sqlite3_blob_open | incremental BLOB I/O] can be performed.
 ^Objects of this type are created by [sqlite3_blob_open()]
 and destroyed by [sqlite3_blob_close()].
 ^The [sqlite3_blob_read()] and [sqlite3_blob_write()] interfaces
 can be used to read or write small subsections of the BLOB.
 ^The [sqlite3_blob_bytes()] interface returns the size of the BLOB in bytes.
 */
@frozen public struct Blob: RawRepresentable {
    public let rawValue: OpaquePointer

    @inlinable public init(rawValue: OpaquePointer) {
        self.rawValue = rawValue
    }
}
