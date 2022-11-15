@testable import DirectoryApp
import XCTest

class HTTPURLExtensionTests: XCTestCase {
    
    func testIsHttpResponseValidUpperBound() {
        // given
        let urlString = "google.com"
        let url = URL(string: urlString)!
        let response = HTTPURLResponse(url: url, statusCode: 299, httpVersion: nil, headerFields: nil)
        
        //when
        let isValidResponse = response!.isHttpResponseValid
        
        //then
        XCTAssertTrue(isValidResponse)
    }
    
    func testIsHttpResponseValidLowerBound() {
        // given
        let urlString = "google.com"
        let url = URL(string: urlString)!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //when
        let isValidResponse = response!.isHttpResponseValid
        
        //then
        XCTAssertTrue(isValidResponse)
    }
    
    func testIsHttpResponseValidFailsOutOfBounds() {
        // given
        let urlString = "google.com"
        let url = URL(string: urlString)!
        let response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        //when
        let isValidResponse = response!.isHttpResponseValid
        
        //then
        XCTAssertFalse(isValidResponse)
    }

}
