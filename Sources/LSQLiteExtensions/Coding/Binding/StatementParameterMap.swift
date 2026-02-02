import LSQLite

func statementParameterMap(for statement: Statement) throws -> [String: Int32] {
    let count = Int(statement.bindingCount)
    guard count > 0 else {
        return [:]
    }
    var map: [String: Int32] = [:]
    map.reserveCapacity(count)
    for index in 1...count {
        let index32 = Int32(index)
        guard let name = statement.bindingName(at: index32) else {
            throw StatementCodingFailure.invalidParameter
        }
        guard name.hasPrefix(":") else {
            throw StatementCodingFailure.invalidParameter
        }
        let trimmed = String(name.dropFirst())
        guard !trimmed.isEmpty else {
            throw StatementCodingFailure.invalidParameter
        }
        if map[trimmed] != nil {
            throw StatementCodingFailure.duplicateParameter
        }
        map[trimmed] = index32
    }
    return map
}
