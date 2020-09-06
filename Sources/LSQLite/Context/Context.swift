/**
 CAPI3REF: SQL Function Context Object

 The context in which an SQL function executes is stored in an
 sqlite3_context object.  ^A pointer to an sqlite3_context object
 is always first parameter to [application-defined SQL functions].
 The application-defined SQL function implementation will pass this
 pointer through into calls to [sqlite3_result_int | sqlite3_result()],
 [sqlite3_aggregate_context()], [sqlite3_user_data()],
 [sqlite3_context_db_handle()], [sqlite3_get_auxdata()],
 and/or [sqlite3_set_auxdata()].
 */
@frozen public struct Context: RawRepresentable {
    public let rawValue: OpaquePointer

    @inlinable public init(rawValue: OpaquePointer) {
        self.rawValue = rawValue
    }
}
