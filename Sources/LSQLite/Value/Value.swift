public struct Value: RawRepresentable {
    public let rawValue: OpaquePointer?

    @inlinable public init(rawValue: OpaquePointer?) {
        self.rawValue = rawValue
    }
}
