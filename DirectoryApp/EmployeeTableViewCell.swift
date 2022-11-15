import UIKit

class EmployeeTableViewCell: UITableViewCell {
    @IBOutlet weak var employeeImageView: UIImageView!
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    
   private let placeHolderImage = UIImage(systemName: "person.fill")
    
    func configureCell(employee: Employee) {
        guard let imageUrlString = employee.smallPhotoURL,
              let imageURL = URL(string: imageUrlString)
        else {
            employeeImageView.image = placeHolderImage
            return
        }
        
        employeeImageView.sd_setImage(with: imageURL, placeholderImage: placeHolderImage)
        employeeNameLabel.text = employee.name
        teamLabel.text = "Team: \(employee.team)"
    }
}
