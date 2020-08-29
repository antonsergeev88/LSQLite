import XCTest
import LSQLite

class StatementTests: XCTestCase {

    var database: Database!

    override class func setUp() {
        super.setUp()
        _ = LSQLite.initialize()
    }

    override class func tearDown() {
        super.tearDown()
        _ = LSQLite.shutdown()
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        database = try {
            var database = Database()
            guard database.open(at: .memory, withOpenFlags: [.readwrite, .create, .memory]) == .ok else {
                throw Error.result(database.lastErrorCode)
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

    func testCreateDatabaseInsertRowRowsAndGetThemBack() {
        let createTableStatement: Statement = {
            var statement = Statement()
            XCTAssertEqual(statement.prepare("CREATE TABLE t(num INTEGER, txt TEXT);", for: database), .ok)
            return statement
        }()
        XCTAssertEqual(createTableStatement.step(), .done)
        XCTAssertEqual(createTableStatement.finalize(), .ok)

        let insertStatement: Statement = {
            var statement = Statement()
            XCTAssertEqual(statement.prepare("INSERT INTO t VALUES(?, ?);", for: database), .ok)
            return statement
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

        let selectStatement: Statement = {
            var statement = Statement()
            XCTAssertEqual(statement.prepare("SELECT num, txt FROM t;", for: database), .ok)
            return statement
        }()

        XCTAssertEqual(selectStatement.step(), .row)
        XCTAssertEqual(selectStatement.columnInt(at: 0), 1)
        XCTAssertEqual(selectStatement.columnText(at: 1).map(String.init(cString:)), "text1")

        XCTAssertEqual(selectStatement.step(), .row)
        XCTAssertEqual(selectStatement.columnInt(at: 0), 2)
        XCTAssertEqual(selectStatement.columnText(at: 1).map(String.init(cString:)), nil)

        XCTAssertEqual(selectStatement.step(), .done)

        XCTAssertEqual(selectStatement.finalize(), .ok)
    }
    
}
