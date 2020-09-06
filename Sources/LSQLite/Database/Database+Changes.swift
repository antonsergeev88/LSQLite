import MissedSwiftSQLite

extension Database {
    /**
     CAPI3REF: Count The Number Of Rows Modified
     METHOD: sqlite3

     ^This function returns the number of rows modified, inserted or
     deleted by the most recently completed INSERT, UPDATE or DELETE
     statement on the database connection specified by the only parameter.
     ^Executing any other type of SQL statement does not modify the value
     returned by this function.

     ^Only changes made directly by the INSERT, UPDATE or DELETE statement are
     considered - auxiliary changes caused by [CREATE TRIGGER | triggers],
     [foreign key actions] or [REPLACE] constraint resolution are not counted.

     Changes to a view that are intercepted by
     [INSTEAD OF trigger | INSTEAD OF triggers] are not counted. ^The value
     returned by sqlite3_changes() immediately after an INSERT, UPDATE or
     DELETE statement run on a view is always zero. Only changes made to real
     tables are counted.

     Things are more complicated if the sqlite3_changes() function is
     executed while a trigger program is running. This may happen if the
     program uses the [changes() SQL function], or if some other callback
     function invokes sqlite3_changes() directly. Essentially:

     
      ^(Before entering a trigger program the value returned by
     sqlite3_changes() function is saved. After the trigger program
     has finished, the original value is restored.)^

      ^(Within a trigger program each INSERT, UPDATE and DELETE
     statement sets the value returned by sqlite3_changes()
     upon completion as normal. Of course, this value will not include
     any changes performed by sub-triggers, as the sqlite3_changes()
     value will be saved and restored after each sub-trigger has run.)^
     

     ^This means that if the changes() SQL function (or similar) is used
     by the first INSERT, UPDATE or DELETE statement within a trigger, it
     returns the value as set when the calling statement began executing.
     ^If it is used by the second or subsequent such statement within a trigger
     program, the value returned reflects the number of rows modified by the
     previous INSERT, UPDATE or DELETE statement within the same trigger.

     If a separate thread makes changes on the same database connection
     while [sqlite3_changes()] is running then the value returned
     is unpredictable and not meaningful.

     See also:
     
      the [sqlite3_total_changes()] interface
      the [count_changes pragma]
      the [changes() SQL function]
      the [data_version pragma]
     
     */
    @inlinable public var changes: Int32 {
        sqlite3_changes(rawValue)
    }

    /**
     CAPI3REF: Total Number Of Rows Modified
     METHOD: sqlite3

     ^This function returns the total number of rows inserted, modified or
     deleted by all [INSERT], [UPDATE] or [DELETE] statements completed
     since the database connection was opened, including those executed as
     part of trigger programs. ^Executing any other type of SQL statement
     does not affect the value returned by sqlite3_total_changes().

     ^Changes made as part of [foreign key actions] are included in the
     count, but those made as part of REPLACE constraint resolution are
     not. ^Changes to a view that are intercepted by INSTEAD OF triggers
     are not counted.

     The [sqlite3_total_changes(D)] interface only reports the number
     of rows that changed due to SQL statement run against database
     connection D.  Any changes by other database connections are ignored.
     To detect changes against a database file from other database
     connections use the [PRAGMA data_version] command or the
     [SQLITE_FCNTL_DATA_VERSION] [file control].

     If a separate thread makes changes on the same database connection
     while [sqlite3_total_changes()] is running then the value
     returned is unpredictable and not meaningful.

     See also:
     
      the [sqlite3_changes()] interface
      the [count_changes pragma]
      the [changes() SQL function]
      the [data_version pragma]
      the [SQLITE_FCNTL_DATA_VERSION] [file control]
     
     */
    @inlinable public var totalChanges: Int32 {
        sqlite3_total_changes(rawValue)
    }
}
