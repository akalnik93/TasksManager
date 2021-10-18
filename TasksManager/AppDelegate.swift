//
//  AppDelegate.swift
//  TasksManager
//
//  Created by Aleksey on 06.10.2021.
//  Copyright © 2021 Aleksey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let firstVC = NowTasksViewController()
        let secondVC = CompleteTasksViewController()
        
        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers([firstVC, secondVC], animated: true)
        tabBarVC.tabBar.barTintColor = .black
        
        let tabBarItemNow = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        firstVC.tabBarItem = tabBarItemNow
        tabBarVC.selectedIndex = 0 // имитирует нажатие на таббаритем
        
        let tabBarItemComplete = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        secondVC.tabBarItem = tabBarItemComplete

        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
        
        secondVC.loadViewIfNeeded() // таббаритем появляется сразу а не после нажатия !
    
    return true
    }
}
