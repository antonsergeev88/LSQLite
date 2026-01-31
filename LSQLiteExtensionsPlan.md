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

2. Statement lifecycle conveniences
   - Reduce boilerplate around prepare/bind/step/reset/finalize for common one-shot and repeated-use patterns.

3. Transactions & savepoints
   - Transaction helpers (begin/commit/rollback) and nested transactional behavior via savepoints.

4. Pragmas
   - Read/write helpers for commonly used pragmas and convenience around pragma-related queries.

5. Introspection & system tables
   - Helpers for working with `sqlite_schema` / `sqlite_master` and schema discovery (tables/views/indexes/triggers).
   - Helpers for pragma-driven metadata (table info, index info, foreign keys, etc).

6. Migrations
   - Versioning helpers (e.g. `user_version`) and a migration runner built on the previous features.

7. Codable
   - Optional Codable-based binding/decoding helpers for statement parameters and result columns.

8. WAL & checkpoint
   - Convenience APIs around WAL checkpointing and related WAL controls.

## Testing
- Swift Testing suites per feature file, using in-memory databases and asserting via `ResultCode`.

## Documentation & examples
- Public docs for new symbols (with “Related SQLite:” lists), plus README recipes per feature.
