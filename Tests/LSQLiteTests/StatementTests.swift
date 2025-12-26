import XCTest
import LSQLite

class StatementTests: XCTestCase {

    var database: Database!

    override func setUpWithError() throws {
        try super.setUpWithError()
        database = try {
            var database: Database? = nil
            guard Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create, .memory]) == .ok, database != nil else {
                if let database = database {
                    throw Error.result(database.lastErrorCode)
                } else {
                    throw Error.unknown
                }
            }
            return database
        }()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        guard database.close() == .ok else {
            throw Error.result(database.lastErrorCode)
        }
    }

    func testCreateDatabaseInsertRowRowsAndGetThemBack() throws {
        let createTableStatement: Statement = try {
            var statement: Statement? = nil
            let resultCode = Statement.prepare(&statement, sql: "CREATE TABLE t(num INTEGER, txt TEXT);", for: database)
            guard resultCode == .ok, statement != nil else {
                throw Error.result(resultCode)
            }
            return statement!
        }()
        XCTAssertEqual(createTableStatement.step(), .done)
        XCTAssertEqual(createTableStatement.finalize(), .ok)

        let insertStatement: Statement = try {
            var statement: Statement? = nil
            let resultCode = Statement.prepare(&statement, sql: "INSERT INTO t VALUES(?, ?);", for: database)
            guard resultCode == .ok, statement != nil else {
                throw Error.result(resultCode)
            }
            return statement!
        }()

        XCTAssertEqual(insertStatement.bindInt(1, at: 1), .ok)
        XCTAssertEqual(insertStatement.bindText("text1", at: 2), .ok)
        XCTAssertEqual(insertStatement.step(), .done)
        XCTAssertEqual(insertStatement.clearBindings(), .ok)
        XCTAssertEqual(insertStatement.reset(), .ok)

        XCTAssertEqual(insertStatement.bindInt(2, at: 1), .ok)
        XCTAssertEqual(insertStatement.bindNull(at: 2), .ok)
        XCTAssertEqual(insertStatement.step(), .done)
        XCTAssertEqual(insertStatement.clearBindings(), .ok)
        XCTAssertEqual(insertStatement.reset(), .ok)

        XCTAssertEqual(insertStatement.finalize(), .ok)

        let selectStatement: Statement = try {
            var statement: Statement? = nil
            let resultCode = Statement.prepare(&statement, sql: "SELECT num, txt FROM t;", for: database)
            guard resultCode == .ok, statement != nil else {
                throw Error.result(resultCode)
            }
            return statement!
        }()

        XCTAssertEqual(selectStatement.step(), .row)
        XCTAssertEqual(selectStatement.columnInt(at: 0), 1)
        XCTAssertEqual(selectStatement.columnText(at: 1), "text1")

        XCTAssertEqual(selectStatement.step(), .row)
        XCTAssertEqual(selectStatement.columnInt(at: 0), 2)
        XCTAssertEqual(selectStatement.columnText(at: 1), nil)

        XCTAssertEqual(selectStatement.step(), .done)

        XCTAssertEqual(selectStatement.finalize(), .ok)
    }
    
}
