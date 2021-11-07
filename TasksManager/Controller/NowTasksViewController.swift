//
//  NowTasksViewController.swift
//  TasksManager
//
//  Created by Aleksey on 07.10.2021.
//  Copyright © 2021 Aleksey. All rights reserved.
//

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
    return tableView
    }()
    
    let addTaskButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openAlert), for: .touchUpInside)
        button.layer.cornerRadius = 25

    return button
    }()
    
    @objc private func openAlert() {
        let alertController: UIAlertController = {
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
            let task = TasksNowStorage(value: [taskTitle, taskContent])
            try! self.realm.write {
                self.realm.add(task)
            }
            self.tableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Закрыть", style: .destructive)
        alertController.addAction(createButton)
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.backgroundColor = UIColor.white.cgColor
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if tabBarSet == false {
            contraintsForButtonView(on: self.view)
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
        let cell = UITableViewCell(style: .value2, reuseIdentifier: nil)
            cell.textLabel?.text = tasksNowArray[indexPath.row].taskNowTitle
            cell.detailTextLabel?.text = tasksNowArray[indexPath.row].taskNowContent
    return cell
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
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.addTaskButton.topAnchor)
            ])
    }

    func contraintsForButton() {
        self.view.addSubview(addTaskButton)
        guard let height = self.tabBarHeight else { return }
        NSLayoutConstraint.activate([
            addTaskButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -height),
            addTaskButton.heightAnchor.constraint(equalToConstant: 50),
            addTaskButton.widthAnchor.constraint(equalToConstant: 50),
            addTaskButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
        addTaskButton.backgroundColor = .black
    }
    
    func getPath() -> UIBezierPath {
        let height = self.tabBarHeight ?? 0
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: self.view.frame.height - height + 20))
        path.addLine(to: CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height - height - 30))
        path.addLine(to: CGPoint(x: self.view.frame.width , y: self.view.frame.height - height + 20))
    return path
    }
    
    func contraintsForButtonView(on view: UIView) {
        let shapeLayer = CAShapeLayer()
        self.view.layer.addSublayer(shapeLayer)
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 40
        shapeLayer.path = getPath().cgPath
    }
}
