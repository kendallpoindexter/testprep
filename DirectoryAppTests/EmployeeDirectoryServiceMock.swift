@testable import DirectoryApp
import Foundation

class EmployeeDirectoryServiceMock: EmployeeDirectoryFetchable {
    var mockFetchEmployeeDirectory: (((Result<EmployeeDirectory, Error>) -> Void) -> Void)?
    
    func fetchEmployeeDirectory(completion: @escaping (Result<EmployeeDirectory, Error>) -> Void) {
        mockFetchEmployeeDirectory?(completion)
    }
}
