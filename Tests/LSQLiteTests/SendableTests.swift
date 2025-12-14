import Testing
import LSQLite
import MissedSwiftSQLite

@Suite
struct SendableTests {
    private func assertSendable<T: Sendable>(_ value: T) {
        _ = value
    }

    @Test
    func pointerWrappersConformToSendable() {
        assertSendable(Database(rawValue: OpaquePointer(bitPattern: 0x1)!))
        assertSendable(Blob(rawValue: OpaquePointer(bitPattern: 0x2)!))
        assertSendable(Context(rawValue: OpaquePointer(bitPattern: 0x3)!))
        assertSendable(Mutex(rawValue: OpaquePointer(bitPattern: 0x4)!))
        assertSendable(Statement(rawValue: OpaquePointer(bitPattern: 0x5)!))
        assertSendable(Value(rawValue: OpaquePointer(bitPattern: 0x6)!))
    }

    @Test
    func pointerWrappersMoveAcrossDetachedTasks() async {
        let database = Database(rawValue: OpaquePointer(bitPattern: 0x10)!)
        let blob = Blob(rawValue: OpaquePointer(bitPattern: 0x11)!)
        let context = Context(rawValue: OpaquePointer(bitPattern: 0x12)!)
        let mutex = Mutex(rawValue: OpaquePointer(bitPattern: 0x13)!)
        let statement = Statement(rawValue: OpaquePointer(bitPattern: 0x14)!)
        let value = Value(rawValue: OpaquePointer(bitPattern: 0x15)!)

        let detachedDatabase = await Task.detached { database }.value
        let detachedBlob = await Task.detached { blob }.value
        let detachedContext = await Task.detached { context }.value
        let detachedMutex = await Task.detached { mutex }.value
        let detachedStatement = await Task.detached { statement }.value
        let detachedValue = await Task.detached { value }.value

        #expect(Int(bitPattern: detachedDatabase.rawValue) == Int(bitPattern: database.rawValue))
        #expect(Int(bitPattern: detachedBlob.rawValue) == Int(bitPattern: blob.rawValue))
        #expect(Int(bitPattern: detachedContext.rawValue) == Int(bitPattern: context.rawValue))
        #expect(Int(bitPattern: detachedMutex.rawValue) == Int(bitPattern: mutex.rawValue))
        #expect(Int(bitPattern: detachedStatement.rawValue) == Int(bitPattern: statement.rawValue))
        #expect(Int(bitPattern: detachedValue.rawValue) == Int(bitPattern: value.rawValue))
    }
}
