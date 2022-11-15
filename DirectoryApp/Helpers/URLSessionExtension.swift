import Foundation

protocol NetworkSession {
    func getData(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func getData(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
    }
}
