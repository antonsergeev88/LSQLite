import Foundation
import LSQLite

extension Statement {
    /// Decodes the current row into a value using column names as keys.
    /// - Parameter type: Type to decode from the current row.
    /// - Returns: The decoded value, or nil on mismatch or unsupported values.
    ///
    /// Only top-level keyed containers are supported. Coding keys must match the
    /// result column names exactly. Supported value types are `nil`, `Data`,
    /// `String`, `Int` (64-bit), and `Double`.
    ///
    /// Related SQLite: `sqlite3_column_count`, `sqlite3_column_name`, `sqlite3_column_blob`, `sqlite3_column_bytes`, `sqlite3_column_text`, `sqlite3_column_int64`, `sqlite3_column_double`, `sqlite3_column_type`
    public func row<Row: Decodable>(_ type: Row.Type = Row.self) -> Row? {
        do {
            let decoder = try StatementRowDecoder(statement: self)
            let value = try Row(from: decoder)
            if decoder.failure != nil {
                return nil
            }
            if decoder.decodedColumnCount != decoder.columnCount {
                return nil
            }
            return value
        } catch {
            return nil
        }
    }
}
