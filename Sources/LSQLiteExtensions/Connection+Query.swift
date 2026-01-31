import LSQLite

extension Connection {
    /// Prepares and evaluates the first statement in the SQL string once.
    /// - Parameter sql: SQL text to prepare.
    /// - Returns: Result code from preparing or stepping the statement, or `.misuse` when a row is produced.
    ///
    /// Only the first statement is executed; remaining SQL text is ignored. The prepared statement is finalized before returning.
    ///
    /// Related SQLite: `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_reset`, `sqlite3_finalize`
    public func query(_ sql: String) -> ResultCode {
        var statement: Statement?
        let prepareResult = Statement.prepare(&statement, sql: sql, for: self)
        guard let prepared = statement else {
            return prepareResult
        }
        defer { _ = prepared.finalize() }
        guard prepareResult == .ok else {
            return prepareResult
        }
        return prepared.query()
    }

    /// Prepares, binds, and evaluates the first statement in the SQL string once.
    /// - Parameters:
    ///   - sql: SQL text to prepare.
    ///   - binding: Value to encode and bind.
    /// - Returns: Result code from preparing or stepping the statement, or `.misuse` when binding fails or a row is produced.
    ///
    /// Only the first statement is executed; remaining SQL text is ignored. The prepared statement is finalized before returning.
    ///
    /// Related SQLite: `sqlite3_prepare_v2`, `sqlite3_bind_parameter_count`, `sqlite3_bind_parameter_name`, `sqlite3_bind_blob`, `sqlite3_bind_text`, `sqlite3_bind_int64`, `sqlite3_bind_double`, `sqlite3_bind_null`, `sqlite3_bind_zeroblob`, `sqlite3_step`, `sqlite3_reset`, `sqlite3_clear_bindings`, `sqlite3_finalize`
    public func query<Binding: Encodable>(_ sql: String, binding: Binding) -> ResultCode {
        var statement: Statement?
        let prepareResult = Statement.prepare(&statement, sql: sql, for: self)
        guard let prepared = statement else {
            return prepareResult
        }
        defer { _ = prepared.finalize() }
        guard prepareResult == .ok else {
            return prepareResult
        }
        return prepared.query(binding)
    }

    /// Prepares, evaluates, and decodes at most one row from the first statement in the SQL string.
    /// - Parameters:
    ///   - sql: SQL text to prepare.
    ///   - type: Row type to decode.
    /// - Returns: A result code and the decoded row when present.
    ///
    /// Only the first statement is executed; remaining SQL text is ignored. The prepared statement is finalized before returning.
    /// Returns `.misuse` when decoding fails or when more than one row is produced.
    ///
    /// Related SQLite: `sqlite3_prepare_v2`, `sqlite3_column_count`, `sqlite3_column_name`, `sqlite3_column_blob`, `sqlite3_column_bytes`, `sqlite3_column_text`, `sqlite3_column_int64`, `sqlite3_column_double`, `sqlite3_column_type`, `sqlite3_step`, `sqlite3_reset`, `sqlite3_finalize`
    public func query<Row: Decodable>(_ sql: String, row type: Row.Type = Row.self) -> (ResultCode, Row?) {
        var statement: Statement?
        let prepareResult = Statement.prepare(&statement, sql: sql, for: self)
        guard let prepared = statement else {
            return (prepareResult, nil)
        }
        defer { _ = prepared.finalize() }
        guard prepareResult == .ok else {
            return (prepareResult, nil)
        }
        return prepared.query(row: type)
    }

    /// Prepares, evaluates, and decodes all rows from the first statement in the SQL string.
    /// - Parameters:
    ///   - sql: SQL text to prepare.
    ///   - type: Row type to decode.
    /// - Returns: A result code and the decoded rows.
    ///
    /// Only the first statement is executed; remaining SQL text is ignored. The prepared statement is finalized before returning.
    /// Returns `.misuse` when decoding fails.
    ///
    /// Related SQLite: `sqlite3_prepare_v2`, `sqlite3_column_count`, `sqlite3_column_name`, `sqlite3_column_blob`, `sqlite3_column_bytes`, `sqlite3_column_text`, `sqlite3_column_int64`, `sqlite3_column_double`, `sqlite3_column_type`, `sqlite3_step`, `sqlite3_reset`, `sqlite3_finalize`
    public func query<Row: Decodable>(_ sql: String, rows type: Row.Type = Row.self) -> (ResultCode, [Row]) {
        var statement: Statement?
        let prepareResult = Statement.prepare(&statement, sql: sql, for: self)
        guard let prepared = statement else {
            return (prepareResult, [])
        }
        defer { _ = prepared.finalize() }
        guard prepareResult == .ok else {
            return (prepareResult, [])
        }
        return prepared.query(rows: type)
    }

    /// Prepares, binds, evaluates, and decodes at most one row from the first statement in the SQL string.
    /// - Parameters:
    ///   - sql: SQL text to prepare.
    ///   - binding: Value to encode and bind.
    ///   - type: Row type to decode.
    /// - Returns: A result code and the decoded row when present.
    ///
    /// Only the first statement is executed; remaining SQL text is ignored. The prepared statement is finalized before returning.
    /// Returns `.misuse` when binding or decoding fails, or when more than one row is produced.
    ///
    /// Related SQLite: `sqlite3_prepare_v2`, `sqlite3_bind_parameter_count`, `sqlite3_bind_parameter_name`, `sqlite3_bind_blob`, `sqlite3_bind_text`, `sqlite3_bind_int64`, `sqlite3_bind_double`, `sqlite3_bind_null`, `sqlite3_bind_zeroblob`, `sqlite3_column_count`, `sqlite3_column_name`, `sqlite3_column_blob`, `sqlite3_column_bytes`, `sqlite3_column_text`, `sqlite3_column_int64`, `sqlite3_column_double`, `sqlite3_column_type`, `sqlite3_step`, `sqlite3_reset`, `sqlite3_clear_bindings`, `sqlite3_finalize`
    public func query<Binding: Encodable, Row: Decodable>(_ sql: String, binding: Binding, row type: Row.Type = Row.self) -> (ResultCode, Row?) {
        var statement: Statement?
        let prepareResult = Statement.prepare(&statement, sql: sql, for: self)
        guard let prepared = statement else {
            return (prepareResult, nil)
        }
        defer { _ = prepared.finalize() }
        guard prepareResult == .ok else {
            return (prepareResult, nil)
        }
        return prepared.query(binding, row: type)
    }

    /// Prepares, binds, evaluates, and decodes all rows from the first statement in the SQL string.
    /// - Parameters:
    ///   - sql: SQL text to prepare.
    ///   - binding: Value to encode and bind.
    ///   - type: Row type to decode.
    /// - Returns: A result code and the decoded rows.
    ///
    /// Only the first statement is executed; remaining SQL text is ignored. The prepared statement is finalized before returning.
    /// Returns `.misuse` when binding or decoding fails.
    ///
    /// Related SQLite: `sqlite3_prepare_v2`, `sqlite3_bind_parameter_count`, `sqlite3_bind_parameter_name`, `sqlite3_bind_blob`, `sqlite3_bind_text`, `sqlite3_bind_int64`, `sqlite3_bind_double`, `sqlite3_bind_null`, `sqlite3_bind_zeroblob`, `sqlite3_column_count`, `sqlite3_column_name`, `sqlite3_column_blob`, `sqlite3_column_bytes`, `sqlite3_column_text`, `sqlite3_column_int64`, `sqlite3_column_double`, `sqlite3_column_type`, `sqlite3_step`, `sqlite3_reset`, `sqlite3_clear_bindings`, `sqlite3_finalize`
    public func query<Binding: Encodable, Row: Decodable>(_ sql: String, binding: Binding, rows type: Row.Type = Row.self) -> (ResultCode, [Row]) {
        var statement: Statement?
        let prepareResult = Statement.prepare(&statement, sql: sql, for: self)
        guard let prepared = statement else {
            return (prepareResult, [])
        }
        defer { _ = prepared.finalize() }
        guard prepareResult == .ok else {
            return (prepareResult, [])
        }
        return prepared.query(binding, rows: type)
    }
}
