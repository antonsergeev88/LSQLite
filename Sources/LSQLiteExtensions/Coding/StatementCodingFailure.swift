enum StatementCodingFailure: Error {
    case invalidParameter
    case duplicateParameter
    case unsupportedValue
    case unsupportedContainer
    case invalidColumn
    case duplicateColumn
    case missingColumn
    case typeMismatch
}
