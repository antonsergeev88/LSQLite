# Agent Guidelines for LSQLite

## Project intent
- LSQLite is a zero-overhead, typed Swift wrapper over the SQLite C API. APIs should stay as 1:1 as possible with SQLite names and behavior, while replacing raw pointers and integer constants with small Swift wrappers.
- Public APIs are thin `@inlinable` forwarders to the underlying `sqlite3_*` calls. Avoid adding higher-level abstractions, throwing error flows, or behavior changes beyond the existing SQLite semantics.
- The wrapper types must always allow escape hatches: every wrapper should expose a `rawValue` that maps directly to the C handle or constant.
- Inline documentation is first-class. New public symbols should include concise Swift doc comments plus a "Related SQLite:" section listing the original SQLite functions or constants they wrap.

## Testing direction
- Prefer Swift Testing over XCTest for new or updated tests. Existing XCTest cases are legacy and should be migrated opportunistically. Keep tests runnable across Apple and non-Apple platforms.

## Platform expectations
- Non-Apple platforms are fully supported. Gate Apple-only constants and behaviors with the appropriate `canImport` checks, and rely on the `MissedSwiftSQLite` target to expose any SQLite constants or helpers that the Swift importer misses on Linux.
- Link and runtime assumptions should work with the system-provided `sqlite3` on each platform; avoid Apple-only or Darwin-specific APIs unless properly conditioned.

## Code organization
- Keep related wrappers in focused extension files, following the existing directory layout (e.g., `Database+Open`, `Statement+Bind`, `Value+Getters`).
- Do not introduce new abstractions like ORMs or query builders. The surface should remain a typed reflection of the SQLite C API.
