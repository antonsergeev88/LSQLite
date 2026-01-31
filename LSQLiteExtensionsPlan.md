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

--- above are implemented ---

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
   - Implement one-shot patterns as `Connection` extensions.

4. Transactions & savepoints
   - Transaction helpers (begin/commit/rollback) and nested transactional behavior via savepoints.

5. Pragmas
   - Read/write helpers for commonly used pragmas and convenience around pragma-related queries.

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
