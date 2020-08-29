#import <sqlite3.h>

int lsqlite3_bind_transient_blob(sqlite3_stmt *db, int index, const void *blob, int length);
int lsqlite3_bind_static_blob(sqlite3_stmt *db, int index, const void *blob, int length);

int sqlite3_bind_transient_text(sqlite3_stmt *db, int index, const char *text, int length);
int sqlite3_bind_static_text(sqlite3_stmt *db, int index, const char *text, int length);
