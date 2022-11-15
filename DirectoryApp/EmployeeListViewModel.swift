import Foundation

protocol EmployeeListViewModelDelegate: NSObject {
    func didFetchEmployeeDirectory()
    func didFailToFetchEmployeeDirectory(error: Error)
}

final class EmployeeListViewModel {
   private let service: EmployeeDirectoryFetchable
    
    var employeeList: [Employee] = []
    weak var delegate: EmployeeListViewModelDelegate?
    
    init(service: EmployeeDirectoryFetchable = EmployeeDirectoryService()) {
        self.service = service
    }
    
   @objc func fetchEmployeeDirectory() {
        service.fetchEmployeeDirectory { [weak self] result in
            switch result {
            case let .success(response):
                self?.employeeList = response.employees.sorted(by: { $1.name > $0.name })
                
                DispatchQueue.main.async {
                    self?.delegate?.didFetchEmployeeDirectory()
                }
                
            case let .failure(error):
                DispatchQueue.main.async {
                    self?.delegate?.didFailToFetchEmployeeDirectory(error: error)
                }
                print(error)
            }
        }
    }
}
