//
//  CompleteTasksViewController.swift
//  TasksManager
//
//  Created by Aleksey on 07.10.2021.
//  Copyright © 2021 Aleksey. All rights reserved.
//

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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        constraintsForTable()
        self.tasksNowArray = realm.objects(TasksNowStorage.self)
        self.tasksCompleteArray = realm.objects(TasksCompleteStorage.self)
        tableView.reloadData()
    }
}

extension CompleteTasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasksCompleteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value2, reuseIdentifier: nil)
            cell.textLabel?.text = tasksCompleteArray[indexPath.row].taskCompleteTitle
            cell.detailTextLabel?.text = tasksCompleteArray[indexPath.row].taskCompleteContent
    return cell
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

//Create on View and Setup Table
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
