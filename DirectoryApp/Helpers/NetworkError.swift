import Foundation

enum NetworkErrors: Error {
    case failedToDecodeData
    case invalidHttpResponse
    case invalidURL
    case networkSessionFailed
}
