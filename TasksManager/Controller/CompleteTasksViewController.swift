//
//  CompleteTasksViewController.swift
//  TasksManager
//
//  Created by Aleksey on 07.10.2021.
//  Copyright © 2021 Aleksey. All rights reserved.
//

import UIKit

class CompleteTasksViewController: UIViewController {

    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        tableView.delegate = self
        tableView.dataSource = self
        constraintsForTable()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

extension CompleteTasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasksTestComplete.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value2, reuseIdentifier: nil)
            cell.textLabel?.text = tasksTestComplete[indexPath.row].title
            cell.detailTextLabel?.text = tasksTestComplete[indexPath.row].content
    return cell
    }
}

extension CompleteTasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction.init(style: .destructive, title: "Delete") {
            _,_,_ in
            tasksTestComplete.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let swipeDelete = UISwipeActionsConfiguration.init(actions: [actionDelete])
    return swipeDelete
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionTranslate = UIContextualAction.init(style: .normal, title: "To Now") {
            _,_,_ in
            tasksTestNow.insert(tasksTestComplete[indexPath.row], at: 0)
            tasksTestComplete.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let swipeTranslate = UISwipeActionsConfiguration.init(actions: [actionTranslate])
    return swipeTranslate
    }
}

//MARK: Create on View and Setup Table

extension CompleteTasksViewController {
    func constraintsForTable() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 750)
            ])
    }
}
