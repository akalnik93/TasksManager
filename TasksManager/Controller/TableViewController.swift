////
////  TableViewController.swift
////  TasksManager
////
////  Created by Aleksey on 11.10.2021.
////  Copyright © 2021 Aleksey. All rights reserved.
////
//
//import UIKit
//
//class TableViewController: UIViewController {
//    
//    let tableView : UITableView = {
//        let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
//    //let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
//    
////    var tasks = [Task(title: "1", content: "1", property: .now), Task(title: "2", content: "2", property: .now), Task(title: "3", content: "3", property: .now)]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        //        title = "Now"
//        
//        let tabBarItemNow = UITabBarItem(tabBarSystemItem: .more, tag: 0)
//        self.tabBarItem = tabBarItemNow
//        
////        let tableView = UITableView(frame: CGRect(x: 20, y: 20, width: 200, height: 1000), style: UITableView.Style.plain)
//        
//        //view.addSubview(tableView)
//        constraintsForTable()
//        //view.addSubview(button)
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//
//    }
//}
//
////MARK: TABLE PROTOCOLS
//
//extension TableViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tasksTest.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .value2, reuseIdentifier: nil)
//        cell.textLabel?.text = tasksTest[indexPath.row].title
//        cell.detailTextLabel?.text = tasksTest[indexPath.row].content
//        return cell
//    }
//}
//
//extension TableViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let actionDelete = UIContextualAction.init(style: .destructive, title: "Удалить") {
//            _,_,_ in
//            tasksTest.remove(at: indexPath.row)
//            tableView.reloadData()
//        }
//        let swipeDelete = UISwipeActionsConfiguration.init(actions: [actionDelete])
//        return swipeDelete
//    }
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let actionTranslate = UIContextualAction.init(style: .normal, title: "Изменить") {
//            _,_,_ in
//            tasksTest.remove(at: indexPath.row)
//            tableView.reloadData()
//        }
//        let swipeTranslate = UISwipeActionsConfiguration.init(actions: [actionTranslate])
//        return swipeTranslate
//    }
//}
//
////MARK: Create and Setup Table
//
//extension TableViewController {
//    func constraintsForTable() {
//        view.addSubview(tableView)
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.heightAnchor.constraint(equalToConstant: 750)
//            ])
//    }
//}
