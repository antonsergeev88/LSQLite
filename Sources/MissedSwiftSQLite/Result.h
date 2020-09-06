#import <sqlite3.h>

void lsqlite3_result_transient_blob(sqlite3_context *context, const void *blob, int length);
void lsqlite3_result_static_blob(sqlite3_context *context, const void *blob, int length);

void lsqlite3_result_transient_text(sqlite3_context *context, const char *text, int length);
void lsqlite3_result_static_text(sqlite3_context *context, const char *text, int length);
