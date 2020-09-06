@frozen public struct Mutex: RawRepresentable {
    public internal(set) var rawValue: OpaquePointer?

    public init(rawValue: OpaquePointer? = nil) {
        self.rawValue = rawValue
    }
}
