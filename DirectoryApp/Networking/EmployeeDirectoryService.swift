import Foundation

protocol EmployeeDirectoryFetchable {
    func fetchEmployeeDirectory(completion: @escaping (Result<EmployeeDirectory, Error>) -> Void)
}

struct EmployeeDirectoryService: EmployeeDirectoryFetchable {
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func fetchEmployeeDirectory(completion: @escaping (Result<EmployeeDirectory, Error>) -> Void) {
        guard let url = constructURL() else {
            completion(.failure(NetworkErrors.invalidURL))
            return
        }
        
        session.getData(with: url) { data, response, error in
            if error != nil {
                completion(.failure(NetworkErrors.networkSessionFailed))
            } else if let data = data, let httpResponse = response as? HTTPURLResponse {
                guard httpResponse.isHttpResponseValid else {
                    completion(.failure(NetworkErrors.invalidHttpResponse))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(EmployeeDirectory.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(NetworkErrors.failedToDecodeData))
                }
            }
        }
    }
    
    private func constructURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "s3.amazonaws.com"
        components.path = "/sq-mobile-interview/employees.json"
        
        return components.url
    }
}
