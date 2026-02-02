import LSQLite

extension Statement {
    /// Evaluates the prepared statement once and returns the result code.
    /// - Returns: Result code from stepping the statement, or `.misuse` when a row is produced.
    ///
    /// The statement is reset before returning.
    ///
    /// Related SQLite: `sqlite3_step`, `sqlite3_reset`
    public func query() -> ResultCode {
        withStatementCleanup(self, clearBindings: false) {
            StatementQueryRunner(statement: self).runNoRow()
        }
    }

    /// Binds a value and evaluates the prepared statement once.
    /// - Parameter binding: Value to encode and bind.
    /// - Returns: Result code from stepping the statement, or `.misuse` when binding fails or a row is produced.
    ///
    /// The statement is reset before returning and bindings are cleared.
    ///
    /// Related SQLite: `sqlite3_bind_parameter_count`, `sqlite3_bind_parameter_name`, `sqlite3_bind_blob`, `sqlite3_bind_text`, `sqlite3_bind_int64`, `sqlite3_bind_double`, `sqlite3_bind_null`, `sqlite3_bind_zeroblob`, `sqlite3_step`, `sqlite3_reset`, `sqlite3_clear_bindings`
    public func query<Binding: Encodable>(_ binding: Binding) -> ResultCode {
        withStatementCleanup(self, clearBindings: true) {
            guard bind(binding) else {
                return .misuse
            }
            return StatementQueryRunner(statement: self).runNoRow()
        }
    }

    /// Evaluates the statement and decodes at most one row.
    /// - Parameter type: Row type to decode.
    /// - Returns: A result code and the decoded row when present.
    ///
    /// The statement is reset before returning. Returns `.misuse` when decoding fails or when more than one row is produced.
    ///
    /// Related SQLite: `sqlite3_column_count`, `sqlite3_column_name`, `sqlite3_column_blob`, `sqlite3_column_bytes`, `sqlite3_column_text`, `sqlite3_column_int64`, `sqlite3_column_double`, `sqlite3_column_type`, `sqlite3_step`, `sqlite3_reset`
    public func query<Row: Decodable>(row type: Row.Type = Row.self) -> (ResultCode, Row?) {
        withStatementCleanup(self, clearBindings: false) {
            StatementQueryRunner(statement: self).runSingle(type)
        }
    }

    /// Evaluates the statement and decodes all rows.
    /// - Parameter type: Row type to decode.
    /// - Returns: A result code and the decoded rows.
    ///
    /// The statement is reset before returning. Returns `.misuse` when decoding fails.
    ///
    /// Related SQLite: `sqlite3_column_count`, `sqlite3_column_name`, `sqlite3_column_blob`, `sqlite3_column_bytes`, `sqlite3_column_text`, `sqlite3_column_int64`, `sqlite3_column_double`, `sqlite3_column_type`, `sqlite3_step`, `sqlite3_reset`
    public func query<Row: Decodable>(rows type: Row.Type = Row.self) -> (ResultCode, [Row]) {
        withStatementCleanup(self, clearBindings: false) {
            StatementQueryRunner(statement: self).runMany(type)
        }
    }

    /// Binds a value, evaluates the statement, and decodes at most one row.
    /// - Parameters:
    ///   - binding: Value to encode and bind.
    ///   - type: Row type to decode.
    /// - Returns: A result code and the decoded row when present.
    ///
    /// The statement is reset before returning and bindings are cleared. Returns `.misuse` when binding or decoding fails, or when more than one row is produced.
    ///
    /// Related SQLite: `sqlite3_bind_parameter_count`, `sqlite3_bind_parameter_name`, `sqlite3_bind_blob`, `sqlite3_bind_text`, `sqlite3_bind_int64`, `sqlite3_bind_double`, `sqlite3_bind_null`, `sqlite3_bind_zeroblob`, `sqlite3_column_count`, `sqlite3_column_name`, `sqlite3_column_blob`, `sqlite3_column_bytes`, `sqlite3_column_text`, `sqlite3_column_int64`, `sqlite3_column_double`, `sqlite3_column_type`, `sqlite3_step`, `sqlite3_reset`, `sqlite3_clear_bindings`
    public func query<Binding: Encodable, Row: Decodable>(_ binding: Binding, row type: Row.Type = Row.self) -> (ResultCode, Row?) {
        withStatementCleanup(self, clearBindings: true) {
            guard bind(binding) else {
                return (.misuse, nil)
            }
            return StatementQueryRunner(statement: self).runSingle(type)
        }
    }

    /// Binds a value, evaluates the statement, and decodes all rows.
    /// - Parameters:
    ///   - binding: Value to encode and bind.
    ///   - type: Row type to decode.
    /// - Returns: A result code and the decoded rows.
    ///
    /// The statement is reset before returning and bindings are cleared. Returns `.misuse` when binding or decoding fails.
    ///
    /// Related SQLite: `sqlite3_bind_parameter_count`, `sqlite3_bind_parameter_name`, `sqlite3_bind_blob`, `sqlite3_bind_text`, `sqlite3_bind_int64`, `sqlite3_bind_double`, `sqlite3_bind_null`, `sqlite3_bind_zeroblob`, `sqlite3_column_count`, `sqlite3_column_name`, `sqlite3_column_blob`, `sqlite3_column_bytes`, `sqlite3_column_text`, `sqlite3_column_int64`, `sqlite3_column_double`, `sqlite3_column_type`, `sqlite3_step`, `sqlite3_reset`, `sqlite3_clear_bindings`
    public func query<Binding: Encodable, Row: Decodable>(_ binding: Binding, rows type: Row.Type = Row.self) -> (ResultCode, [Row]) {
        withStatementCleanup(self, clearBindings: true) {
            guard bind(binding) else {
                return (.misuse, [])
            }
            return StatementQueryRunner(statement: self).runMany(type)
        }
    }
}

private func withStatementCleanup<T>(_ statement: Statement, clearBindings: Bool, _ body: () -> T) -> T {
    defer {
        _ = statement.reset()
        if clearBindings {
            _ = statement.clearBindings()
        }
    }
    return body()
}

private struct StatementQueryRunner {
    let statement: Statement

    func runNoRow() -> ResultCode {
        let result = statement.step()
        guard result != .row else {
            return .misuse
        }
        return result
    }

    func runSingle<Row: Decodable>(_ type: Row.Type) -> (ResultCode, Row?) {
        let firstStep = statement.step()
        switch firstStep {
        case .done:
            return (.done, nil)
        case .row:
            guard let columnMap = buildColumnMap() else {
                return (.misuse, nil)
            }
            guard let row = decodeRow(type, columnMap: columnMap) else {
                return (.misuse, nil)
            }
            let secondStep = statement.step()
            switch secondStep {
            case .done:
                return (.done, row)
            case .row:
                return (.misuse, nil)
            default:
                return (secondStep, nil)
            }
        default:
            return (firstStep, nil)
        }
    }

    func runMany<Row: Decodable>(_ type: Row.Type) -> (ResultCode, [Row]) {
        var rows: [Row] = []
        var columnMap: StatementColumnMap?
        while true {
            let stepResult = statement.step()
            switch stepResult {
            case .row:
                if columnMap == nil {
                    columnMap = buildColumnMap()
                }
                guard let map = columnMap else {
                    return (.misuse, [])
                }
                guard let row = decodeRow(type, columnMap: map) else {
                    return (.misuse, [])
                }
                rows.append(row)
            case .done:
                return (.done, rows)
            default:
                return (stepResult, [])
            }
        }
    }

    private func buildColumnMap() -> StatementColumnMap? {
        do {
            return try statementColumnMap(for: statement)
        } catch {
            return nil
        }
    }

    private func decodeRow<Row: Decodable>(_ type: Row.Type, columnMap: StatementColumnMap) -> Row? {
        do {
            let decoder = StatementRowDecoder(statement: statement, columnMap: columnMap)
            let value = try Row(from: decoder)
            if decoder.failure != nil {
                return nil
            }
            if decoder.decodedColumnCount != decoder.columnCount {
                return nil
            }
            return value
        } catch {
            return nil
        }
    }
}
