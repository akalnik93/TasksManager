import UIKit

extension UITableView {
    
    convenience init() {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
    }

}
