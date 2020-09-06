import XCTest
import LSQLite

class FunctionTests: XCTestCase {

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
        let myFiveResultCode = database.createFunction(name: "my_five", argumentCount: 0, flags: .utf8, userData: nil, funcHandler: { context, _, _ in
            let context = Context(rawValue: context)
            context.resultInt(5)
        })
        XCTAssertEqual(myFiveResultCode, .ok)
        let myCountResultCode = database.createFunction(name: "my_count", argumentCount: 0, flags: .utf8, userData: nil, stepHandler: { context, _, _ in
            let context = Context(rawValue: context)
            let aggregatePointer = context.aggregateContext(size: Int32(MemoryLayout<Int32>.stride))
            guard let valuePointer = aggregatePointer?.assumingMemoryBound(to: Int32.self) else {
                context.resultNoMemoryError()
                return
            }
            valuePointer.pointee += 1
        }, finalHandler: { context in
            let context = Context(rawValue: context)
            let value = context.aggregateContext(size: Int32(MemoryLayout<Int32>.stride))!.assumingMemoryBound(to: Int32.self).pointee
            context.resultInt(value)
        })
        XCTAssertEqual(myCountResultCode, .ok)
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
            XCTAssertEqual(statement.prepare("CREATE TABLE t(num INTEGER);", for: database), .ok)
            return statement
        }()
        XCTAssertEqual(createTableStatement.step(), .done)
        XCTAssertEqual(createTableStatement.finalize(), .ok)

        let insertStatement: Statement = {
            var statement = Statement()
            XCTAssertEqual(statement.prepare("INSERT INTO t VALUES(?);", for: database), .ok)
            return statement
        }()

        XCTAssertEqual(insertStatement.bindInt(1, at: 1), .ok)
        XCTAssertEqual(insertStatement.step(), .done)
        XCTAssertEqual(insertStatement.clearBindings(), .ok)
        XCTAssertEqual(insertStatement.reset(), .ok)

        XCTAssertEqual(insertStatement.bindInt(2, at: 1), .ok)
        XCTAssertEqual(insertStatement.step(), .done)
        XCTAssertEqual(insertStatement.clearBindings(), .ok)
        XCTAssertEqual(insertStatement.reset(), .ok)

        XCTAssertEqual(insertStatement.finalize(), .ok)

        let selectStatement: Statement = {
            var statement = Statement()
            XCTAssertEqual(statement.prepare("SELECT num, my_five() as nop FROM t;", for: database), .ok)
            return statement
        }()

        XCTAssertEqual(selectStatement.step(), .row)
        XCTAssertEqual(selectStatement.columnInt(at: 0), 1)
        XCTAssertEqual(selectStatement.columnInt(at: 1), 5)

        XCTAssertEqual(selectStatement.step(), .row)
        XCTAssertEqual(selectStatement.columnInt(at: 0), 2)
        XCTAssertEqual(selectStatement.columnInt(at: 1), 5)

        XCTAssertEqual(selectStatement.step(), .done)

        XCTAssertEqual(selectStatement.finalize(), .ok)

        let countStatement: Statement = {
            var statement = Statement()
            XCTAssertEqual(statement.prepare("SELECT my_count() as count FROM t;", for: database), .ok)
            return statement
        }()

        XCTAssertEqual(countStatement.step(), .row)
        XCTAssertEqual(countStatement.columnInt(at: 0), 2)

        XCTAssertEqual(countStatement.step(), .done)

        XCTAssertEqual(countStatement.finalize(), .ok)
    }

}
