# Agent Guidelines for LSQLite

## Project intent
- LSQLite is a zero-overhead, typed Swift wrapper over the SQLite C API. APIs should stay as 1:1 as possible with SQLite names and behavior, while replacing raw pointers and integer constants with small Swift wrappers.
- Public APIs are thin `@inlinable` forwarders to the underlying `sqlite3_*` calls. Avoid adding higher-level abstractions, throwing error flows, or behavior changes beyond the existing SQLite semantics.
- The wrapper types must always allow escape hatches: every wrapper should expose a `rawValue` that maps directly to the C handle or constant.
- Inline documentation is first-class. New public symbols should include concise Swift doc comments plus a "Related SQLite:" section listing the original SQLite functions or constants they wrap.

## Testing direction
- Prefer Swift Testing over XCTest for new or updated tests. Existing XCTest cases are legacy and should be migrated opportunistically. Keep tests runnable across Apple and non-Apple platforms.
- Follow the Swift Testing style used in the blob tests: group by feature under `Tests/LSQLiteTests`, use `@Suite("...")`, and give `@Test` cases descriptive names.
- Test files mirror source files with a `Tests` suffix, and each test file defines exactly one `@Suite` named after the original file (without the `Tests` suffix).
- Use in-memory databases for isolation, set up shared fixtures in `init()` with `#require` on result codes and optional unwrapping, and tear down with `deinit` or `defer` when a handle must be closed.
- Assert SQLite semantics via `ResultCode` with `#expect` (for example, `.ok`, `.error`, `.busy`, `.abort`) instead of introducing throwing flows.
- Keep tests focused and readable by extracting repeated buffer or pointer helpers into file-private functions.
- Keep test control flow linear with no branching; use `try #require` to unwrap optionals or verify prerequisites before continuing.
- Focus tests on validating the wrapper behavior and surface (rawValue round trips, ResultCode mapping, handle lifecycle), not SQLite's own functionality.

## Platform expectations
- Non-Apple platforms are fully supported. Gate Apple-only constants and behaviors with the appropriate `canImport` checks, and rely on the `MissedSwiftSQLite` target to expose any SQLite constants or helpers that the Swift importer misses on Linux.
- Link and runtime assumptions should work with the system-provided `sqlite3` on each platform; avoid Apple-only or Darwin-specific APIs unless properly conditioned.

## Code organization
- Keep related wrappers in focused extension files, following the existing directory layout (e.g., `Database+Open`, `Statement+Bind`, `Value+Getters`).
- Do not introduce new abstractions like ORMs or query builders. The surface should remain a typed reflection of the SQLite C API.
