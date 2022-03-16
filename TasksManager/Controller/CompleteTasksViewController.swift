import UIKit
import RealmSwift

class CompleteTasksViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 62/255, green: 190/255, blue: 255/255, alpha: 1)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: idCustomCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if tabBarSet == false {
            constraintsForTable()
            tabBarSet = true
        }
        self.tasksNowArray = realm.objects(TasksNowStorage.self)
        self.tasksCompleteArray = realm.objects(TasksCompleteStorage.self)
        self.tableView.reloadData()
    }
    
    var realm = try! Realm()
    var tasksNowArray: Results<TasksNowStorage>!
    var tasksCompleteArray: Results<TasksCompleteStorage>!
    
    var tabBarSet: Bool = false
    
    var tabBarHeight: CGFloat?
    
    func setTabBarHeight(height: CGFloat) {
        self.tabBarHeight = height
    }
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 10
        tableView.showsVerticalScrollIndicator = false
    return tableView
    }()

    let idCustomCell = "idCustomCell"
    
}

extension CompleteTasksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasksCompleteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCustomCell, for: indexPath) as! CustomCell
        cell.taskTitle.text = tasksCompleteArray[indexPath.row].taskCompleteTitle
        cell.taskContent.text = tasksCompleteArray[indexPath.row].taskCompleteContent
    return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sheetVC = CompleteTasksBottomSheet()
        if let sheet = sheetVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        sheetVC.setIndexPath(indexPath: indexPath)
        sheetVC.setHomeVC(VC: self)
        self.present(sheetVC, animated: true)
    }
    
}

extension CompleteTasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction.init(style: .destructive, title: "Delete") {
            _,_,_ in
            try! self.realm.write {
                self.realm.delete(self.tasksCompleteArray[indexPath.row])
            }
            tableView.reloadData()
        }
        let swipeDelete = UISwipeActionsConfiguration.init(actions: [actionDelete])
    return swipeDelete
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionTranslate = UIContextualAction.init(style: .normal, title: "To Now") {
            _,_,_ in
            try! self.realm.write {
                let task = TasksNowStorage(value: [self.tasksCompleteArray[indexPath.row].taskCompleteTitle, self.tasksCompleteArray[indexPath.row].taskCompleteContent])
                self.realm.add(task)
                self.realm.delete(self.tasksCompleteArray[indexPath.row])
            }
            tableView.reloadData()
        }
        let swipeTranslate = UISwipeActionsConfiguration.init(actions: [actionTranslate])
    return swipeTranslate
    }

}

extension CompleteTasksViewController {
    
    func constraintsForTable() {
        self.view.addSubview(tableView)
        guard let height = self.tabBarHeight else { return }
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -height - 15)
            ])
    }

}
