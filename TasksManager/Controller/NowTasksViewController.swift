import UIKit
import RealmSwift

class NowTasksViewController: UIViewController {
    
    var realm = try! Realm()
    var tasksNowArray: Results<TasksNowStorage>!
    var tasksCompleteArray: Results<TasksCompleteStorage>!
    
    var tabBarSet: Bool = false
    
    var tabBarHeight: CGFloat?
    
    func setTabBarHeight(height: CGFloat) {
        self.tabBarHeight = height
    }
    
    var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 10
    return tableView
    }()
    
    let idCustomCell = "idCustomCell"
    
    let addTaskButton: UIButton = {
        let button = UIButton()
        button.setTitle("add task", for: .normal)
        button.titleLabel?.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 15)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openAlert), for: .touchUpInside)
        button.layer.cornerRadius = 10
    return button
    }()
    
    @objc private func openAlert() {
        let alertController: UIAlertController = {
            let alertController = UIAlertController.init(title: "Add new task", message: "Enter title and content", preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.placeholder = "Title"
            }
            alertController.addTextField { textField in
                textField.placeholder = "Content"
            }
        return alertController
        }()
        let createButton = UIAlertAction(title: "Create", style: .default) {
            _ in
            let taskTitle = alertController.textFields?[0].text ?? ""
            let taskContent = alertController.textFields?[1].text ?? ""
            let task = TasksNowStorage(value: [taskTitle, taskContent])
            try! self.realm.write {
                self.realm.add(task)
            }
            self.tableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Close", style: .destructive)
        alertController.addAction(createButton)
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray4
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: idCustomCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if tabBarSet == false {
//            contraintsForButtonView(on: self.view)
            contraintsForButton()
            constraintsForTable()
            tabBarSet = true
        }
        self.tasksNowArray = realm.objects(TasksNowStorage.self)
        self.tasksCompleteArray = realm.objects(TasksCompleteStorage.self)
        self.tableView.reloadData()
    }

}

extension NowTasksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasksNowArray.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCustomCell, for: indexPath) as! CustomCell
        cell.taskTitle.text = tasksNowArray[indexPath.row].taskNowTitle
        cell.taskContent.text = tasksNowArray[indexPath.row].taskNowContent
    return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sheetVC = BottomSheet()
        if let sheet = sheetVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        self.present(sheetVC, animated: true)
    }
    
}

extension NowTasksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction.init(style: .destructive, title: "Delete") {
            _,_,_ in
            try! self.realm.write {
                self.realm.delete(self.tasksNowArray[indexPath.row])
            }
            self.tableView.reloadData()
        }
        let swipeDelete = UISwipeActionsConfiguration.init(actions: [actionDelete])
    return swipeDelete
        }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionTranslate = UIContextualAction.init(style: .normal, title: "To complete") {
            _,_,_ in
            try! self.realm.write {
                let task = TasksCompleteStorage(value: [self.tasksNowArray[indexPath.row].taskNowTitle, self.tasksNowArray[indexPath.row].taskNowContent])
                self.realm.add(task)
                self.realm.delete(self.tasksNowArray[indexPath.row])
            }
            self.tableView.reloadData()
        }
        let swipeTranslate = UISwipeActionsConfiguration.init(actions: [actionTranslate])
    return swipeTranslate
    }

}

extension NowTasksViewController {
    
    func constraintsForTable() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: self.addTaskButton.topAnchor, constant: -15)
            ])
    }

    func contraintsForButton() {
        self.view.addSubview(addTaskButton)
        guard let height = self.tabBarHeight else { return }
        NSLayoutConstraint.activate([
            addTaskButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 70),
            addTaskButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -70),
            addTaskButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -height + 10),
            addTaskButton.heightAnchor.constraint(equalToConstant: 35)
            ])
        addTaskButton.backgroundColor = .black
    }

// MARK: Old version button
//    func getPath() -> UIBezierPath {
//        let height = self.tabBarHeight ?? 0
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 15, y: self.view.frame.height - height))
//        path.addLine(to: CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height - height - 35))
//        path.addLine(to: CGPoint(x: self.view.frame.width , y: self.view.frame.height - height))
//        return path
//    }
//
//    func contraintsForButtonView(on view: UIView) {
//        let shapeLayer = CAShapeLayer()
//        self.view.layer.addSublayer(shapeLayer)
//        shapeLayer.strokeColor = UIColor.black.cgColor
//        shapeLayer.path = getPath().cgPath
//    }
//
}
