import UIKit

extension UITableView {
    func setEmptyState(with message: String) {
        let messageLabel = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: self.intrinsicContentSize))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .natural
        messageLabel.font = UIFont(name: "System", size: 20)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
