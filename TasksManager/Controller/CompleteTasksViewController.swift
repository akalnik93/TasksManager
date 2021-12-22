import UIKit
import RealmSwift

class CompleteTasksViewController: UIViewController {
    
    var realm = try! Realm()
    var tasksNowArray: Results<TasksNowStorage>!
    var tasksCompleteArray: Results<TasksCompleteStorage>!
    
    var tabBarHeight: CGFloat?
    
    func setTabBarHeight(height: CGFloat) {
        self.tabBarHeight = height
    }
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
    }()

    let idCustomCell = "idCustomCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        constraintsForTable()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tasksNowArray = realm.objects(TasksNowStorage.self)
        self.tasksCompleteArray = realm.objects(TasksCompleteStorage.self)
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: idCustomCell)
        tableView.reloadData()
    }

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
        view.addSubview(tableView)
        guard let height = self.tabBarHeight else { return }
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: view.bounds.height - height)
            ])
    }

}
