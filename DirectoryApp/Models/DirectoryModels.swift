import Foundation

enum EmployeeType: String {
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    case contractor = "CONTRACTOR"
}

struct EmployeeDirectory: Codable, Equatable {
    let employees: [Employee]
}

struct Employee: Codable, Hashable {
    let uuid: String
    let name: String
    let phoneNumber: String?
    let emailAddress: String
    let biography: String?
    let smallPhotoURL: String?
    let largePhotoURL: String?
    let team: String
    let employeeType: EmployeeType.RawValue
    
    enum CodingKeys: String, CodingKey {
        case uuid, biography, team
        case name = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case smallPhotoURL = "photo_url_small"
        case largePhotoURL = "photo_url_large"
        case employeeType = "employee_type"
    }
}
