import Testing
import LSQLite

@Suite
struct DatabaseFileNameTests {
    @Test
    func constantsHaveExpectedRawValues() {
        #expect(Database.FileName.memory.rawValue == ":memory:")
        #expect(Database.FileName.temporary.rawValue == "")
    }

    @Test
    func uriFilenamesMatchSQLiteExamples() {
        #expect(Database.FileName.uri(path: .init(rawValue: "data.db")).rawValue == "file:data.db")
        #expect(
            Database.FileName.uri(authority: .empty, path: .init(rawValue: "/home/fred/data.db")).rawValue
                == "file:///home/fred/data.db"
        )
        #expect(
            Database.FileName.uri(authority: .localhost, path: .init(rawValue: "/home/fred/data.db")).rawValue
                == "file://localhost/home/fred/data.db"
        )
        #expect(
            Database.FileName.uri(authority: .localhost, path: .init(rawValue: "home/fred/data.db")).rawValue
                == "file://localhost/home/fred/data.db"
        )
        #expect(
            Database.FileName.uri(
                path: .init(rawValue: "data.db"),
                query: .init([.mode(.ro), .cache(.private)])
            ).rawValue == "file:data.db?mode=ro&cache=private"
        )
    }

    @Test
    func uriComponentInitializersPercentEncodeReservedDelimiters() {
        #expect(Database.FileName.URI.Path("data?.db#x%y").rawValue == "data%3F.db%23x%25y")
        #expect(Database.FileName.URI.QueryKey("a&b=c#d%").rawValue == "a%26b%3Dc%23d%25")
        #expect(Database.FileName.URI.QueryValue("a&b=c#d%").rawValue == "a%26b%3Dc%23d%25")
        #expect(Database.FileName.URI.Fragment("a%b").rawValue == "a%25b")
    }
}
