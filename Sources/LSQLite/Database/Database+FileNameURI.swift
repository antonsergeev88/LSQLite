extension Database.FileName {
    /// Components used to build SQLite URI filenames.
    ///
    /// Related SQLite: "URI filenames", `sqlite3_open_v2`, `SQLITE_OPEN_URI`
    public enum URI {
        /// URI scheme component.
        ///
        /// Note: SQLite only interprets URIs that use the `"file"` scheme.
        ///
        /// Related SQLite: "URI filenames", `"file:"`
        @frozen public struct Scheme: RawRepresentable, Sendable {
            public let rawValue: String

            @inlinable public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// SQLite file URI scheme.
            ///
            /// Related SQLite: `"file:"`
            public static let file = Self(rawValue: "file")
        }

        /// URI authority component.
        ///
        /// Related SQLite: "URI filenames (authority)"
        @frozen public struct Authority: RawRepresentable, Sendable {
            public let rawValue: String

            @inlinable public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// Empty authority (`file:///path`).
            ///
            /// Related SQLite: "URI filenames (authority)"
            public static let empty = Self(rawValue: "")

            /// `localhost` authority (`file://localhost/path`).
            ///
            /// Related SQLite: "URI filenames (authority)"
            public static let localhost = Self(rawValue: "localhost")
        }

        /// URI path component.
        ///
        /// Related SQLite: "URI filenames (path)", `sqlite3_open_v2`
        @frozen public struct Path: RawRepresentable, Sendable {
            public let rawValue: String

            @inlinable public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// Creates a path component by escaping delimiters reserved by SQLite URI parsing.
            /// - Parameter unescaped: Path text that will be percent-escaped for `?`, `#`, and `%`.
            ///
            /// Related SQLite: "URI filenames (path)", escape sequences (`%HH`)
            @inlinable public init(_ unescaped: String) {
                self.rawValue = URI.percentEncode(unescaped, escaping: { byte in
                    byte == UInt8(ascii: "?") || byte == UInt8(ascii: "#") || byte == UInt8(ascii: "%")
                })
            }

            @inlinable func requiringLeadingSlash() -> Self {
                guard !rawValue.isEmpty, !rawValue.hasPrefix("/") else { return self }
                return Self(rawValue: "/" + rawValue)
            }
        }

        /// URI query component (without the leading `?`).
        ///
        /// Related SQLite: "URI filenames (query string)"
        @frozen public struct Query: RawRepresentable, Sendable {
            public let rawValue: String

            @inlinable public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// Creates a query component from query parameters.
            ///
            /// Related SQLite: "URI filenames (query parameters)"
            @inlinable public init(_ parameters: [QueryParameter]) {
                var result = ""
                result.reserveCapacity(parameters.count * 8)
                for (index, parameter) in parameters.enumerated() {
                    if index != 0 {
                        result.append("&")
                    }
                    result.append(parameter.key.rawValue)
                    result.append("=")
                    result.append(parameter.value.rawValue)
                }
                self.rawValue = result
            }
        }

        /// URI fragment component (without the leading `#`).
        ///
        /// Note: SQLite ignores fragments in URI filenames.
        ///
        /// Related SQLite: "URI filenames (fragment)"
        @frozen public struct Fragment: RawRepresentable, Sendable {
            public let rawValue: String

            @inlinable public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// Creates a fragment component by escaping `%`.
            ///
            /// Related SQLite: "URI filenames (fragment)", escape sequences (`%HH`)
            @inlinable public init(_ unescaped: String) {
                self.rawValue = URI.percentEncode(unescaped, escaping: { $0 == UInt8(ascii: "%") })
            }
        }

        /// URI query parameter key.
        ///
        /// Related SQLite: "URI filenames (query parameters)"
        @frozen public struct QueryKey: RawRepresentable, Sendable {
            public let rawValue: String

            @inlinable public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// Creates a key by escaping `%`, `&`, `=`, and `#`.
            ///
            /// Related SQLite: "URI filenames (query parameters)", escape sequences (`%HH`)
            @inlinable public init(_ unescaped: String) {
                self.rawValue = URI.percentEncode(unescaped, escaping: { byte in
                    byte == UInt8(ascii: "%")
                        || byte == UInt8(ascii: "&")
                        || byte == UInt8(ascii: "=")
                        || byte == UInt8(ascii: "#")
                })
            }
        }

        /// URI query parameter value.
        ///
        /// Related SQLite: "URI filenames (query parameters)"
        @frozen public struct QueryValue: RawRepresentable, Sendable {
            public let rawValue: String

            @inlinable public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// Creates a value by escaping `%`, `&`, `=`, and `#`.
            ///
            /// Related SQLite: "URI filenames (query parameters)", escape sequences (`%HH`)
            @inlinable public init(_ unescaped: String) {
                self.rawValue = URI.percentEncode(unescaped, escaping: { byte in
                    byte == UInt8(ascii: "%")
                        || byte == UInt8(ascii: "&")
                        || byte == UInt8(ascii: "=")
                        || byte == UInt8(ascii: "#")
                })
            }
        }

        /// URI query parameter key/value pair.
        ///
        /// Related SQLite: "URI filenames (query parameters)"
        @frozen public struct QueryParameter: Sendable {
            public let key: QueryKey
            public let value: QueryValue

            @inlinable public init(key: QueryKey, value: QueryValue) {
                self.key = key
                self.value = value
            }

            /// Creates a `cache=` query parameter.
            ///
            /// Related SQLite: `cache=shared`, `cache=private`
            @inlinable public static func cache(_ cache: Cache) -> Self {
                Self(key: QueryKey(rawValue: "cache"), value: QueryValue(rawValue: cache.rawValue))
            }

            /// Creates an `immutable=` query parameter.
            ///
            /// Related SQLite: `immutable=1`, `SQLITE_IOCAP_IMMUTABLE`
            @inlinable public static func immutable(_ value: Boolean) -> Self {
                Self(key: QueryKey(rawValue: "immutable"), value: QueryValue(rawValue: value.rawValue))
            }

            /// Creates a `mode=` query parameter.
            ///
            /// Related SQLite: `mode=ro`, `mode=rw`, `mode=rwc`, `mode=memory`
            @inlinable public static func mode(_ mode: Mode) -> Self {
                Self(key: QueryKey(rawValue: "mode"), value: QueryValue(rawValue: mode.rawValue))
            }

            /// Creates a `modeof=` query parameter.
            ///
            /// Related SQLite: `modeof=filename`
            @inlinable public static func modeof(_ filename: QueryValue) -> Self {
                Self(key: QueryKey(rawValue: "modeof"), value: filename)
            }

            /// Creates a `nolock=` query parameter.
            ///
            /// Related SQLite: `nolock=1`
            @inlinable public static func nolock(_ value: Boolean) -> Self {
                Self(key: QueryKey(rawValue: "nolock"), value: QueryValue(rawValue: value.rawValue))
            }

            /// Creates a `psow=` query parameter.
            ///
            /// Related SQLite: `psow=0`, `psow=1`
            @inlinable public static func psow(_ value: Boolean) -> Self {
                Self(key: QueryKey(rawValue: "psow"), value: QueryValue(rawValue: value.rawValue))
            }

            /// Creates a `vfs=` query parameter.
            ///
            /// Related SQLite: `vfs=NAME`, `sqlite3_vfs_register`
            @inlinable public static func vfs(_ vfs: VFS) -> Self {
                Self(key: QueryKey(rawValue: "vfs"), value: QueryValue(rawValue: vfs.rawValue))
            }
        }

        /// Value for the `mode=` query parameter.
        ///
        /// Related SQLite: `mode=ro`, `mode=rw`, `mode=rwc`, `mode=memory`
        @frozen public struct Mode: RawRepresentable, Sendable {
            public let rawValue: String

            @inlinable public init(rawValue: String) {
                self.rawValue = rawValue
            }

            public static let ro = Self(rawValue: "ro")
            public static let rw = Self(rawValue: "rw")
            public static let rwc = Self(rawValue: "rwc")
            public static let memory = Self(rawValue: "memory")
        }

        /// Value for the `cache=` query parameter.
        ///
        /// Related SQLite: `cache=shared`, `cache=private`
        @frozen public struct Cache: RawRepresentable, Sendable {
            public let rawValue: String

            @inlinable public init(rawValue: String) {
                self.rawValue = rawValue
            }

            public static let shared = Self(rawValue: "shared")
            public static let `private` = Self(rawValue: "private")
        }

        /// Boolean query parameter value wrapper.
        ///
        /// Related SQLite: boolean query parameters such as `immutable=1`, `nolock=1`, `psow=1`
        @frozen public struct Boolean: RawRepresentable, Sendable {
            public let rawValue: String

            @inlinable public init(rawValue: String) {
                self.rawValue = rawValue
            }

            public static let enabled = Self(rawValue: "1")
            public static let disabled = Self(rawValue: "0")
        }

        /// Value for the `vfs=` query parameter.
        ///
        /// Related SQLite: `vfs=NAME`, `sqlite3_vfs_register`
        @frozen public struct VFS: RawRepresentable, Sendable {
            public let rawValue: String

            @inlinable public init(rawValue: String) {
                self.rawValue = rawValue
            }
        }

        @usableFromInline
        static func percentEncode(_ string: String, escaping shouldEscape: (UInt8) -> Bool) -> String {
            var needsEscaping = false
            for byte in string.utf8 {
                if shouldEscape(byte) {
                    needsEscaping = true
                    break
                }
            }
            guard needsEscaping else { return string }

            var result = ""
            result.reserveCapacity(string.utf8.count)
            for scalar in string.unicodeScalars {
                guard scalar.isASCII else {
                    result.unicodeScalars.append(scalar)
                    continue
                }

                let byte = UInt8(scalar.value)
                if shouldEscape(byte) {
                    result.append("%")
                    result.append(Self.hexDigitUppercase(byte >> 4))
                    result.append(Self.hexDigitUppercase(byte & 0x0F))
                } else {
                    result.unicodeScalars.append(scalar)
                }
            }
            return result
        }

        @usableFromInline
        static func hexDigitUppercase(_ nibble: UInt8) -> Character {
            let nibble = nibble & 0x0F
            let base: UInt32 = nibble < 10 ? 48 : 55
            let value = base + UInt32(nibble)
            return Character(Unicode.Scalar(value)!)
        }
    }

    /// Creates a filename wrapper from URI components.
    ///
    /// The resulting string is suitable for passing into `sqlite3_open_v2` when URI processing is enabled.
    ///
    /// Related SQLite: "URI filenames", `sqlite3_open_v2`, `SQLITE_OPEN_URI`
    @inlinable public static func uri(
        scheme: URI.Scheme = .file,
        path: URI.Path,
        query: URI.Query? = nil,
        fragment: URI.Fragment? = nil
    ) -> Self {
        Self._uri(scheme: scheme, authority: nil, path: path, query: query, fragment: fragment)
    }

    /// Creates a filename wrapper from URI components.
    ///
    /// Related SQLite: "URI filenames", `sqlite3_open_v2`, `SQLITE_OPEN_URI`
    @inlinable public static func uri(
        scheme: URI.Scheme = .file,
        authority: URI.Authority,
        path: URI.Path? = nil,
        query: URI.Query? = nil,
        fragment: URI.Fragment? = nil
    ) -> Self {
        Self._uri(scheme: scheme, authority: authority, path: path, query: query, fragment: fragment)
    }

    @usableFromInline
    static func _uri(
        scheme: URI.Scheme,
        authority: URI.Authority?,
        path: URI.Path?,
        query: URI.Query?,
        fragment: URI.Fragment?
    ) -> Self {
        var result = ""
        result.reserveCapacity(32)

        result.append(scheme.rawValue)
        result.append(":")

        if let authority {
            result.append("//")
            result.append(authority.rawValue)
            if let path {
                result.append(path.requiringLeadingSlash().rawValue)
            }
        } else if let path {
            result.append(path.rawValue)
        }

        if let query {
            result.append("?")
            result.append(query.rawValue)
        }

        if let fragment {
            result.append("#")
            result.append(fragment.rawValue)
        }

        return Self(rawValue: result)
    }
}
