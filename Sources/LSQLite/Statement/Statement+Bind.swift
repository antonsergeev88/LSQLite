import MissedSwiftSQLite

extension Statement {
    /// Destructor invoked when SQLite frees a bound blob buffer.
    ///
    /// Related SQLite: `sqlite3_bind_blob`, `SQLITE_STATIC`, `SQLITE_TRANSIENT`
    public typealias BindBlobDestructor = @convention(c) (_ blob: UnsafeMutableRawPointer?) -> Void

    /// Binds raw blob data to the 1-based parameter index with a destructor.
    ///
    /// Related SQLite: `sqlite3_bind_blob`, `SQLITE_STATIC`, `SQLITE_TRANSIENT`
    @inlinable public func bindBlob(_ blob: UnsafeRawPointer, length: Int32, at index: Int32, destructor: BindBlobDestructor) -> ResultCode {
        sqlite3_bind_blob(rawValue, index, blob, length, destructor).resultCode
    }

    /// Binds blob data by copying it immediately (transient) to the parameter index.
    ///
    /// Related SQLite: `sqlite3_bind_blob`, `SQLITE_TRANSIENT`
    @inlinable public func bindTransientBlob(_ blob: UnsafeRawPointer, length: Int32, at index: Int32) -> ResultCode {
        lsqlite3_bind_transient_blob(rawValue, index, blob, length).resultCode
    }

    /// Binds blob data that remains valid for the statement lifetime (static) to the parameter index.
    ///
    /// Related SQLite: `sqlite3_bind_blob`, `SQLITE_STATIC`
    @inlinable public func bindStaticBlob(_ blob: UnsafeRawPointer, length: Int32, at index: Int32) -> ResultCode {
        lsqlite3_bind_static_blob(rawValue, index, blob, length).resultCode
    }

    /// Binds a Double value to the parameter index.
    ///
    /// Related SQLite: `sqlite3_bind_double`
    @inlinable public func bindDouble(_ double: Double, at index: Int32) -> ResultCode {
        sqlite3_bind_double(rawValue, index, double).resultCode
    }

    /// Binds a 32-bit integer to the parameter index.
    ///
    /// Related SQLite: `sqlite3_bind_int`
    @inlinable public func bindInt(_ int: Int32, at index: Int32) -> ResultCode {
        sqlite3_bind_int(rawValue, index, int).resultCode
    }

    /// Binds a 64-bit integer to the parameter index.
    ///
    /// Related SQLite: `sqlite3_bind_int64`
    @inlinable public func bindInt64(_ int: Int64, at index: Int32) -> ResultCode {
        sqlite3_bind_int64(rawValue, index, int).resultCode
    }

    /// Binds a NULL value to the parameter index.
    ///
    /// Related SQLite: `sqlite3_bind_null`
    @inlinable public func bindNull(at index: Int32) -> ResultCode {
        sqlite3_bind_null(rawValue, index).resultCode
    }

    /// Binds UTF-8 text by copying it immediately (transient) to the parameter index.
    ///
    /// Related SQLite: `sqlite3_bind_text`, `SQLITE_TRANSIENT`
    @inlinable public func bindText(_ text: String, at index: Int32) -> ResultCode {
        sqlite3_bind_transient_text(rawValue, index, text, -1).resultCode
    }

    /// Binds a zero-filled BLOB of the given length to the parameter index.
    ///
    /// Related SQLite: `sqlite3_bind_zeroblob`
    @inlinable public func bindZeroBlob(length: Int32, at index: Int32) -> ResultCode {
        sqlite3_bind_zeroblob(rawValue, index, length).resultCode
    }

    /// Number of parameters expected by this prepared statement.
    ///
    /// Related SQLite: `sqlite3_bind_parameter_count`
    @inlinable public var bindingCount: Int32 {
        sqlite3_bind_parameter_count(rawValue)
    }

    /// Returns the parameter name for a 1-based index, or nil if positional.
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

    /// Returns the 1-based index for a named parameter, or 0 if not found.
    ///
    /// Related SQLite: `sqlite3_bind_parameter_index`
    @inlinable public func bindingIndex(with name: String) -> Int32 {
        sqlite3_bind_parameter_index(rawValue, name)
    }

    /// Resets all bound parameters on the statement back to NULL.
    ///
    /// Related SQLite: `sqlite3_clear_bindings`
    @inlinable public func clearBindings() -> ResultCode {
        sqlite3_clear_bindings(rawValue).resultCode
    }
}
