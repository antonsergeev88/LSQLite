/**
 CAPI3REF: Mutex Handle

 The mutex module within SQLite defines [sqlite3_mutex] to be an
 abstract type for a mutex object.  The SQLite core never looks
 at the internal representation of an [sqlite3_mutex].  It only
 deals with pointers to the [sqlite3_mutex] object.

 Mutexes are created using [sqlite3_mutex_alloc()].
*/
@frozen public struct Mutex: RawRepresentable {
    public let rawValue: OpaquePointer

    public init(rawValue: OpaquePointer) {
        self.rawValue = rawValue
    }
}
