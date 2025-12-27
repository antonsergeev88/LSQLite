import MissedSwiftSQLite

extension Context {
    /// Destructor invoked when SQLite finishes with a result blob buffer.
    ///
    /// Prefer `resultStaticBlob(_:length:)` or `resultTransientBlob(_:length:)` for the
    /// common static and transient behaviors. Those helpers are just
    /// `resultBlob(_:length:destructor:)` with the corresponding default destructor.
    ///
    /// Related SQLite: `sqlite3_result_blob`, `SQLITE_STATIC`, `SQLITE_TRANSIENT`
    public typealias ResultBlobDestructor = @convention(c) (_ blob: UnsafeMutableRawPointer?) -> Void

    /// Sets the function result to a BLOB of `length` bytes from `blob`.
    ///
    /// If `destructor` is non-nil, SQLite calls it when it is done with the result.
    /// Use the static or transient helper to control whether SQLite copies the bytes.
    ///
    /// Related SQLite: `sqlite3_result_blob`, `SQLITE_STATIC`, `SQLITE_TRANSIENT`
    @inlinable public func resultBlob(_ blob: UnsafeRawPointer, length: Int32, destructor: ResultBlobDestructor? = nil) {
        sqlite3_result_blob(rawValue, blob, length, destructor)
    }

    /// Sets the result BLOB by copying the bytes immediately (transient).
    ///
    /// SQLite makes a private copy of the bytes, so the input may be modified or freed after the call.
    ///
    /// Related SQLite: `sqlite3_result_blob`, `SQLITE_TRANSIENT`
    @inlinable public func resultTransientBlob(_ blob: UnsafeRawPointer, length: Int32) {
        lsqlite3_result_transient_blob(rawValue, blob, length)
    }

    /// Sets the result BLOB without copying (static storage).
    ///
    /// The bytes must remain valid and unchanged while SQLite uses the result.
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
    /// If `length` is negative, SQLite reads through the first NUL byte.
    /// If non-negative, SQLite reads exactly `length` bytes (not characters).
    /// SQLite makes a private copy of the message before returning.
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
    /// The default error code for functions is `SQLITE_ERROR`.
    /// A subsequent call to `resultError(_:length:)` resets the code to `SQLITE_ERROR`.
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
    @inlinable public func resultInt64(_ int64: Int64) {
        sqlite3_result_int64(rawValue, int64)
    }

    /// Sets the function result to NULL.
    ///
    /// Related SQLite: `sqlite3_result_null`
    @inlinable public func resultNull() {
        sqlite3_result_null(rawValue)
    }

    /// Sets the function result to UTF-8 text by copying it immediately (transient).
    ///
    /// SQLite computes the byte length up to the first NUL and makes a private copy
    /// before returning.
    ///
    /// Related SQLite: `sqlite3_result_text`, `SQLITE_TRANSIENT`
    @inlinable public func resultText(_ text: String) {
        lsqlite3_result_transient_text(rawValue, text, -1)
    }

    /// Copies an existing Value into the function result.
    ///
    /// SQLite makes a private copy of the value, so the input can be modified or freed
    /// after the call.
    ///
    /// Related SQLite: `sqlite3_result_value`
    @inlinable public func resultValue(_ value: Value) {
        sqlite3_result_value(rawValue, value.rawValue)
    }

    /// Sets the function result to a zero-filled BLOB of the given length in bytes.
    ///
    /// Related SQLite: `sqlite3_result_zeroblob`
    @inlinable public func resultZeroBlob(length: Int32) {
        sqlite3_result_zeroblob(rawValue, length)
    }

    /// Assigns an application-defined subtype to the current result value.
    ///
    /// Only the low 8 bits are preserved by SQLite.
    /// Register the function with `SQLITE_RESULT_SUBTYPE` or this may have no effect.
    ///
    /// Related SQLite: `sqlite3_result_subtype`
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    @inlinable public func resultSubtype(_ subtype: Subtype) {
        sqlite3_result_subtype(rawValue, subtype.rawValue)
    }
}
