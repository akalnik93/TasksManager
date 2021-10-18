//
//  NowTasksViewController.swift
//  TasksManager
//
//  Created by Aleksey on 07.10.2021.
//  Copyright © 2021 Aleksey. All rights reserved.
//

import UIKit

class NowTasksViewController: UIViewController {
    
    let tableView : UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
    }()
    
    let addTaskButton: UIButton = {
        let button = UIButton()
        button.setTitle("AddTask", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Calibri", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openAlert), for: .touchUpInside)
    return button
    }()
    
    @objc private func openAlert() {
        let alertController : UIAlertController = {
            let alertController = UIAlertController.init(title: "Создать новую задачу", message: "Введите название и описание задачи", preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.placeholder = "Название"
            }
            alertController.addTextField { textField in
                textField.placeholder = "Описание"
            }
            return alertController
        }()
        let createButton = UIAlertAction(title: "Создать", style: .default) {
            _ in
            let taskTitle = alertController.textFields?[0].text ?? ""
            let taskContent = alertController.textFields?[1].text ?? ""
            let task = Task(title: taskTitle, content: taskContent, property: .now)
            tasksTestNow.append(task)
            self.tableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Закрыть", style: .destructive)
        alertController.addAction(createButton)
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        tableView.delegate = self
        tableView.dataSource = self
        constraintsForTable()
        
        contraintsForButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

extension NowTasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasksTestNow.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value2, reuseIdentifier: nil)
            cell.textLabel?.text = tasksTestNow[indexPath.row].title
            cell.detailTextLabel?.text = tasksTestNow[indexPath.row].content
    return cell
    }
}
    
extension NowTasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction.init(style: .destructive, title: "Delete") {
            _,_,_ in
            tasksTestNow.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let swipeDelete = UISwipeActionsConfiguration.init(actions: [actionDelete])
    return swipeDelete
        }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionTranslate = UIContextualAction.init(style: .normal, title: "To complete") {
            _,_,_ in
            tasksTestComplete.insert(tasksTestNow[indexPath.row], at: 0)
            tasksTestNow.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let swipeTranslate = UISwipeActionsConfiguration.init(actions: [actionTranslate])
    return swipeTranslate
    }
}

//MARK: Create on View and Setup Table
    
extension NowTasksViewController {
    func constraintsForTable() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 750)
            ])
    }
}

// MARK: Create on View and Setup Button

extension NowTasksViewController {
    func contraintsForButton() {
        view.addSubview(addTaskButton)
        NSLayoutConstraint.activate([
            addTaskButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 0),
            addTaskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            addTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            addTaskButton.heightAnchor.constraint(equalToConstant: 60)
//            addTaskButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            addTaskButton.bottomAnchor.constraint(equalTo: tabBarController?.tabBar.heightAnchor.accessibilityFrame.size.height)
            ])
    }
}
