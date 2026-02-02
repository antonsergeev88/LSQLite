import LSQLite

extension Connection {
    /// Modes that influence how a new transaction acquires its locks.
    ///
    /// Related SQLite: `BEGIN`, `DEFERRED`, `IMMEDIATE`, `EXCLUSIVE`
    @frozen public enum TransactionMode: String {
        /// Uses the default lock acquisition behavior.
        ///
        /// Related SQLite: `DEFERRED`
        case deferred = "DEFERRED"

        /// Requests the write lock earlier in the transaction.
        ///
        /// Related SQLite: `IMMEDIATE`
        case immediate = "IMMEDIATE"

        /// Requests the most restrictive lock up front.
        ///
        /// Related SQLite: `EXCLUSIVE`
        case exclusive = "EXCLUSIVE"
    }

    /// A name identifying a nested transaction scope.
    ///
    /// Related SQLite: `SAVEPOINT`, `RELEASE`, `ROLLBACK TO`
    @frozen public struct SavepointName: Hashable, RawRepresentable, ExpressibleByStringLiteral {
        public let rawValue: String

        @inlinable public init(rawValue: String) {
            self.rawValue = rawValue
        }

        @inlinable public init(stringLiteral value: String) {
            self.rawValue = value
        }
    }

    /// Starts a new transaction on the connection.
    /// - Parameter mode: Mode used to start the transaction.
    /// - Returns: Result code from the operation.
    ///
    /// Related SQLite: `BEGIN`, `DEFERRED`, `IMMEDIATE`, `EXCLUSIVE`
    public func beginTransaction(_ mode: TransactionMode = .deferred) -> ResultCode {
        exec(mode.beginSQL)
    }

    /// Finalizes the active transaction on the connection.
    /// - Returns: Result code from the operation.
    ///
    /// Related SQLite: `COMMIT`
    public func commitTransaction() -> ResultCode {
        exec("COMMIT")
    }

    /// Reverts the active transaction on the connection.
    /// - Returns: Result code from the operation.
    ///
    /// Related SQLite: `ROLLBACK`
    public func rollbackTransaction() -> ResultCode {
        exec("ROLLBACK")
    }

    /// Creates a named nested transaction scope.
    /// - Parameter name: Name identifying the nested scope.
    /// - Returns: Result code from the operation.
    ///
    /// Related SQLite: `SAVEPOINT`
    public func savepoint(_ name: SavepointName) -> ResultCode {
        exec("SAVEPOINT \(quotedIdentifier(name.rawValue))")
    }

    /// Finishes a named nested transaction scope.
    /// - Parameter name: Name identifying the nested scope.
    /// - Returns: Result code from the operation.
    ///
    /// Related SQLite: `RELEASE`
    public func releaseSavepoint(_ name: SavepointName) -> ResultCode {
        exec("RELEASE \(quotedIdentifier(name.rawValue))")
    }

    /// Reverts work in a named nested transaction scope.
    /// - Parameter name: Name identifying the nested scope.
    /// - Returns: Result code from the operation.
    ///
    /// Related SQLite: `ROLLBACK TO`
    public func rollbackToSavepoint(_ name: SavepointName) -> ResultCode {
        exec("ROLLBACK TO \(quotedIdentifier(name.rawValue))")
    }

    /// Runs a body within a transaction, using a nested scope if one is already active.
    /// - Parameters:
    ///   - mode: Mode used when starting a new outer transaction.
    ///   - body: Work to execute. Return `.ok` or `.done` to finalize changes; any other value reverts them.
    /// - Returns: The body result when finalization succeeds, otherwise the finalization result code.
    ///
    /// Related SQLite: `BEGIN`, `COMMIT`, `ROLLBACK`, `SAVEPOINT`, `RELEASE`, `ROLLBACK TO`
    public func transaction(_ mode: TransactionMode = .deferred, _ body: (Connection) -> ResultCode) -> ResultCode {
        if isAutocommit {
            let beginResult = beginTransaction(mode)
            guard beginResult == .ok else {
                return beginResult
            }
            let bodyResult = body(self)
            if bodyResult == .ok || bodyResult == .done {
                let commitResult = commitTransaction()
                return commitResult == .ok ? bodyResult : commitResult
            }
            let rollbackResult = rollbackTransaction()
            return rollbackResult == .ok ? bodyResult : rollbackResult
        }

        let savepointName = makeSavepointName()
        let savepointResult = savepoint(savepointName)
        guard savepointResult == .ok else {
            return savepointResult
        }
        let bodyResult = body(self)
        if bodyResult == .ok || bodyResult == .done {
            let releaseResult = releaseSavepoint(savepointName)
            return releaseResult == .ok ? bodyResult : releaseResult
        }
        let rollbackResult = rollbackToSavepoint(savepointName)
        guard rollbackResult == .ok else {
            return rollbackResult
        }
        let releaseResult = releaseSavepoint(savepointName)
        return releaseResult == .ok ? bodyResult : releaseResult
    }
}

private extension Connection.TransactionMode {
    var beginSQL: String {
        "BEGIN \(rawValue)"
    }
}

private func quotedIdentifier(_ rawValue: String) -> String {
    let escaped = rawValue.replacingOccurrences(of: "\"", with: "\"\"")
    return "\"\(escaped)\""
}

private func makeSavepointName() -> Connection.SavepointName {
    let value = UInt64.random(in: UInt64.min...UInt64.max)
    return Connection.SavepointName(rawValue: "lsqlite_txn_\(value)")
}
