import MissedSwiftSQLite

extension Context {
    public typealias ResultBlobDestructor = @convention(c) (_ blob: UnsafeMutableRawPointer?) -> Void
    public typealias ResultTextDestructor = @convention(c) (_ blob: UnsafeMutableRawPointer?) -> Void

    @inlinable public func resultBlob(_ blob: UnsafeRawPointer, length: Int32, destructor: ResultBlobDestructor? = nil) {
        sqlite3_result_blob(rawValue, blob, length, destructor)
    }

    @inlinable public func resultTransientBlob(_ blob: UnsafeRawPointer, length: Int32) {
        lsqlite3_result_transient_blob(rawValue, blob, length)
    }

    @inlinable public func resultStaticBlob(_ blob: UnsafeRawPointer, length: Int32) {
        lsqlite3_result_static_blob(rawValue, blob, length)
    }

    @inlinable public func resultDouble(_ double: Double) {
        sqlite3_result_double(rawValue, double)
    }

    @inlinable public func resultError(_ message: UnsafePointer<Int8>, length: Int32) {
        sqlite3_result_error(rawValue, message, length)
    }

    @inlinable public func resultTooBigError() {
        sqlite3_result_error_toobig(rawValue)
    }

    @inlinable public func resultNoMemoryError() {
        sqlite3_result_error_nomem(rawValue)
    }

    @inlinable public func resultErrorCode(_ code: ResultCode) {
        sqlite3_result_error_code(rawValue, code.rawValue)
    }

    @inlinable public func resultInt(_ int: Int32) {
        sqlite3_result_int(rawValue, int)
    }

    @inlinable public func resultInt64(_ int64: sqlite3_int64) {
        sqlite3_result_int64(rawValue, int64)
    }

    @inlinable public func resultNull() {
        sqlite3_result_null(rawValue)
    }

    @inlinable public func resultText(_ text: UnsafePointer<Int8>, length: Int32, destructor: ResultTextDestructor? = nil) {
        sqlite3_result_text(rawValue, text, length, destructor)
    }

    @inlinable public func resultTransientText(_ text: UnsafePointer<Int8>, length: Int32) {
        lsqlite3_result_transient_text(rawValue, text, length)
    }

    @inlinable public func resultStaticText(_ text: UnsafePointer<Int8>, length: Int32) {
        lsqlite3_result_static_text(rawValue, text, length)
    }

    @inlinable public func resultValue(_ value: Value) {
        sqlite3_result_value(rawValue, value.rawValue)
    }

    @inlinable public func resultZeroBlob(length: Int32) {
        sqlite3_result_zeroblob(rawValue, length)
    }

    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    @inlinable public func resultSubtype(_ subtype: Subtype) {
        sqlite3_result_subtype(rawValue, subtype.rawValue)
    }
}
