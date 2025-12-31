import MissedSwiftSQLite

extension Context {
    /// Destructor invoked when a result BLOB is discarded.
    /// - Parameter blob: Pointer to the BLOB bytes supplied to `resultBlob`.
    /// - Returns: None.
    ///
    /// Prefer `resultStaticBlob(_:length:)` or `resultTransientBlob(_:length:)`
    /// to select common static and transient behaviors explicitly.
    ///
    /// Related SQLite: `sqlite3_result_blob`, `SQLITE_STATIC`, `SQLITE_TRANSIENT`
    public typealias ResultBlobDestructor = @convention(c) (_ blob: UnsafeMutableRawPointer?) -> Void

    /// Sets the function result to a BLOB of `length` bytes from `blob`.
    ///
    /// SQLite calls `destructor` when it is done with the bytes.
    /// Use the static or transient helpers to control whether the bytes are copied.
    /// This method requires an explicit destructor to avoid ambiguous lifetimes.
    /// - Parameters:
    ///   - blob: Pointer to the BLOB bytes.
    ///   - length: Byte count of the BLOB.
    ///   - destructor: Cleanup invoked when the result is discarded.
    /// - Returns: None.
    ///
    /// Related SQLite: `sqlite3_result_blob`, `SQLITE_STATIC`, `SQLITE_TRANSIENT`
    @inlinable public func resultBlob(_ blob: UnsafeRawPointer, length: Int32, destructor: ResultBlobDestructor) {
        sqlite3_result_blob(rawValue, blob, length, destructor)
    }

    /// Sets the result BLOB by copying the bytes immediately.
    ///
    /// The buffer only needs to remain valid until this call returns.
    /// - Parameters:
    ///   - blob: Pointer to the BLOB bytes.
    ///   - length: Byte count of the BLOB.
    /// - Returns: None.
    ///
    /// Related SQLite: `sqlite3_result_blob`, `SQLITE_TRANSIENT`
    @inlinable public func resultTransientBlob(_ blob: UnsafeRawPointer, length: Int32) {
        lsqlite3_result_transient_blob(rawValue, blob, length)
    }

    /// Sets the result BLOB without copying.
    ///
    /// The bytes must remain valid and unchanged while SQLite uses the result.
    /// - Parameters:
    ///   - blob: Pointer to the BLOB bytes.
    ///   - length: Byte count of the BLOB.
    /// - Returns: None.
    ///
    /// Related SQLite: `sqlite3_result_blob`, `SQLITE_STATIC`
    @inlinable public func resultStaticBlob(_ blob: UnsafeRawPointer, length: Int32) {
        lsqlite3_result_static_blob(rawValue, blob, length)
    }

    /// Sets the function result to a floating-point value.
    /// - Parameter double: Result value.
    /// - Returns: None.
    ///
    /// Related SQLite: `sqlite3_result_double`
    @inlinable public func resultDouble(_ double: Double) {
        sqlite3_result_double(rawValue, double)
    }

    /// Causes the SQL function to return an error with the provided UTF-8 message.
    ///
    /// If `length` is negative, the message is read through the first NUL byte.
    /// If `length` is non-negative, exactly `length` bytes are used.
    /// SQLite makes a private copy of the message before returning.
    /// - Parameters:
    ///   - message: UTF-8 error message.
    ///   - length: Byte count to read, or a negative value to read through the first NUL.
    /// - Returns: None.
    ///
    /// Related SQLite: `sqlite3_result_error`
    @inlinable public func resultError(_ message: String, length: Int32) {
        sqlite3_result_error(rawValue, message, length)
    }

    /// Sets an error result indicating the value is too large.
    /// - Returns: None.
    ///
    /// Related SQLite: `sqlite3_result_error_toobig`
    @inlinable public func resultTooBigError() {
        sqlite3_result_error_toobig(rawValue)
    }

    /// Sets an error result indicating a memory allocation failure.
    /// - Returns: None.
    ///
    /// Related SQLite: `sqlite3_result_error_nomem`
    @inlinable public func resultNoMemoryError() {
        sqlite3_result_error_nomem(rawValue)
    }

    /// Changes the error code returned for a function error.
    ///
    /// The default error code for functions is `.error`.
    /// A subsequent call to `resultError(_:length:)` resets the code to that default.
    /// - Parameter code: Error code to associate with the current error.
    /// - Returns: None.
    ///
    /// Related SQLite: `sqlite3_result_error_code`
    @inlinable public func resultErrorCode(_ code: ResultCode) {
        sqlite3_result_error_code(rawValue, code.rawValue)
    }

    /// Sets the function result to a 32-bit signed integer.
    /// - Parameter int: Result value.
    /// - Returns: None.
    ///
    /// Related SQLite: `sqlite3_result_int`
    @inlinable public func resultInt(_ int: Int32) {
        sqlite3_result_int(rawValue, int)
    }

    /// Sets the function result to a 64-bit signed integer.
    /// - Parameter int64: Result value.
    /// - Returns: None.
    ///
    /// Related SQLite: `sqlite3_result_int64`
    @inlinable public func resultInt64(_ int64: Int64) {
        sqlite3_result_int64(rawValue, int64)
    }

    /// Sets the function result to NULL.
    /// - Returns: None.
    ///
    /// Related SQLite: `sqlite3_result_null`
    @inlinable public func resultNull() {
        sqlite3_result_null(rawValue)
    }

    /// Sets the function result to UTF-8 text by copying it immediately.
    ///
    /// If the string contains a `\0` character, only the prefix before it is used.
    /// SQLite makes a private copy before returning.
    /// - Parameter text: Text to return.
    /// - Returns: None.
    ///
    /// Related SQLite: `sqlite3_result_text`, `SQLITE_TRANSIENT`
    @inlinable public func resultText(_ text: String) {
        lsqlite3_result_transient_text(rawValue, text, -1)
    }

    /// Copies an existing Value into the function result.
    ///
    /// SQLite makes a private copy of the value, so the input can be modified or freed
    /// after the call.
    /// - Parameter value: Value to copy into the result.
    /// - Returns: None.
    ///
    /// Related SQLite: `sqlite3_result_value`
    @inlinable public func resultValue(_ value: Value) {
        sqlite3_result_value(rawValue, value.rawValue)
    }

    /// Sets the function result to a zero-filled BLOB of the given length in bytes.
    /// - Parameter length: Byte count of the zero-filled BLOB.
    /// - Returns: None.
    ///
    /// Related SQLite: `sqlite3_result_zeroblob`
    @inlinable public func resultZeroBlob(length: Int32) {
        sqlite3_result_zeroblob(rawValue, length)
    }
}
