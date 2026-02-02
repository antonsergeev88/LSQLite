import LSQLite

extension Connection {
    /// A migration step tied to a target version value.
    ///
    /// Related SQLite: `PRAGMA user_version`
    @frozen public struct Migration {
        public let version: Int32
        public let body: (Connection) -> ResultCode

        /// Creates a migration step.
        /// - Parameters:
        ///   - version: Target version for the migration.
        ///   - body: Work to run for the migration.
        ///
        /// Related SQLite: `PRAGMA user_version`
        @inlinable public init(version: Int32, body: @escaping (Connection) -> ResultCode) {
            self.version = version
            self.body = body
        }
    }

    /// Applies migrations in ascending version order and updates the stored version value.
    /// - Parameters:
    ///   - migrations: Migrations to apply.
    ///   - databaseName: Optional database name qualifier.
    /// - Returns: Result code from the first failure, or `.done` when all migrations complete.
    ///
    /// Returns `.misuse` when duplicate versions are supplied or when the current version cannot be read.
    ///
    /// Related SQLite: `PRAGMA user_version`, `BEGIN`, `COMMIT`, `ROLLBACK`, `SAVEPOINT`, `RELEASE`, `ROLLBACK TO`
    public func migrate(_ migrations: [Migration], databaseName: String? = nil) -> ResultCode {
        guard !migrations.isEmpty else {
            return .done
        }

        var seenVersions: Set<Int32> = []
        seenVersions.reserveCapacity(migrations.count)
        for migration in migrations {
            if seenVersions.contains(migration.version) {
                return .misuse
            }
            seenVersions.insert(migration.version)
        }

        let currentVersion = userVersion(databaseName: databaseName)
        guard currentVersion.0 == .done else {
            return currentVersion.0
        }
        guard var version = currentVersion.1 else {
            return .misuse
        }

        let ordered = migrations.sorted { $0.version < $1.version }
        for migration in ordered where migration.version > version {
            let result = transaction { connection in
                let bodyResult = migration.body(connection)
                guard bodyResult == .ok || bodyResult == .done else {
                    return bodyResult
                }
                return connection.setUserVersion(migration.version, databaseName: databaseName)
            }
            guard result == .ok || result == .done else {
                return result
            }
            version = migration.version
        }

        return .done
    }
}
