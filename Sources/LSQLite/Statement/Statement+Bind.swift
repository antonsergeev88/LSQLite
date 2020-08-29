import SQLite3
import MissedSwiftSQLite

extension Statement {
    public typealias BindDestructor = @convention(c) (_ context: UnsafeMutableRawPointer?) -> Void

    @inlinable public func bindBlob(_ blob: UnsafeRawPointer, length: Int32, at index: Int32, destructor: BindDestructor? = nil) -> ResultCode {
        sqlite3_bind_blob(rawValue, index, blob, length, destructor).resultCode
    }

    @inlinable public func bindTransientBlob(_ blob: UnsafeRawPointer, length: Int32, at index: Int32) -> ResultCode {
        lsqlite3_bind_transient_blob(rawValue, index, blob, length).resultCode
    }

    @inlinable public func bindStaticBlob(_ blob: UnsafeRawPointer, length: Int32, at index: Int32) -> ResultCode {
        lsqlite3_bind_static_blob(rawValue, index, blob, length).resultCode
    }

    @inlinable public func bindDouble(_ double: Double, at index: Int32) -> ResultCode {
        sqlite3_bind_double(rawValue, index, double).resultCode
    }

    @inlinable public func bindInt(_ int: Int32, at index: Int32) -> ResultCode {
        sqlite3_bind_int(rawValue, index, int).resultCode
    }

    @inlinable public func bindInt64(_ int: sqlite3_int64, at index: Int32) -> ResultCode {
        sqlite3_bind_int64(rawValue, index, int).resultCode
    }

    @inlinable public func bindNull(at index: Int32) -> ResultCode {
        sqlite3_bind_null(rawValue, index).resultCode
    }

    @inlinable public func bindText(_ text: UnsafePointer<Int8>?, length: Int32 = -1, at index: Int32, destructor: BindDestructor? = nil) -> ResultCode {
        sqlite3_bind_text(rawValue, index, text, length, destructor).resultCode
    }

    @inlinable public func bindTransientText(_ text: UnsafePointer<Int8>?, length: Int32 = -1, at index: Int32) -> ResultCode {
        sqlite3_bind_transient_text(rawValue, index, text, length).resultCode
    }

    @inlinable public func bindStaticText(_ text: UnsafePointer<Int8>?, length: Int32 = -1, at index: Int32) -> ResultCode {
        sqlite3_bind_static_text(rawValue, index, text, length).resultCode
    }

    @inlinable public func bindZeroBlob(length: Int32, at index: Int32) -> ResultCode {
        sqlite3_bind_zeroblob(rawValue, index, length).resultCode
    }

    @inlinable public var bindingCount: Int32 {
        sqlite3_bind_parameter_count(rawValue)
    }

    @inlinable public func bindingName(at index: Int32) -> UnsafePointer<Int8>? {
        sqlite3_bind_parameter_name(rawValue, index)
    }

    @inlinable public func bindingIndex(with name: UnsafePointer<Int8>) -> Int32 {
        sqlite3_bind_parameter_index(rawValue, name)
    }

    @inlinable public func clearBindings() -> ResultCode {
        sqlite3_clear_bindings(rawValue).resultCode
    }
}
