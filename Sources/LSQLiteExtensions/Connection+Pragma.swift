import LSQLite

extension Connection {
    /// Reads the user version value.
    /// - Parameter databaseName: Optional database name qualifier.
    /// - Returns: A result code and the current value when available.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not an integer.
    ///
    /// Related SQLite: `PRAGMA user_version`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_int`, `sqlite3_column_type`, `sqlite3_finalize`
    public func userVersion(databaseName: String? = nil) -> (ResultCode, Int32?) {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).user_version"
        } else {
            sql = "PRAGMA user_version"
        }
        return pragmaInt32(sql)
    }

    /// Sets the user version value.
    /// - Parameters:
    ///   - value: Value to store.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: Result code from stepping the pragma statement.
    ///
    /// Returns `.misuse` when a row is produced.
    ///
    /// Related SQLite: `PRAGMA user_version`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_finalize`
    public func setUserVersion(_ value: Int32, databaseName: String? = nil) -> ResultCode {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).user_version = \(value)"
        } else {
            sql = "PRAGMA user_version = \(value)"
        }
        return pragmaNoRow(sql)
    }

    /// Reads the application identifier value.
    /// - Parameter databaseName: Optional database name qualifier.
    /// - Returns: A result code and the current value when available.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not an integer.
    ///
    /// Related SQLite: `PRAGMA application_id`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_int`, `sqlite3_column_type`, `sqlite3_finalize`
    public func applicationId(databaseName: String? = nil) -> (ResultCode, Int32?) {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).application_id"
        } else {
            sql = "PRAGMA application_id"
        }
        return pragmaInt32(sql)
    }

    /// Sets the application identifier value.
    /// - Parameters:
    ///   - value: Value to store.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: Result code from stepping the pragma statement.
    ///
    /// Returns `.misuse` when a row is produced.
    ///
    /// Related SQLite: `PRAGMA application_id`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_finalize`
    public func setApplicationId(_ value: Int32, databaseName: String? = nil) -> ResultCode {
        let sql: String
        if let databaseName {
            sql = "PRAGMA \(quotedIdentifier(databaseName)).application_id = \(value)"
        } else {
            sql = "PRAGMA application_id = \(value)"
        }
        return pragmaNoRow(sql)
    }

    /// Reads whether foreign key enforcement is enabled.
    /// - Returns: A result code and the current enabled state when available.
    ///
    /// Returns `.misuse` when no row is produced, when more than one row is produced, or when the value is not an integer.
    ///
    /// Related SQLite: `PRAGMA foreign_keys`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_int`, `sqlite3_column_type`, `sqlite3_finalize`
    public func foreignKeysEnabled() -> (ResultCode, Bool?) {
        let result = pragmaInt32("PRAGMA foreign_keys")
        return (result.0, result.1.map { $0 != 0 })
    }

    /// Enables or disables foreign key enforcement.
    /// - Parameter enabled: Whether to enable enforcement.
    /// - Returns: Result code from stepping the pragma statement.
    ///
    /// Returns `.misuse` when a row is produced.
    ///
    /// Related SQLite: `PRAGMA foreign_keys`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_finalize`
    public func setForeignKeysEnabled(_ enabled: Bool) -> ResultCode {
        let value = enabled ? 1 : 0
        return pragmaNoRow("PRAGMA foreign_keys = \(value)")
    }
}

private extension Connection {
    func pragmaNoRow(_ sql: String) -> ResultCode {
        var statement: Statement?
        let prepareResult = Statement.prepare(&statement, sql: sql, for: self)
        guard let prepared = statement else {
            return prepareResult
        }
        defer { _ = prepared.finalize() }
        guard prepareResult == .ok else {
            return prepareResult
        }
        let stepResult = prepared.step()
        guard stepResult != .row else {
            return .misuse
        }
        return stepResult
    }

    func pragmaInt32(_ sql: String) -> (ResultCode, Int32?) {
        pragmaScalar(sql) { statement in
            guard statement.columnType(at: 0) == .integer else {
                return nil
            }
            return statement.columnInt(at: 0)
        }
    }

    func pragmaScalar<T>(_ sql: String, decode: (Statement) -> T?) -> (ResultCode, T?) {
        var statement: Statement?
        let prepareResult = Statement.prepare(&statement, sql: sql, for: self)
        guard let prepared = statement else {
            return (prepareResult, nil)
        }
        defer { _ = prepared.finalize() }
        guard prepareResult == .ok else {
            return (prepareResult, nil)
        }
        let firstStep = prepared.step()
        switch firstStep {
        case .row:
            guard let value = decode(prepared) else {
                return (.misuse, nil)
            }
            let secondStep = prepared.step()
            switch secondStep {
            case .done:
                return (.done, value)
            case .row:
                return (.misuse, nil)
            default:
                return (secondStep, nil)
            }
        case .done:
            return (.misuse, nil)
        default:
            return (firstStep, nil)
        }
    }
}

private func quotedIdentifier(_ rawValue: String) -> String {
    let escaped = rawValue.replacingOccurrences(of: "\"", with: "\"\"")
    return "\"\(escaped)\""
}
