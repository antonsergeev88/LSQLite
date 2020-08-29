#include "Bind.h"

int lsqlite3_bind_transient_blob(sqlite3_stmt *db, int index, const void *blob, int length) {
    return sqlite3_bind_blob(db, index, blob, length, SQLITE_TRANSIENT);
}

int lsqlite3_bind_static_blob(sqlite3_stmt *db, int index, const void *blob, int length) {
    return sqlite3_bind_blob(db, index, blob, length, SQLITE_STATIC);
}

int sqlite3_bind_transient_text(sqlite3_stmt *db, int index, const char *text, int length) {
    return sqlite3_bind_text(db, index, text, length, SQLITE_TRANSIENT);
}

int sqlite3_bind_static_text(sqlite3_stmt *db, int index, const char *text, int length) {
    return sqlite3_bind_text(db, index, text, length, SQLITE_STATIC);
}
