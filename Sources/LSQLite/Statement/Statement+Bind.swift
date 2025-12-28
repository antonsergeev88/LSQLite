import MissedSwiftSQLite

extension Statement {
    /// Destructor invoked when SQLite releases a bound blob buffer.
    /// - Parameter blob: Pointer passed when binding the blob.
    /// - Returns: Void.
    ///
    /// Related SQLite: `sqlite3_bind_blob`, `SQLITE_STATIC`, `SQLITE_TRANSIENT`
    public typealias BindBlobDestructor = @convention(c) (_ blob: UnsafeMutableRawPointer?) -> Void

    /// Binds raw blob bytes with a custom destructor.
    /// - Parameters:
    ///   - blob: Pointer to the blob bytes.
    ///   - length: Number of bytes to bind.
    ///   - index: 1-based parameter index.
    ///   - destructor: Callback invoked when the bytes can be released.
    /// - Returns: Result code from binding.
    ///
    /// Related SQLite: `sqlite3_bind_blob`, `SQLITE_STATIC`, `SQLITE_TRANSIENT`
    @inlinable public func bindBlob(_ blob: UnsafeRawPointer, length: Int32, at index: Int32, destructor: BindBlobDestructor) -> ResultCode {
        sqlite3_bind_blob(rawValue, index, blob, length, destructor).resultCode
    }

    /// Binds blob bytes by copying them immediately.
    /// - Parameters:
    ///   - blob: Pointer to the blob bytes.
    ///   - length: Number of bytes to bind.
    ///   - index: 1-based parameter index.
    /// - Returns: Result code from binding.
    ///
    /// Related SQLite: `sqlite3_bind_blob`, `SQLITE_TRANSIENT`
    @inlinable public func bindTransientBlob(_ blob: UnsafeRawPointer, length: Int32, at index: Int32) -> ResultCode {
        lsqlite3_bind_transient_blob(rawValue, index, blob, length).resultCode
    }

    /// Binds blob bytes that remain valid for the statement lifetime.
    /// - Parameters:
    ///   - blob: Pointer to the blob bytes.
    ///   - length: Number of bytes to bind.
    ///   - index: 1-based parameter index.
    /// - Returns: Result code from binding.
    ///
    /// Related SQLite: `sqlite3_bind_blob`, `SQLITE_STATIC`
    @inlinable public func bindStaticBlob(_ blob: UnsafeRawPointer, length: Int32, at index: Int32) -> ResultCode {
        lsqlite3_bind_static_blob(rawValue, index, blob, length).resultCode
    }

    /// Binds a Double value.
    /// - Parameters:
    ///   - double: Value to bind.
    ///   - index: 1-based parameter index.
    /// - Returns: Result code from binding.
    ///
    /// Related SQLite: `sqlite3_bind_double`
    @inlinable public func bindDouble(_ double: Double, at index: Int32) -> ResultCode {
        sqlite3_bind_double(rawValue, index, double).resultCode
    }

    /// Binds a 32-bit integer value.
    /// - Parameters:
    ///   - int: Value to bind.
    ///   - index: 1-based parameter index.
    /// - Returns: Result code from binding.
    ///
    /// Related SQLite: `sqlite3_bind_int`
    @inlinable public func bindInt(_ int: Int32, at index: Int32) -> ResultCode {
        sqlite3_bind_int(rawValue, index, int).resultCode
    }

    /// Binds a 64-bit integer value.
    /// - Parameters:
    ///   - int: Value to bind.
    ///   - index: 1-based parameter index.
    /// - Returns: Result code from binding.
    ///
    /// Related SQLite: `sqlite3_bind_int64`
    @inlinable public func bindInt64(_ int: Int64, at index: Int32) -> ResultCode {
        sqlite3_bind_int64(rawValue, index, int).resultCode
    }

    /// Binds a NULL value.
    /// - Parameter index: 1-based parameter index.
    /// - Returns: Result code from binding.
    ///
    /// Related SQLite: `sqlite3_bind_null`
    @inlinable public func bindNull(at index: Int32) -> ResultCode {
        sqlite3_bind_null(rawValue, index).resultCode
    }

    /// Binds UTF-8 text by copying it immediately.
    /// - Parameters:
    ///   - text: Text to bind.
    ///   - index: 1-based parameter index.
    /// - Returns: Result code from binding.
    ///
    /// The text is bound using a NUL-terminated UTF-8 representation, so
    /// embedded NULs are not preserved.
    ///
    /// Related SQLite: `sqlite3_bind_text`, `SQLITE_TRANSIENT`
    @inlinable public func bindText(_ text: String, at index: Int32) -> ResultCode {
        sqlite3_bind_transient_text(rawValue, index, text, -1).resultCode
    }

    /// Binds a zero-filled BLOB of the given length.
    /// - Parameters:
    ///   - length: Number of bytes in the zero-filled BLOB.
    ///   - index: 1-based parameter index.
    /// - Returns: Result code from binding.
    ///
    /// A negative length results in a zero-length BLOB.
    ///
    /// Related SQLite: `sqlite3_bind_zeroblob`
    @inlinable public func bindZeroBlob(length: Int32, at index: Int32) -> ResultCode {
        sqlite3_bind_zeroblob(rawValue, index, length).resultCode
    }

    /// Largest parameter index used by the statement.
    /// - Returns: The maximum 1-based parameter index, or 0 if none exist.
    ///
    /// Numbered parameters can create gaps, so this is not necessarily the
    /// count of unique parameters.
    ///
    /// Related SQLite: `sqlite3_bind_parameter_count`
    @inlinable public var bindingCount: Int32 {
        sqlite3_bind_parameter_count(rawValue)
    }

    /// Returns the parameter name for a 1-based index.
    /// - Parameter index: 1-based parameter index.
    /// - Returns: The parameter name including its prefix, or nil if the
    ///   parameter is positional or out of range.
    ///
    /// Related SQLite: `sqlite3_bind_parameter_name`
    @inlinable public func bindingName(at index: Int32) -> String? {
        let cString = sqlite3_bind_parameter_name(rawValue, index)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        guard !string.isEmpty else {
            return nil
        }
        return string
    }

    /// Returns the 1-based index for a named parameter.
    /// - Parameter name: Parameter name as it appears in SQL, including its prefix.
    /// - Returns: The 1-based index, or 0 if not found.
    ///
    /// Related SQLite: `sqlite3_bind_parameter_index`
    @inlinable public func bindingIndex(with name: String) -> Int32 {
        sqlite3_bind_parameter_index(rawValue, name)
    }

    /// Resets all bound parameters on the statement back to NULL.
    /// - Returns: Result code from clearing bindings.
    ///
    /// Related SQLite: `sqlite3_clear_bindings`
    @inlinable public func clearBindings() -> ResultCode {
        sqlite3_clear_bindings(rawValue).resultCode
    }
}
