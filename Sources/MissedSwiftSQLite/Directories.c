#include "Directories.h"

char *lsqlite_get_data_directory(void) {
    return sqlite3_data_directory;
}

void lsqlite_set_data_directory(char *value) {
    sqlite3_data_directory = value;
}
