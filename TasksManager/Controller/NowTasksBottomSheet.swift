import UIKit
import RealmSwift

class NowTasksBottomSheet: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        contraintsForTitleTextField()
        contraintsForContentTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tasksNowArray = realm.objects(TasksNowStorage.self)
        self.titleTextField.text = self.tasksNowArray[self.indexPath.row].taskNowTitle
        self.contentTextView.text = self.tasksNowArray[self.indexPath.row].taskNowContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        try! self.realm.write {
            self.tasksNowArray[self.indexPath.row].taskNowTitle = self.titleTextField.text ?? ""
            self.tasksNowArray[self.indexPath.row].taskNowContent = self.contentTextView.text ?? ""
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
    var tasksNowArray: Results<TasksNowStorage>!
    
    var indexPath : IndexPath = []
    
    func setIndexPath(indexPath : IndexPath) {
        self.indexPath = indexPath
    }
    
    var homeVC: UIViewController?
    
    func setHomeVC(VC: UIViewController) {
        self.homeVC = VC
    }
    
}

extension NowTasksBottomSheet {
    
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
