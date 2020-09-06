#include "Result.h"

void lsqlite3_result_transient_blob(sqlite3_context *context, const void *blob, int length) {
    sqlite3_result_blob(context, blob, length, SQLITE_TRANSIENT);
}

void lsqlite3_result_static_blob(sqlite3_context *context, const void *blob, int length) {
    sqlite3_result_blob(context, blob, length, SQLITE_STATIC);
}

void lsqlite3_result_transient_text(sqlite3_context *context, const char *text, int length) {
    sqlite3_result_text(context, text, length, SQLITE_TRANSIENT);
}

void lsqlite3_result_static_text(sqlite3_context *context, const char *text, int length) {
    sqlite3_result_text(context, text, length, SQLITE_STATIC);
}
