import Foundation

extension HTTPURLResponse {
    var isHttpResponseValid: Bool {
        return (200...299).contains(self.statusCode)
    }
}
