import MissedSwiftSQLite

extension Connection {
    /// Requests that all running statements on this connection abort at their earliest opportunity.
    ///
    /// It is safe to call from a different thread as long as the connection remains open.
    /// If an interrupt occurs during an INSERT, UPDATE, or DELETE inside an explicit transaction,
    /// the transaction is rolled back automatically. The interrupt remains in effect until all
    /// currently running statements complete; statements started after the call but before the
    /// running statements finish are interrupted as well. If an operation is already near
    /// completion, it may finish without interruption. Calling this when no statements are
    /// running is a no-op.
    /// - Returns: Nothing.
    ///
    /// Related SQLite: `sqlite3_interrupt`, `SQLITE_INTERRUPT`
    @inlinable public func interrupt() {
        sqlite3_interrupt(rawValue)
    }
}
