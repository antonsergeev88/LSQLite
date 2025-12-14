import XCTest
import LSQLite

class DatabaseFileNameTests: XCTestCase {

    func testFileNameConstantsHaveExpectedRawValues() {
        XCTAssertEqual(Database.FileName.memory.rawValue, ":memory:")
        XCTAssertEqual(Database.FileName.temporary.rawValue, "")
    }
}
