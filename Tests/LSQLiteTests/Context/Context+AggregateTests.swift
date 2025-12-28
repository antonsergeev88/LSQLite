import LSQLite
import Testing

@Suite("Context+Aggregate")
struct ContextAggregateTests {
    @Test("aggregateContext allocates state for aggregates")
    func aggregateContextAllocatesState() throws {
        var database: Database?
        try #require(Database.open(&database, at: .memory, withOpenFlags: [.readwrite, .create]) == .ok)
        let openDatabase = try #require(database)
        try #require(openDatabase.exec("CREATE TABLE agg(value INTEGER)") == .ok)
        try #require(openDatabase.exec("INSERT INTO agg(value) VALUES (1), (2), (3)") == .ok)

        var probe = AggregateProbe()
        #expect(openDatabase.createFunction(name: "ctx_count", argumentCount: 1, textEncoding: .utf8, userData: &probe, stepHandler: aggregateStep, finalHandler: aggregateFinal) == .ok)

        var statement: Statement?
        try #require(Statement.prepare(&statement, sql: "SELECT ctx_count(value) FROM agg", for: openDatabase) == .ok)
        let prepared = try #require(statement)
        #expect(prepared.step() == .row)
        #expect(prepared.columnInt64(at: 0) == 3)
        #expect(prepared.step() == .done)
        #expect(prepared.finalize() == .ok)

        #expect(probe.allocated)
        _ = openDatabase.close()
    }
}

private struct AggregateProbe {
    var allocated = false
}

private func aggregateStep(_ context: OpaquePointer?, _ valueCount: Int32, _ values: UnsafeMutablePointer<OpaquePointer?>?) {
    guard let context else {
        return
    }
    let wrapper = Context(rawValue: context)
    let buffer = wrapper.aggregateContext(size: Int32(MemoryLayout<Int64>.size))
    if let userData = wrapper.userData {
        let probe = userData.assumingMemoryBound(to: AggregateProbe.self)
        probe.pointee.allocated = (buffer != nil)
    }
    if let buffer {
        let countPointer = buffer.assumingMemoryBound(to: Int64.self)
        countPointer.pointee += 1
    }
}

private func aggregateFinal(_ context: OpaquePointer?) {
    guard let context else {
        return
    }
    let wrapper = Context(rawValue: context)
    let buffer = wrapper.aggregateContext(size: 0)
    if let buffer {
        let countPointer = buffer.assumingMemoryBound(to: Int64.self)
        wrapper.resultInt64(countPointer.pointee)
    } else {
        wrapper.resultInt64(0)
    }
}
