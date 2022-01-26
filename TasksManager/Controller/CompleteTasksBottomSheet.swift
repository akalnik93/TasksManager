import UIKit
import RealmSwift

class CompleteTasksBottomSheet: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        contraintsForTitleTextField()
        contraintsForContentTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tasksCompleteArray = realm.objects(TasksCompleteStorage.self)
        self.titleTextField.text = self.tasksCompleteArray[self.indexPath.row].taskCompleteTitle
        self.contentTextView.text = self.tasksCompleteArray[self.indexPath.row].taskCompleteContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        try! self.realm.write {
            self.tasksCompleteArray[self.indexPath.row].taskCompleteTitle = self.titleTextField.text ?? ""
            self.tasksCompleteArray[self.indexPath.row].taskCompleteContent = self.contentTextView.text ?? ""
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.homeVC?.viewWillAppear(animated)
    }
        
    var titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        textField.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 30)
        return textField
    }()
    
    var contentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 10
        textView.font = UIFont(name: "TimesNewRomanPSMT", size: 20)
        return textView
    }()
    
    var realm = try! Realm()
    var tasksCompleteArray: Results<TasksCompleteStorage>!
    
    var indexPath : IndexPath = []
    
    func setIndexPath(indexPath : IndexPath) {
        self.indexPath = indexPath
    }
    
    var homeVC: UIViewController?
    
    func setHomeVC(VC: UIViewController) {
        self.homeVC = VC
    }
    
}

extension CompleteTasksBottomSheet {
    
    func contraintsForTitleTextField() {
        self.view.addSubview(titleTextField)
            NSLayoutConstraint.activate([
                titleTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
                titleTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35),
                titleTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -35),
                titleTextField.heightAnchor.constraint(equalToConstant: 30)
            ])
    }
    
    func contraintsForContentTextView() {
        self.view.addSubview(contentTextView)
            NSLayoutConstraint.activate([
                contentTextView.topAnchor.constraint(equalTo: self.titleTextField.bottomAnchor, constant: 20),
                contentTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35),
                contentTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -35),
                contentTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30)
            ])
    }
    
}
