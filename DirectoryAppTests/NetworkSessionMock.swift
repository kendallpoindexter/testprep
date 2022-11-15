@testable import DirectoryApp
import Foundation

class NetworkSessionMock: NetworkSession {
    var mockGetData: ((URL, (Data?, URLResponse?, Error?) -> Void) -> Void)?
    
    func getData(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        mockGetData?(url, completion)
    }
}
