import XCTest
import LSQLite

class FunctionTests: XCTestCase {

    var database: Database!

    override func setUpWithError() throws {
        try super.setUpWithError()
        database = try {
            var database: Database? = nil
            guard Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create, .memory]) == .ok else {
                if let database = database {
                    throw Error.result(database.lastErrorCode)
                } else {
                    throw Error.unknown
                }
            }
            return database
        }()
        let myFiveResultCode = database.createFunction(name: "my_five", argumentCount: 0, flags: .utf8, userData: nil, funcHandler: { context, _, _ in
            let context = Context(rawValue: context!)
            context.resultInt(5)
        })
        XCTAssertEqual(myFiveResultCode, .ok)
        let myCountResultCode = database.createFunction(name: "my_count", argumentCount: 0, flags: .utf8, userData: nil, stepHandler: { context, _, _ in
            let context = Context(rawValue: context!)
            let aggregatePointer = context.aggregateContext(size: Int32(MemoryLayout<Int32>.stride))
            guard let valuePointer = aggregatePointer?.assumingMemoryBound(to: Int32.self) else {
                context.resultNoMemoryError()
                return
            }
            valuePointer.pointee += 1
        }, finalHandler: { context in
            let context = Context(rawValue: context!)
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

    func testCreateDatabaseInsertRowRowsAndGetThemBack() throws {
        let createTableStatement: Statement = try {
            var statement: Statement? = nil
            let resultCode = Statement.prepare(&statement, sql: "CREATE TABLE t(num INTEGER);", for: database)
            guard resultCode == .ok, statement != nil else {
                throw Error.result(resultCode)
            }
            return statement!
        }()
        XCTAssertEqual(createTableStatement.step(), .done)
        XCTAssertEqual(createTableStatement.finalize(), .ok)

        let insertStatement: Statement = try {
            var statement: Statement? = nil
            let resultCode = Statement.prepare(&statement, sql: "INSERT INTO t VALUES(?);", for: database)
            guard resultCode == .ok, statement != nil else {
                throw Error.result(resultCode)
            }
            return statement!
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

        let selectStatement: Statement = try {
            var statement: Statement? = nil
            let resultCode = Statement.prepare(&statement, sql: "SELECT num, my_five() as nop FROM t;", for: database)
            guard resultCode == .ok, statement != nil else {
                throw Error.result(resultCode)
            }
            return statement!
        }()

        XCTAssertEqual(selectStatement.step(), .row)
        XCTAssertEqual(selectStatement.columnInt(at: 0), 1)
        XCTAssertEqual(selectStatement.columnInt(at: 1), 5)

        XCTAssertEqual(selectStatement.step(), .row)
        XCTAssertEqual(selectStatement.columnInt(at: 0), 2)
        XCTAssertEqual(selectStatement.columnInt(at: 1), 5)

        XCTAssertEqual(selectStatement.step(), .done)

        XCTAssertEqual(selectStatement.finalize(), .ok)

        let countStatement: Statement = try {
            var statement: Statement? = nil
            let resultCode = Statement.prepare(&statement, sql: "SELECT my_count() as count FROM t;", for: database)
            guard resultCode == .ok, statement != nil else {
                throw Error.result(resultCode)
            }
            return statement!
        }()

        XCTAssertEqual(countStatement.step(), .row)
        XCTAssertEqual(countStatement.columnInt(at: 0), 2)

        XCTAssertEqual(countStatement.step(), .done)

        XCTAssertEqual(countStatement.finalize(), .ok)
    }

}
