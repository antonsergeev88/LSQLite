@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
@frozen public struct Subtype: Equatable {
    public let rawValue: UInt32

    @inlinable public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
}
