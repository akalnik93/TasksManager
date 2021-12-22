import Foundation
import UIKit

class CustomCell: UITableViewCell {
    
    let taskTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 30)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let taskContent: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "TimesNewRomanPSMT", size: 20)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraintsTaskTitle()
        setConstraintsTaskContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraintsTaskTitle() {
        self.addSubview(taskTitle)
        NSLayoutConstraint.activate([
            taskTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            taskTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            taskTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.frame.width/2),
            taskTitle.heightAnchor.constraint(equalToConstant: 30)
            ])
    }
    
    func setConstraintsTaskContent() {
        self.addSubview(taskContent)
        NSLayoutConstraint.activate([
            taskContent.topAnchor.constraint(equalTo: self.taskTitle.bottomAnchor, constant: 10),
            taskContent.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            taskContent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            taskContent.heightAnchor.constraint(equalToConstant: 60)
            ])
    }

}
