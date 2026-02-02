import LSQLite

extension Connection {
    /// Schema tables that store object definitions.
    ///
    /// Related SQLite: `sqlite_schema`, `sqlite_master`
    @frozen public struct SchemaTable: Hashable, RawRepresentable {
        public let rawValue: String

        @inlinable public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Schema table used for the primary schema storage.
        ///
        /// Related SQLite: `sqlite_schema`
        public static let schema = Self(rawValue: "sqlite_schema")

        /// Legacy schema table used for the primary schema storage.
        ///
        /// Related SQLite: `sqlite_master`
        public static let master = Self(rawValue: "sqlite_master")
    }

    /// Schema object type values stored in the schema table.
    ///
    /// Related SQLite: `sqlite_schema`, `sqlite_master`
    @frozen public struct SchemaObjectType: Hashable, RawRepresentable {
        public let rawValue: String

        @inlinable public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Table entries stored in the schema table.
        ///
        /// Related SQLite: `sqlite_schema`, `sqlite_master`
        public static let table = Self(rawValue: "table")

        /// View entries stored in the schema table.
        ///
        /// Related SQLite: `sqlite_schema`, `sqlite_master`
        public static let view = Self(rawValue: "view")

        /// Index entries stored in the schema table.
        ///
        /// Related SQLite: `sqlite_schema`, `sqlite_master`
        public static let index = Self(rawValue: "index")

        /// Trigger entries stored in the schema table.
        ///
        /// Related SQLite: `sqlite_schema`, `sqlite_master`
        public static let trigger = Self(rawValue: "trigger")
    }

    /// Row describing an entry in the schema table.
    ///
    /// Related SQLite: `sqlite_schema`, `sqlite_master`
    @frozen public struct SchemaObject: Hashable, Decodable {
        /// The object type stored in the schema table.
        public let type: String
        /// The object name stored in the schema table.
        public let name: String
        /// The table name associated with the object.
        public let tableName: String
        /// The root page number assigned to the object.
        public let rootPage: Int
        /// The SQL used to create the object when available.
        public let sql: String?

        private enum CodingKeys: String, CodingKey {
            case type
            case name
            case tableName = "tbl_name"
            case rootPage = "rootpage"
            case sql
        }
    }

    /// Reads schema entries from the selected schema table.
    /// - Parameters:
    ///   - table: Schema table to read.
    ///   - databaseName: Optional database name qualifier.
    ///   - includeInternal: Whether to include internal entries.
    /// - Returns: A result code and the returned rows.
    ///
    /// Related SQLite: `sqlite_schema`, `sqlite_master`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_name`, `sqlite3_column_int64`, `sqlite3_column_text`, `sqlite3_finalize`
    public func schemaObjects(in table: SchemaTable = .master, databaseName: String? = nil, includeInternal: Bool = true) -> (ResultCode, [SchemaObject]) {
        schemaObjects(of: [], in: table, databaseName: databaseName, includeInternal: includeInternal)
    }

    /// Reads schema entries for a specific type from the selected schema table.
    /// - Parameters:
    ///   - type: Object type to include.
    ///   - table: Schema table to read.
    ///   - databaseName: Optional database name qualifier.
    ///   - includeInternal: Whether to include internal entries.
    /// - Returns: A result code and the returned rows.
    ///
    /// Related SQLite: `sqlite_schema`, `sqlite_master`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_name`, `sqlite3_column_int64`, `sqlite3_column_text`, `sqlite3_finalize`
    public func schemaObjects(of type: SchemaObjectType, in table: SchemaTable = .master, databaseName: String? = nil, includeInternal: Bool = false) -> (ResultCode, [SchemaObject]) {
        schemaObjects(of: [type], in: table, databaseName: databaseName, includeInternal: includeInternal)
    }

    /// Reads schema entries for specific types from the selected schema table.
    /// - Parameters:
    ///   - types: Object types to include.
    ///   - table: Schema table to read.
    ///   - databaseName: Optional database name qualifier.
    ///   - includeInternal: Whether to include internal entries.
    /// - Returns: A result code and the returned rows.
    ///
    /// Related SQLite: `sqlite_schema`, `sqlite_master`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_name`, `sqlite3_column_int64`, `sqlite3_column_text`, `sqlite3_finalize`
    public func schemaObjects(of types: [SchemaObjectType], in table: SchemaTable = .master, databaseName: String? = nil, includeInternal: Bool = false) -> (ResultCode, [SchemaObject]) {
        let sql = schemaSelectSQL(table: table, databaseName: databaseName, types: types, includeInternal: includeInternal)
        return query(sql, rows: SchemaObject.self)
    }

    /// Reads table entries from the schema table.
    /// - Parameters:
    ///   - table: Schema table to read.
    ///   - databaseName: Optional database name qualifier.
    ///   - includeInternal: Whether to include internal entries.
    /// - Returns: A result code and the returned rows.
    ///
    /// Related SQLite: `sqlite_schema`, `sqlite_master`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_name`, `sqlite3_column_int64`, `sqlite3_column_text`, `sqlite3_finalize`
    public func tables(in table: SchemaTable = .master, databaseName: String? = nil, includeInternal: Bool = false) -> (ResultCode, [SchemaObject]) {
        schemaObjects(of: .table, in: table, databaseName: databaseName, includeInternal: includeInternal)
    }

    /// Reads view entries from the schema table.
    /// - Parameters:
    ///   - table: Schema table to read.
    ///   - databaseName: Optional database name qualifier.
    ///   - includeInternal: Whether to include internal entries.
    /// - Returns: A result code and the returned rows.
    ///
    /// Related SQLite: `sqlite_schema`, `sqlite_master`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_name`, `sqlite3_column_int64`, `sqlite3_column_text`, `sqlite3_finalize`
    public func views(in table: SchemaTable = .master, databaseName: String? = nil, includeInternal: Bool = false) -> (ResultCode, [SchemaObject]) {
        schemaObjects(of: .view, in: table, databaseName: databaseName, includeInternal: includeInternal)
    }

    /// Reads index entries from the schema table.
    /// - Parameters:
    ///   - table: Schema table to read.
    ///   - databaseName: Optional database name qualifier.
    ///   - includeInternal: Whether to include internal entries.
    /// - Returns: A result code and the returned rows.
    ///
    /// Related SQLite: `sqlite_schema`, `sqlite_master`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_name`, `sqlite3_column_int64`, `sqlite3_column_text`, `sqlite3_finalize`
    public func indexes(in table: SchemaTable = .master, databaseName: String? = nil, includeInternal: Bool = false) -> (ResultCode, [SchemaObject]) {
        schemaObjects(of: .index, in: table, databaseName: databaseName, includeInternal: includeInternal)
    }

    /// Reads trigger entries from the schema table.
    /// - Parameters:
    ///   - table: Schema table to read.
    ///   - databaseName: Optional database name qualifier.
    ///   - includeInternal: Whether to include internal entries.
    /// - Returns: A result code and the returned rows.
    ///
    /// Related SQLite: `sqlite_schema`, `sqlite_master`, `sqlite3_prepare_v2`, `sqlite3_step`, `sqlite3_column_name`, `sqlite3_column_int64`, `sqlite3_column_text`, `sqlite3_finalize`
    public func triggers(in table: SchemaTable = .master, databaseName: String? = nil, includeInternal: Bool = false) -> (ResultCode, [SchemaObject]) {
        schemaObjects(of: .trigger, in: table, databaseName: databaseName, includeInternal: includeInternal)
    }
}

private func schemaSelectSQL(table: Connection.SchemaTable, databaseName: String?, types: [Connection.SchemaObjectType], includeInternal: Bool) -> String {
    let qualifiedTable: String
    if let databaseName {
        qualifiedTable = "\(quotedIdentifier(databaseName)).\(quotedIdentifier(table.rawValue))"
    } else {
        qualifiedTable = quotedIdentifier(table.rawValue)
    }
    var sql = "SELECT type, name, tbl_name, rootpage, sql FROM \(qualifiedTable)"
    var filters: [String] = []
    if !types.isEmpty {
        let list = types.map { quotedLiteral($0.rawValue) }.joined(separator: ", ")
        filters.append("type IN (\(list))")
    }
    if !includeInternal {
        filters.append("name NOT LIKE 'sqlite_%'")
    }
    if !filters.isEmpty {
        sql.append(" WHERE \(filters.joined(separator: " AND "))")
    }
    return sql
}

private func quotedIdentifier(_ rawValue: String) -> String {
    let escaped = rawValue.replacingOccurrences(of: "\"", with: "\"\"")
    return "\"\(escaped)\""
}

private func quotedLiteral(_ rawValue: String) -> String {
    let escaped = rawValue.replacingOccurrences(of: "'", with: "''")
    return "'\(escaped)'"
}
