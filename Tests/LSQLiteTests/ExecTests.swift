import XCTest
import LSQLite

class ExecTests: XCTestCase {

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
        XCTAssertEqual(database.exec("CREATE TABLE t(num INTEGER, txt TEXT);"), .ok)
        XCTAssertEqual(database.exec("INSERT INTO t VALUES(1, 'text1');"), .ok)
        XCTAssertEqual(database.exec("INSERT INTO t VALUES(2, NULL);"), .ok)
        let counter = RefWrappedValue(0)
        let resultCode = database.exec("SELECT num, txt FROM t;", userData: Unmanaged.passUnretained(counter).toOpaque()) { userData, count, values, columns in
            let counter = Unmanaged<RefWrappedValue<Int>>.fromOpaque(userData!).takeUnretainedValue()
            counter.value += 1
            let mappedValues: [String: String] = {
                var typedValues: [String?] = []
                var typedColumns: [String] = []
                for i in 0..<Int(count) {
                    typedValues.append(
                        values
                            .map { $0.advanced(by: i) }
                            .flatMap { $0.pointee }
                            .flatMap { String(cString: $0) }
                    )
                    typedColumns.append(
                        columns
                            .map { $0.advanced(by: i) }
                            .flatMap { $0.pointee }
                            .map { String(cString: $0) }!
                    )
                }
                return zip(typedColumns, typedValues).reduce(into: [:]) { result, pair in
                    result[pair.0] = pair.1
                }
            }()
            switch counter.value {
            case 1:
                XCTAssertEqual(mappedValues["num"], "1")
                XCTAssertEqual(mappedValues["txt"], "text1")
            case 2:
                XCTAssertEqual(mappedValues["num"], "2")
                XCTAssertEqual(mappedValues["txt"], nil)
            default:
                XCTFail()
            }
            return Database.ExecCallbackResult.continue.rawValue
        }
        XCTAssertEqual(resultCode, .ok)
    }
}
