import UIKit

extension UILabel {
    
    convenience init(font: UIFont?) {
        self.init()
        self.font = font
        self.textAlignment = .left
        self.adjustsFontSizeToFitWidth = true
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
