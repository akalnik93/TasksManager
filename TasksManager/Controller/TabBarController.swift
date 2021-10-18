//
//  ViewController.swift
//  TasksManager
//
//  Created by Aleksey on 06.10.2021.
//  Copyright © 2021 Aleksey. All rights reserved.
//

//import UIKit
//
//class TabBarController: UITabBarController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        setupTabBar()
//        constraintsForButton()
////        constraintsForTable()
//    }
//        
//    func setupTabBar() {
//        //let itemOne = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
//        //print(itemOne.title ?? "0")
//        let itemOne = UITabBarItem(title: "Now", image: nil, tag: 0)
//        //itemOne.titlePositionAdjustment = .init(horizontal: 0, vertical: 20)
//        //let vcOne = UINavigationController(rootViewController: NowTasksViewController())
//        //vcOne.tabBarItem = itemOne
//        NowTasksViewController().tabBarItem = itemOne
//        let itemTwo = UITabBarItem(title: "Complete", image: nil, tag: 0)
//        //itemOne.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
//        //let vcTwo = UINavigationController(rootViewController: CompleteTasksViewController())
//        //vcTwo.tabBarItem = itemTwo
//        CompleteTasksViewController().tabBarItem = itemTwo
//    }
//    
//    var addTaskButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("AddTask", for: .normal)
//        button.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .normal)
//        button.titleLabel?.font = UIFont(name: "Calibri", size: 16)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    func constraintsForButton() {
//        view.addSubview(addTaskButton)
//        NSLayoutConstraint.activate([
//            addTaskButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 67),
//            addTaskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 310),
//            addTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            addTaskButton.heightAnchor.constraint(equalToConstant: 0)
//            ])
//    }
//}
////    func setupTabBar() {
////        let nowTasksViewController = createNavController(vc: NowTasksViewController(), itemName: "Now", itemImage: "")
////        let completeTasksViewController = createNavController(vc: CompleteTasksViewController(), itemName: "Complete", itemImage: "")
////
////        viewControllers = [nowTasksViewController, completeTasksViewController]
////    }
////
////    func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
////        let item = UITabBarItem(title: itemName, image: UIImage(named: itemImage), tag: 0)
////        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
////        let navController = UINavigationController(rootViewController: vc)
////        navController.tabBarItem = item
////        return navController
////    }
////}
