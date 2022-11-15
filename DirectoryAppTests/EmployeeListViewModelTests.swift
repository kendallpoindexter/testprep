@testable import DirectoryApp
import XCTest

class EmployeeListViewModelTests: XCTestCase {
    
    var expectation: XCTestExpectation?
    
    func testFetchEmployeeDirectorySuccessfully() throws {
        // given
        let service = EmployeeDirectoryServiceMock()
        let viewModel = EmployeeListViewModel(service: service)
        let mockEmployeeDirectory = EmployeeDirectory(employees: [Employee(uuid: "0d8fcc12-4d0c-425c-8355-390b312b909c", name: "Justine Mason", phoneNumber: nil, emailAddress: "jmason.demo@squareup.com", biography: nil, smallPhotoURL: nil, largePhotoURL: nil, team: "Point of Sale", employeeType: "FULL_TIME")])
        
        viewModel.delegate = self
        
        self.expectation = self.expectation(description: "didFetchEmployeeDirectory delegate method was called")
        
        // when
        service.mockFetchEmployeeDirectory = { completion in
            completion(.success(mockEmployeeDirectory))
        }
        
        // then
        viewModel.fetchEmployeeDirectory()
        
        self.waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(viewModel.employeeList, mockEmployeeDirectory.employees)
    }
    
    func testFetchEmployeeDirectoryFailsWithError() {
        // given
        let service = EmployeeDirectoryServiceMock()
        let viewModel = EmployeeListViewModel(service: service)
        self.expectation = self.expectation(description: "didFailToFetchEmployeeDirectory gets called")
        
        viewModel.delegate = self
       
        // when
        service.mockFetchEmployeeDirectory = { completion in
            completion(.failure(NetworkErrors.invalidHttpResponse))
        }
        
        // then
        viewModel.fetchEmployeeDirectory()
        
        self.waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(viewModel.employeeList, [])
    }
}

extension EmployeeListViewModelTests: EmployeeListViewModelDelegate {
    func didFetchEmployeeDirectory() {
        expectation?.fulfill()
        expectation = nil
    }
    
    func didFailToFetchEmployeeDirectory(error: Error) {
        expectation?.fulfill()
        expectation = nil
    }
}
