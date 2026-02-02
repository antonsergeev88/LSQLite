# LSQLite

A zero-overhead, typed Swift wrapper around the SQLite C API — same functions, no `OpaquePointer`, no magic constants.

LSQLiteExtensions is an add-on target in this package that layers opt-in conveniences on top of LSQLite while keeping SQLite semantics intact. It focuses on reducing boilerplate for common workflows (for example, Codable binding and row decoding) without introducing higher-level abstractions or a throwing error model.

## Motivation

The SQLite C API is small and powerful, but in Swift it comes with a few pain points:
- You work with `OpaquePointer` handles that are easy to misuse.
- You constantly look up which `Int32` constant to pass or compare against.
- In Swift, many `#define` constants become computed variables, hiding the fact that they are real constants.
- The default Swift `SQLite3` module does not expose any inline documentation, because SQLite’s comments are not in the format Swift recognizes for doc comments.

LSQLite keeps the *exact* SQLite API surface and behavior, but:
- Wraps raw handles like `sqlite3 *` and `sqlite3_stmt *` into small Swift structs (`Connection`, `Statement`, …).
- Wraps result codes and flags into typed Swift values (`ResultCode`, `OpenFlag`, …).
- Leaves control flow and error handling exactly as in the C API: you still check result codes instead of catching errors.

If you already know the SQLite C API, nothing new to learn — the names and concepts are the same, just expressed as Swift types.

## Design Goals

- 1:1 mapping of the SQLite C API (names and behavior stay the same).
- No new abstractions: only wrappers around existing C functions, handles, flags, and result codes.
- Non-throwing API: you continue to work with SQLite-style result codes (`SQLITE_OK`, `SQLITE_DONE`, …) via `ResultCode`.
- Strong typing: Swift wrappers around `OpaquePointer`, integers, and bitmask flags.
- Zero overhead: wrapper functions are `@inlinable` one-liners that forward to `sqlite3_*`; the generated machine code is the same as calling the C API directly.
- Potentially faster than using the imported C module directly:
  - SQLite `#define` constants that Swift normally imports as computed variables are exposed here as true Swift constants (`static let` and enums).
  - The compiler knows this at compile time and can better optimize branches and flag checks.
- Easy interop: you can always go back to the raw C API using `rawValue`, or come from the C API by constructing LSQLite types from existing handles and codes.
- Fully documented API: every public symbol in LSQLite has carefully written Swift documentation comments, each with a list of related SQLite functions and constants, visible right in Xcode, Cursor, or any IDE that supports Swift doc popups.

## Documentation

All LSQLite symbols correspond directly to the SQLite C API and come with new inline Swift documentation:
- Each wrapper type and method has a concise description written for Swift developers, not a verbatim copy of SQLite’s comments.
- Every doc comment includes a “Related SQLite:” section listing the original functions and constants it wraps, so you can easily find the upstream documentation for deeper details.
- Your IDE (Xcode, Cursor, etc.) shows this documentation in-place for code completion and quick help.
- You get SQLite context and cross-references without leaving the editor or switching to external references.

## Installation

### Swift Package Manager

Add LSQLite to your `Package.swift`:

```swift
// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    // ...
    dependencies: [
        .package(url: "https://github.com/antonsergeev88/LSQLite.git", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "YourApp",
            dependencies: [
                .product(name: "LSQLite", package: "LSQLite")
            ]
        ),
    ]
)
```

In Xcode, you can also add it via:
- `File` → `Add Packages…`
- Enter the repository URL (https://github.com/antonsergeev88/LSQLite.git) for LSQLite and add the `LSQLite` product to your target.

## Quick Start

```swift
import LSQLite

// 1. Open database
var db: Connection?
let openResult = Connection.open(&db, at: .init(rawValue: databasePath), withOpenFlags: [.readwrite, .create])
guard openResult == .ok, let db else {
    fatalError("Failed to open database: \(openResult)")
}

// 2. Create a table
let createResult = db.exec("CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, name TEXT);")
guard createResult == .ok else {
    fatalError("Failed to create table: \(createResult)")
}

// 3. Insert a row with a prepared statement
var insert: Statement?
guard Statement.prepare(&insert, sql: "INSERT INTO users(id, name) VALUES(?, ?);", for: db) == .ok, let insert else {
    fatalError("Failed to prepare insert statement")
}
insert.bindInt(1, at: 1)
insert.bindText("Natalie", at: 2)
guard insert.step() == .done else {
    fatalError("Insert failed")
}
insert.finalize()

// 4. Close database
db.close()
```

Every function you see here has a direct C counterpart (`sqlite3_open_v2`, `sqlite3_exec`, `sqlite3_prepare_v2`, `sqlite3_bind_int`, `sqlite3_bind_text`, `sqlite3_step`, `sqlite3_finalize`, `sqlite3_close`). LSQLite just wraps them in typed, object-style Swift.

## Migrating from the SQLite C API

Each SQLite C function has an LSQLite equivalent that keeps the same semantics but replaces raw pointers and integers with Swift types.

### Opening a database

**Swift with SQLite C API**

```swift
import SQLite3
var db: OpaquePointer?
let rc = sqlite3_open_v2("test.db", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil)
if rc != SQLITE_OK { /* handle error */ }
```

**Swift with LSQLite**

```swift
import LSQLite
var db: Connection?
let rc = Connection.open(&db, at: .init(rawValue: "test.db"), withOpenFlags: [.readwrite, .create])
if rc != .ok { /* handle error */ }
```

### Binding integers and text

**Swift with SQLite C API**

```swift
var stmt: OpaquePointer?
sqlite3_prepare_v2(db, "INSERT INTO t(id, name) VALUES(?, ?);", -1, &stmt, nil)
sqlite3_bind_int(stmt, 1, 42)
sqlite3_bind_text(stmt, 2, "Alice", -1, SQLITE_TRANSIENT)
sqlite3_step(stmt)
```

**Swift with LSQLite**

```swift
var stmt: Statement?
Statement.prepare(&stmt, sql: "INSERT INTO t(id, name) VALUES(?, ?);", for: db)
stmt!.bindInt(42, at: 1)
stmt!.bindText("Alice", at: 2)
stmt!.step()
```

The control flow is identical: prepare → bind → step. You just use typed `Statement` and `ResultCode` instead of raw `sqlite3_stmt *` and `Int32`.

## Interoperability with the SQLite C API

You can drop down to the SQLite C API or back to LSQLite at any time.

From LSQLite to C:

```swift
let rawDb: OpaquePointer = db.rawValue
let rawCode: Int32 = db.close().rawValue
```

From C to LSQLite:

```swift
let db = Connection(rawValue: someSQLitePointer)
let code = ResultCode(rawValue: SQLITE_BUSY)
```

This means you can:
- Adopt LSQLite gradually in an existing codebase.
- Use LSQLite for most code, while still calling any specialized `sqlite3_*` function that is not wrapped yet.
- Move back to pure C-style code whenever you want, without being locked in.

## Non-Goals

LSQLite intentionally does *not*:
- Provide an ORM, query builder, or higher-level database abstraction.
- Hide SQLite’s result codes behind `throw`/`try` or a custom error model.
- Change SQLite’s behavior or add automatic migrations.

It is a low-level, but safer and more readable, Swift presentation of the original C API.

## Performance and Safety

- **Zero overhead:** Public APIs are `@inlinable` and forward directly to `sqlite3_*` calls. After inlining, your binary contains the same code as if you had called the C API yourself.
- **Better constants:** SQLite `#define` values are exposed as real Swift constants, not computed variables. The compiler can see this at compile time, fold expressions, and better optimize flag checks.
- **Type safety:** Typed wrappers (`Connection`, `Statement`, `ResultCode`, `OpenFlag`, etc.) make it harder to pass the wrong pointer or constant.

## Contributing

Issues and pull requests are welcome.
- Keep wrappers thin: new APIs should stay close to the C API in naming and behavior.
- SQLite is large; inline documentation can have gaps or mistakes. Issues and PRs that improve or fix doc comments are among the most valuable contributions.

## License

LSQLite is available under the MIT License. See `LICENSE` for details.
