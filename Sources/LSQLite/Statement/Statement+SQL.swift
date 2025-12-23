import MissedSwiftSQLite

extension Statement {
    /// Original SQL text used to create the statement.
    ///
    /// Related SQLite: `sqlite3_sql`
    @inlinable public var sql: String? {
        let cString = sqlite3_sql(rawValue)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        guard !string.isEmpty else {
            return nil
        }
        return string
    }

    /// SQL text with bound parameters expanded.
    ///
    /// Related SQLite: `sqlite3_expanded_sql`, `sqlite3_free`
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    @inlinable public var expandedSql: String? {
        let cString = sqlite3_expanded_sql(rawValue)
        defer {
            sqlite3_free(cString)
        }
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        guard !string.isEmpty else {
            return nil
        }
        return string
    }

    /// SQL text with bound parameters expanded.
    ///
    /// Related SQLite: `sqlite3_normalized_sql`
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    @inlinable public var normalizedSql: String? {
        let cString = sqlite3_normalized_sql(rawValue)
        guard let cString else {
            return nil
        }
        let string = String(cString: cString)
        guard !string.isEmpty else {
            return nil
        }
        return string
    }
}
