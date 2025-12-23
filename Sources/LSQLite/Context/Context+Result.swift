import MissedSwiftSQLite

extension Context {
    /// Destructor invoked when SQLite frees a blob result buffer.
    ///
    /// Related SQLite: `sqlite3_result_blob`, `SQLITE_STATIC`, `SQLITE_TRANSIENT`
    public typealias ResultBlobDestructor = @convention(c) (_ blob: UnsafeMutableRawPointer?) -> Void

    /// Destructor invoked when SQLite frees a text result buffer.
    ///
    /// Related SQLite: `sqlite3_result_text`, `SQLITE_STATIC`, `SQLITE_TRANSIENT`
    public typealias ResultTextDestructor = @convention(c) (_ blob: UnsafeMutableRawPointer?) -> Void

    /// Sets the function result to the given blob with optional destructor.
    ///
    /// Related SQLite: `sqlite3_result_blob`, `SQLITE_STATIC`, `SQLITE_TRANSIENT`
    @inlinable public func resultBlob(_ blob: UnsafeRawPointer, length: Int32, destructor: ResultBlobDestructor? = nil) {
        sqlite3_result_blob(rawValue, blob, length, destructor)
    }

    /// Sets the result blob by copying the bytes immediately (transient).
    ///
    /// Related SQLite: `sqlite3_result_blob`, `SQLITE_TRANSIENT`
    @inlinable public func resultTransientBlob(_ blob: UnsafeRawPointer, length: Int32) {
        lsqlite3_result_transient_blob(rawValue, blob, length)
    }

    /// Sets the result blob that remains valid for SQLite to use (static).
    ///
    /// Related SQLite: `sqlite3_result_blob`, `SQLITE_STATIC`
    @inlinable public func resultStaticBlob(_ blob: UnsafeRawPointer, length: Int32) {
        lsqlite3_result_static_blob(rawValue, blob, length)
    }

    /// Sets the function result to a Double.
    ///
    /// Related SQLite: `sqlite3_result_double`
    @inlinable public func resultDouble(_ double: Double) {
        sqlite3_result_double(rawValue, double)
    }

    /// Sets an error result with the provided UTF-8 message.
    ///
    /// Related SQLite: `sqlite3_result_error`
    @inlinable public func resultError(_ message: String, length: Int32) {
        sqlite3_result_error(rawValue, message, length)
    }

    /// Sets an error result indicating the value is too large.
    ///
    /// Related SQLite: `sqlite3_result_error_toobig`
    @inlinable public func resultTooBigError() {
        sqlite3_result_error_toobig(rawValue)
    }

    /// Sets an error result indicating OOM.
    ///
    /// Related SQLite: `sqlite3_result_error_nomem`
    @inlinable public func resultNoMemoryError() {
        sqlite3_result_error_nomem(rawValue)
    }

    /// Sets an error result using the provided result code.
    ///
    /// Related SQLite: `sqlite3_result_error_code`
    @inlinable public func resultErrorCode(_ code: ResultCode) {
        sqlite3_result_error_code(rawValue, code.rawValue)
    }

    /// Sets the function result to a 32-bit integer.
    ///
    /// Related SQLite: `sqlite3_result_int`
    @inlinable public func resultInt(_ int: Int32) {
        sqlite3_result_int(rawValue, int)
    }

    /// Sets the function result to a 64-bit integer.
    ///
    /// Related SQLite: `sqlite3_result_int64`
    @inlinable public func resultInt64(_ int64: sqlite3_int64) {
        sqlite3_result_int64(rawValue, int64)
    }

    /// Sets the function result to NULL.
    ///
    /// Related SQLite: `sqlite3_result_null`
    @inlinable public func resultNull() {
        sqlite3_result_null(rawValue)
    }

    /// Sets the function result to UTF-8 text with optional destructor; length defaults to full string.
    ///
    /// Related SQLite: `sqlite3_result_text`, `SQLITE_STATIC`, `SQLITE_TRANSIENT`
    @inlinable public func resultText(_ text: UnsafePointer<Int8>, length: Int32, destructor: ResultTextDestructor? = nil) {
        sqlite3_result_text(rawValue, text, length, destructor)
    }

    /// Sets the result text by copying it immediately (transient).
    ///
    /// Related SQLite: `sqlite3_result_text`, `SQLITE_TRANSIENT`
    @inlinable public func resultTransientText(_ text: String, length: Int32) {
        lsqlite3_result_transient_text(rawValue, text, length)
    }

    /// Sets the result text that remains valid for SQLite to use (static).
    ///
    /// Related SQLite: `sqlite3_result_text`, `SQLITE_STATIC`
    @inlinable public func resultStaticText(_ text: UnsafePointer<Int8>, length: Int32) {
        lsqlite3_result_static_text(rawValue, text, length)
    }

    /// Copies an existing Value into the function result.
    ///
    /// Related SQLite: `sqlite3_result_value`
    @inlinable public func resultValue(_ value: Value) {
        sqlite3_result_value(rawValue, value.rawValue)
    }

    /// Sets the function result to a zero-filled blob of the given length.
    ///
    /// Related SQLite: `sqlite3_result_zeroblob`
    @inlinable public func resultZeroBlob(length: Int32) {
        sqlite3_result_zeroblob(rawValue, length)
    }

    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    /// Assigns an application-defined subtype to the current result value.
    ///
    /// Related SQLite: `sqlite3_result_subtype`
    @inlinable public func resultSubtype(_ subtype: Subtype) {
        sqlite3_result_subtype(rawValue, subtype.rawValue)
    }
}
