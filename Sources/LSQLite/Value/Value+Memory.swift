import MissedSwiftSQLite

@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension Value {
    /**
     CAPI3REF: Copy And Free SQL Values
     METHOD: sqlite3_value

     ^The sqlite3_value_dup(V) interface makes a copy of the [sqlite3_value]
     object D and returns a pointer to that copy.  ^The [sqlite3_value] returned
     is a [protected sqlite3_value] object even if the input is not.
     ^The sqlite3_value_dup(V) interface returns NULL if V is NULL or if a
     memory allocation fails.

     ^The sqlite3_value_free(V) interface frees an [sqlite3_value] object
     previously obtained from [sqlite3_value_dup()].  ^If V is a NULL pointer
     then sqlite3_value_free(V) is a harmless no-op.
    */
    @inlinable public func createCopy() -> Value? {
        return sqlite3_value_dup(rawValue).map(Value.init(rawValue:))
    }

    /**
     CAPI3REF: Copy And Free SQL Values
     METHOD: sqlite3_value

     ^The sqlite3_value_dup(V) interface makes a copy of the [sqlite3_value]
     object D and returns a pointer to that copy.  ^The [sqlite3_value] returned
     is a [protected sqlite3_value] object even if the input is not.
     ^The sqlite3_value_dup(V) interface returns NULL if V is NULL or if a
     memory allocation fails.

     ^The sqlite3_value_free(V) interface frees an [sqlite3_value] object
     previously obtained from [sqlite3_value_dup()].  ^If V is a NULL pointer
     then sqlite3_value_free(V) is a harmless no-op.
    */
    @inlinable public func free() {
        sqlite3_value_free(rawValue)
    }
}
