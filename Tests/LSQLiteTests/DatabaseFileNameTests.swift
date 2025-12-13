import XCTest
import LSQLite

class DatabaseFileNameTests: XCTestCase {

    func testFileNameConstantsHaveStableCStringStorage() {
        let memoryPointer = Database.FileName.memory.rawValue
        let temporaryPointer = Database.FileName.temporary.rawValue

        XCTAssertEqual(String(cString: memoryPointer), ":memory:")
        XCTAssertEqual(String(cString: temporaryPointer), "")

        XCTAssertEqual(memoryPointer, Database.FileName.memory.rawValue)
        XCTAssertEqual(temporaryPointer, Database.FileName.temporary.rawValue)
    }
}
