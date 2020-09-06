import MissedSwiftSQLite

/**
 CAPI3REF: Pseudo-Random Number Generator

 SQLite contains a high-quality pseudo-random number generator (PRNG) used to
 select random [ROWID | ROWIDs] when inserting new records into a table that
 already uses the largest possible [ROWID].  The PRNG is also used for
 the build-in random() and randomblob() SQL functions.  This interface allows
 applications to access the same PRNG for other purposes.

 ^A call to this routine stores N bytes of randomness into buffer P.
 ^The P parameter can be a NULL pointer.

 ^If this routine has not been previously called or if the previous
 call had N less than one or a NULL pointer for P, then the PRNG is
 seeded using randomness obtained from the xRandomness method of
 the default [sqlite3_vfs] object.
 ^If the previous call to this routine had an N of 1 or more and a
 non-NULL P then the pseudo-randomness is generated
 internally and without recourse to the [sqlite3_vfs] xRandomness
 method.
 */
@inlinable public func randomness(byteCount count: Int32, into buffer: UnsafeMutableRawPointer) {
    sqlite3_randomness(count, buffer)
}
