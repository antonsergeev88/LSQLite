import LSQLite

enum Error: Swift.Error {
    case result(ResultCode)
    case unknown
}
