@testable import DirectoryApp
import XCTest

class EmployeeDirectoryServiceTests: XCTestCase {
    
    func testFetchEmployeeDirectorySuccessfully() throws {
        // given
        let session = NetworkSessionMock()
        let service = EmployeeDirectoryService(session: session)
        let urlString = "google.com"
        let url = URL(string: urlString)!
        
        let data = """
                 {
                    \"employees\" : [
                        {
                      \"uuid\" : \"0d8fcc12-4d0c-425c-8355-390b312b909c\",

                      \"full_name\" : \"Justine Mason\",
                      \"email_address\" : \"jmason.demo@squareup.com\",
                      \"team\" : \"Point of Sale\",
                      \"employee_type\" : \"FULL_TIME\"
                    }
                        ]
            }
        """.data(using: .utf8)

        
        let mockEmployeeDirectory = EmployeeDirectory(employees: [Employee(uuid: "0d8fcc12-4d0c-425c-8355-390b312b909c", name: "Justine Mason", phoneNumber: nil, emailAddress: "jmason.demo@squareup.com", biography: nil, smallPhotoURL: nil, largePhotoURL: nil, team: "Point of Sale", employeeType: "FULL_TIME")])
        
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        session.mockGetData = { _, completion in
            completion(data, response, nil)
        }
        
        let expectation = XCTestExpectation(description: "Get back correct value")
        
        // when
        service.fetchEmployeeDirectory { result in
            switch result {
            case let .success(testData):
                XCTAssertEqual(testData, mockEmployeeDirectory)
                expectation.fulfill()
            case .failure:
                break
            }
        }
        self.wait(for: [expectation], timeout: 0.1)
    }
    
    func testFetchEmployeeDirectoryFailsWithMalformedData() {
        // given
        let session = NetworkSessionMock()
        let service = EmployeeDirectoryService(session: session)
        let urlString = "google.com"
        let url = URL(string: urlString)!
        
        let data = """
                 {
                    \"employees\" : [
                        {
                      \"uuid\" : \"0d8fcc12-4d0c-425c-8355-390b312b909c\",

                      \"full_name\" : \"Justine Mason\",
                      \"email_address\" : \"jmason.demo@squareup.com\",
                      \"employee_type\" : \"FULL_TIME\"
                    }
                        ]
            }
        """.data(using: .utf8)
        
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        session.mockGetData = { _, completion in
            completion(data, response, nil)
        }
        
        let expectation = XCTestExpectation(description: "Get a failedToDecodeData error")
        
        // when
        service.fetchEmployeeDirectory { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                XCTAssertEqual(error as! NetworkErrors, NetworkErrors.failedToDecodeData)
                expectation.fulfill()
            }
        }
        self.wait(for: [expectation], timeout: 0.1)
    }
    
    func testFetchEmployeeDirectoryFailsWithInvalidResponse() {
        // given
        let session = NetworkSessionMock()
        let service = EmployeeDirectoryService(session: session)
        let urlString = "google.com"
        let url = URL(string: urlString)!
        
        let data = """
                 {
                    \"employees\" : [
                        {
                      \"uuid\" : \"0d8fcc12-4d0c-425c-8355-390b312b909c\",

                      \"full_name\" : \"Justine Mason\",
                      \"email_address\" : \"jmason.demo@squareup.com\",
                      \"team\" : \"Point of Sale\",
                      \"employee_type\" : \"FULL_TIME\"
                    }
                        ]
            }
        """.data(using: .utf8)
        
        let response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        session.mockGetData = { _, completion in
            completion(data, response, nil)
        }
        
        let expectation = XCTestExpectation(description: "Get an invalidHttpResponse error")
        
        // when
        service.fetchEmployeeDirectory { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                XCTAssertEqual(error as! NetworkErrors, NetworkErrors.invalidHttpResponse)
                expectation.fulfill()
            }
        }
        self.wait(for: [expectation], timeout: 0.1)
    }
    
    func testFetchEmployeeDirectoryFailsWithNetworkSessionFailed() {
        // given
        let session = NetworkSessionMock()
        let service = EmployeeDirectoryService(session: session)
        let error = NetworkErrors.networkSessionFailed
        
        session.mockGetData = { _, completion in
            completion(nil, nil , error)
        }
        
        let expectation = XCTestExpectation(description: "Get an networkSessionFailed error")
        
        // when
        service.fetchEmployeeDirectory { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                XCTAssertEqual(error as! NetworkErrors, NetworkErrors.networkSessionFailed)
                expectation.fulfill()
            }
        }
        self.wait(for: [expectation], timeout: 0.1)
    }
}

