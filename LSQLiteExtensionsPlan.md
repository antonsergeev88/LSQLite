# LSQLiteExtensions Roadmap

## Goals
- Make SQLite adoption easier without changing SQLite semantics.
- Eliminate common boilerplate (statement lifecycle, transactions, pragmas, schema queries).
- Provide convenient access to SQLite-specific SQL features (PRAGMA, system tables, WAL/checkpoint, schema/version metadata).

## Constraints
- No new “primary” connection/statement types (extend existing `Connection` / `Statement`).
- Keep SQLite/LSQLite-style control flow (work with `ResultCode`, no throwing error model).
- Apple platforms only.

## Milestones (areas of interest)
1. Package scaffolding
   - Add the `LSQLiteExtensions` target + product and wire it into CI/tests.

2. Codable binding & decoding
   - Add statement-backed Codable helpers for binding and row decoding (no intermediate representation).
     - Implement custom `Encoder` / `Decoder` that operate directly on `Statement` (bind/read) with no intermediate formats (no JSON, no plist, no other serialization) for performance.
       - If key discovery is needed, implement a separate lightweight “key-only” encoder that captures coding keys and ignores values, rather than encoding to an intermediate representation.
     - `Statement.bind<Binding: Encodable>(_ binding: Binding) -> Bool`
       - Support only named parameters with `:` prefix.
       - Support only `nil`, `Data`, `String`, `Int` (assume 64-bit), and `Double`; any other encoded type fails.
       - Require an exact match between statement parameter names and encoded keys; missing or extra parameters fail.
       - Support only flat types (top-level keyed container; no nested/unkeyed containers).
    - `Statement.row<Row: Decodable>(_: Row.Type = Row.self) -> Row?`
      - Support only `nil`, `Data`, `String`, `Int` (assume 64-bit), and `Double`; any other decoded type fails.
      - Require an exact match between result column names and decoded keys; missing or extra columns fail.
      - Support only flat types (top-level keyed container; no nested/unkeyed containers).

3. Statement lifecycle conveniences
   - Reduce boilerplate around prepare/bind/step/reset/finalize for common one-shot and repeated-use patterns.
   - Add exactly **6** `query` overloads on `Statement` (prepared statement helpers) and exactly **6** `query` overloads on `Connection` (one-shot helpers that prepare/finalize and delegate to `Statement`).
   - `Statement` API surface (6 overloads):
     - `query() -> ResultCode`
     - `query<Binding: Encodable>(_ binding: Binding) -> ResultCode`
     - `query<Row: Decodable>(row type: Row.Type = Row.self) -> (ResultCode, Row?)`
     - `query<Row: Decodable>(rows type: Row.Type = Row.self) -> (ResultCode, [Row])`
     - `query<Binding: Encodable, Row: Decodable>(_ binding: Binding, row type: Row.Type = Row.self) -> (ResultCode, Row?)`
     - `query<Binding: Encodable, Row: Decodable>(_ binding: Binding, rows type: Row.Type = Row.self) -> (ResultCode, [Row])`
   - `Connection` API surface (6 overloads, implemented via `Statement.prepare` + `Statement.query` + `finalize()`):
     - `query(_ sql: String) -> ResultCode`
     - `query<Binding: Encodable>(_ sql: String, binding: Binding) -> ResultCode`
     - `query<Row: Decodable>(_ sql: String, row type: Row.Type = Row.self) -> (ResultCode, Row?)`
     - `query<Row: Decodable>(_ sql: String, rows type: Row.Type = Row.self) -> (ResultCode, [Row])`
     - `query<Binding: Encodable, Row: Decodable>(_ sql: String, binding: Binding, row type: Row.Type = Row.self) -> (ResultCode, Row?)`
     - `query<Binding: Encodable, Row: Decodable>(_ sql: String, binding: Binding, rows type: Row.Type = Row.self) -> (ResultCode, [Row])`
   - Strictness rules:
     - No-row overloads fail with `.misuse` if a row is produced.
     - Single-row overloads must enforce **0 or 1** row total; if a second row exists, fail with `.misuse`.
     - Binding failure (via `Statement.bind(_:)`) fails with `.misuse`.
     - Row decoding failure (via `Statement.row(_:)`) fails with `.misuse`.
     - Underlying SQLite result codes from stepping propagate (for example `.busy`, `.error`).
     - `Statement` is left reusable: always `reset()` before returning; binding overloads also `clearBindings()` (at least on success, ideally on all paths).
   - Implementation notes:
     - Add `Statement+Query.swift` in `Sources/LSQLiteExtensions` with a small internal helper that runs the statement and (optionally) collects/validates rows.
     - Add `Connection+Query.swift` in `Sources/LSQLiteExtensions` that prepares exactly one statement, delegates to `Statement.query`, and finalizes via `defer`.
     - If the SQL string contains multiple statements, only the first prepared statement is executed; any remaining SQL (including comments) is ignored.
     - Performance: for row-returning overloads, build/validate the result column name map once per query (not per row) and reuse it while stepping; similarly, avoid recomputing the statement parameter map multiple times within a single query call.
   - Tests (Swift Testing):
     - `Tests/LSQLiteExtensionsTests/Statement+QueryTests.swift` (`@Suite("Statement+Query")`)
     - `Tests/LSQLiteExtensionsTests/Connection+QueryTests.swift` (`@Suite("Connection+Query")`)
     - Cover: `.misuse` on >1 row for single-row overloads, `.misuse` when using no-row overloads on a row-producing statement, and statement reusability across multiple calls.

4. Transactions & savepoints
   - Add thin helpers for explicit transaction control and savepoints.
     - `TransactionMode` with `deferred` / `immediate` / `exclusive` behavior.
     - `SavepointName` for typed savepoint identifiers.
     - `Connection.beginTransaction(_:)`, `commitTransaction()`, `rollbackTransaction()`.
     - `Connection.savepoint(_:)`, `releaseSavepoint(_:)`, `rollbackToSavepoint(_:)` (quote identifiers).
   - Add a closure-based helper that uses savepoints when already inside a transaction.
     - `Connection.transaction(_:_:)` uses `isAutocommit` to choose `BEGIN` vs `SAVEPOINT`.
     - Commit/release when body returns `.ok` or `.done`; rollback otherwise.
     - Use `exec(_:)` for SQL that includes multiple statements.
   - Tests (Swift Testing):
     - `Tests/LSQLiteExtensionsTests/Connection+TransactionTests.swift` (`@Suite("Connection+Transaction")`)
     - Cover autocommit toggling and nested savepoint behavior.

--- above are implemented ---

5. Pragmas
   - Read/write helpers for commonly used pragmas and convenience around pragma-related queries.
   - Approach: typed-only APIs. Do not add a public generic “run arbitrary PRAGMA by name” API.
   - Implementation notes:
     - Add `Sources/LSQLiteExtensions/Connection+Pragma.swift`.
     - Implement a tiny private helper that prepares exactly one PRAGMA statement via `Statement.prepare`, steps, reads column 0, enforces **0 or 1** row total, and finalizes via `defer`.
     - Return `.misuse` when the PRAGMA produces more than one row, when the value type does not match the expected Swift type, or when a scalar PRAGMA unexpectedly returns no rows.
     - Keep SQLite semantics: propagate `ResultCode` from prepare/step; do not introduce throwing flows.
     - Avoid string interpolation of PRAGMA names. Each public method hardcodes its PRAGMA SQL; if a database name must be accepted, quote it as an identifier.
   - Initial surface (examples; keep the set small and additive):
     - `user_version` (`Int32` round-trip).
     - `application_id` (`Int32` round-trip).
     - `foreign_keys` (`Bool` read/write).
   - Tests (Swift Testing):
     - `Tests/LSQLiteExtensionsTests/Connection+PragmaTests.swift` (`@Suite("Connection+Pragma")`), using an in-memory database and asserting round-trips and `.misuse` strictness.

6. Introspection & system tables
   - Helpers for working with `sqlite_schema` / `sqlite_master` and schema discovery (tables/views/indexes/triggers).
   - Helpers for pragma-driven metadata (table info, index info, foreign keys, etc).

7. Migrations
   - Versioning helpers (e.g. `user_version`) and a migration runner built on the previous features.

8. WAL & checkpoint
   - Convenience APIs around WAL checkpointing and related WAL controls.

## Testing
- Swift Testing suites per feature file, using in-memory databases and asserting via `ResultCode`.

## Documentation & examples
- Public docs for new symbols (with “Related SQLite:” lists), plus README recipes per feature.
