import Foundation
import LSQLite

extension Statement {
    /// Encodes and binds a value to the statement's named parameters.
    /// - Parameter binding: Value to encode and bind.
    /// - Returns: `true` when all parameters match and binding succeeds; otherwise `false`.
    ///
    /// Only top-level keyed containers are supported. Coding keys must match the
    /// statement parameter names after removing the leading ":" prefix. Keys
    /// must be emitted for every parameter; optional values must encode `nil`
    /// explicitly. Supported value types are `nil`, `Data`, `String`, `Int`
    /// (64-bit), and `Double`.
    ///
    /// Related SQLite: `sqlite3_bind_parameter_count`, `sqlite3_bind_parameter_name`, `sqlite3_bind_blob`, `sqlite3_bind_text`, `sqlite3_bind_int64`, `sqlite3_bind_double`, `sqlite3_bind_null`, `sqlite3_bind_zeroblob`
    public func bind<Binding: Encodable>(_ binding: Binding) -> Bool {
        do {
            let parameterMap = try statementParameterMap(for: self)
            let keyCollector = StatementKeyCollectorEncoder()
            try binding.encode(to: keyCollector)
            if keyCollector.failure != nil {
                return false
            }
            if keyCollector.keys != Set(parameterMap.keys) {
                return false
            }
            let encoder = StatementBindingEncoder(statement: self, parameterMap: parameterMap)
            try binding.encode(to: encoder)
            if encoder.failure != nil {
                return false
            }
            return true
        } catch {
            return false
        }
    }
}
