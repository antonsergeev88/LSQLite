import MissedSwiftSQLite

extension Mutex {
    /// Mutex type constants used when allocating or requesting a static mutex.
    ///
    /// Related SQLite: `sqlite3_mutex_alloc`, `SQLITE_MUTEX_FAST`, `SQLITE_MUTEX_RECURSIVE`, `SQLITE_MUTEX_STATIC_*`
    @frozen public struct MutexType: Equatable, RawRepresentable, CustomDebugStringConvertible {
        public let rawValue: Int32

        @inlinable public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let fast = Self(rawValue: SQLITE_MUTEX_FAST)
        public static let recursive = Self(rawValue: SQLITE_MUTEX_RECURSIVE)
        public static let staticMaster = Self(rawValue: SQLITE_MUTEX_STATIC_MASTER)
        public static let staticMem = Self(rawValue: SQLITE_MUTEX_STATIC_MEM)
        public static let staticMem2 = Self(rawValue: SQLITE_MUTEX_STATIC_MEM2)
        public static let staticOpen = Self(rawValue: SQLITE_MUTEX_STATIC_OPEN)
        public static let staticPrng = Self(rawValue: SQLITE_MUTEX_STATIC_PRNG)
        public static let staticLRU = Self(rawValue: SQLITE_MUTEX_STATIC_LRU)
        public static let staticLRU2 = Self(rawValue: SQLITE_MUTEX_STATIC_LRU2)
        public static let statucPMem = Self(rawValue: SQLITE_MUTEX_STATIC_PMEM)
        public static let staticApp1 = Self(rawValue: SQLITE_MUTEX_STATIC_APP1)
        public static let staticApp2 = Self(rawValue: SQLITE_MUTEX_STATIC_APP2)
        public static let staticApp3 = Self(rawValue: SQLITE_MUTEX_STATIC_APP3)
        public static let staticVFS1 = Self(rawValue: SQLITE_MUTEX_STATIC_VFS1)
        public static let staticVFS2 = Self(rawValue: SQLITE_MUTEX_STATIC_VFS2)
        public static let staticVFS3 = Self(rawValue: SQLITE_MUTEX_STATIC_VFS3)

        /// Debug label for the mutex type.
        ///
        /// Related SQLite: `sqlite3_mutex_alloc`, `SQLITE_MUTEX_FAST`, `SQLITE_MUTEX_RECURSIVE`, `SQLITE_MUTEX_STATIC_*`
        public var debugDescription: String {
            switch self {
            case .fast: return "SQLITE_MUTEX_FAST"
            case .recursive: return "SQLITE_MUTEX_RECURSIVE"
            case .staticMaster: return "SQLITE_MUTEX_STATIC_MASTER"
            case .staticMem: return "SQLITE_MUTEX_STATIC_MEM"
            case .staticMem2: return "SQLITE_MUTEX_STATIC_MEM2"
            case .staticOpen: return "SQLITE_MUTEX_STATIC_OPEN"
            case .staticPrng: return "SQLITE_MUTEX_STATIC_PRNG"
            case .staticLRU: return "SQLITE_MUTEX_STATIC_LRU"
            case .staticLRU2: return "SQLITE_MUTEX_STATIC_LRU2"
            case .statucPMem: return "SQLITE_MUTEX_STATIC_PMEM"
            case .staticApp1: return "SQLITE_MUTEX_STATIC_APP1"
            case .staticApp2: return "SQLITE_MUTEX_STATIC_APP2"
            case .staticApp3: return "SQLITE_MUTEX_STATIC_APP3"
            case .staticVFS1: return "SQLITE_MUTEX_STATIC_VFS1"
            case .staticVFS2: return "SQLITE_MUTEX_STATIC_VFS2"
            case .staticVFS3: return "SQLITE_MUTEX_STATIC_VFS3"
            default: return "MutexType(rawValue: \(rawValue))"
            }
        }
    }

    /// Allocates a mutex of the requested type (dynamic or static).
    /// - Parameter type: Mutex type to obtain.
    /// - Returns: A mutex handle or `nil` if allocation fails.
    ///
    /// Related SQLite: `sqlite3_mutex_alloc`, `SQLITE_MUTEX_FAST`, `SQLITE_MUTEX_RECURSIVE`, `SQLITE_MUTEX_STATIC_*`
    @inlinable public static func alloc(_ type: MutexType) -> Mutex? {
        sqlite3_mutex_alloc(type.rawValue).map(Mutex.init(rawValue:))
    }

    /// Releases a dynamically allocated mutex.
    ///
    /// Related SQLite: `sqlite3_mutex_free`
    @inlinable public func free() {
        sqlite3_mutex_free(rawValue)
    }
}
