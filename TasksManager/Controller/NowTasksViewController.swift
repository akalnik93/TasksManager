//
//  NowTasksViewController.swift
//  TasksManager
//
//  Created by Aleksey on 07.10.2021.
//  Copyright © 2021 Aleksey. All rights reserved.
//

import UIKit

class NowTasksViewController: UIViewController {
    
    var tabBarSet: Bool = false
    
    var tabBarHeight : CGFloat?
    
    func setTabBarHeight(height : CGFloat) {
        self.tabBarHeight = height
    }
    
    let tableView : UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
    }()
    
    let addTaskButton: UIButton = {
        let button = UIButton()
        button.setTitle("TASK", for: .normal)
        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = UIFont(name: "Calibri", size: 27)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openAlert), for: .touchUpInside)
        button.layer.cornerRadius = 30
//        button.clipsToBounds = true
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
        self.view.backgroundColor = .white
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if tabBarSet == false {
            contraintsForButton()
            constraintsForTable()
            tabBarSet = true
        }
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

extension NowTasksViewController {
    //MARK: Create on View and Setup Table
    func constraintsForTable() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.addTaskButton.topAnchor)
            ])
    }
    //Create on View and Setup Button
    func contraintsForButton() {
        self.view.addSubview(addTaskButton)
        guard let height = self.tabBarHeight else { return }
        NSLayoutConstraint.activate([
            addTaskButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -height - self.view.safeAreaInsets.bottom),
            addTaskButton.heightAnchor.constraint(equalToConstant: 60),
            addTaskButton.widthAnchor.constraint(equalToConstant: 60),
            addTaskButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
        addTaskButton.backgroundColor = .gray
    }
}
