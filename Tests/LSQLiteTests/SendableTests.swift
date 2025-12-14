import XCTest
import LSQLite
import MissedSwiftSQLite

final class SendableTests: XCTestCase {
    private func assertSendable<T: Sendable>(_ value: T, file: StaticString = #filePath, line: UInt = #line) {
        _ = value
    }

    func testPointerWrappersConformToSendable() {
        assertSendable(Database(rawValue: OpaquePointer(bitPattern: 0x1)!))
        assertSendable(Blob(rawValue: OpaquePointer(bitPattern: 0x2)!))
        assertSendable(Context(rawValue: OpaquePointer(bitPattern: 0x3)!))
        assertSendable(Mutex(rawValue: OpaquePointer(bitPattern: 0x4)!))
        assertSendable(Statement(rawValue: OpaquePointer(bitPattern: 0x5)!))
        assertSendable(Value(rawValue: OpaquePointer(bitPattern: 0x6)!))
        assertSendable(Database.FileName(rawValue: UnsafePointer<Int8>(bitPattern: 0x7)!))
    }

    func testPointerWrappersMoveAcrossDetachedTasks() async {
        let database = Database(rawValue: OpaquePointer(bitPattern: 0x10)!)
        let blob = Blob(rawValue: OpaquePointer(bitPattern: 0x11)!)
        let context = Context(rawValue: OpaquePointer(bitPattern: 0x12)!)
        let mutex = Mutex(rawValue: OpaquePointer(bitPattern: 0x13)!)
        let statement = Statement(rawValue: OpaquePointer(bitPattern: 0x14)!)
        let value = Value(rawValue: OpaquePointer(bitPattern: 0x15)!)
        let fileName = Database.FileName(rawValue: UnsafePointer<Int8>(bitPattern: 0x16)!)

        let detachedDatabase = await Task.detached { database }.value
        let detachedBlob = await Task.detached { blob }.value
        let detachedContext = await Task.detached { context }.value
        let detachedMutex = await Task.detached { mutex }.value
        let detachedStatement = await Task.detached { statement }.value
        let detachedValue = await Task.detached { value }.value
        let detachedFileName = await Task.detached { fileName }.value

        XCTAssertEqual(Int(bitPattern: detachedDatabase.rawValue), Int(bitPattern: database.rawValue))
        XCTAssertEqual(Int(bitPattern: detachedBlob.rawValue), Int(bitPattern: blob.rawValue))
        XCTAssertEqual(Int(bitPattern: detachedContext.rawValue), Int(bitPattern: context.rawValue))
        XCTAssertEqual(Int(bitPattern: detachedMutex.rawValue), Int(bitPattern: mutex.rawValue))
        XCTAssertEqual(Int(bitPattern: detachedStatement.rawValue), Int(bitPattern: statement.rawValue))
        XCTAssertEqual(Int(bitPattern: detachedValue.rawValue), Int(bitPattern: value.rawValue))
        XCTAssertEqual(Int(bitPattern: detachedFileName.rawValue), Int(bitPattern: fileName.rawValue))
    }
}
