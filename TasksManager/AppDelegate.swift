//
//  AppDelegate.swift
//  TasksManager
//
//  Created by Aleksey on 06.10.2021.
//  Copyright © 2021 Aleksey. All rights reserved.
//

import UIKit
import RealmSwift

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
        tabBarVC.tabBar.unselectedItemTintColor = .lightGray
        tabBarVC.tabBar.tintColor = .white
        
        firstVC.setTabBarHeight(height: tabBarVC.tabBar.frame.height + window!.safeAreaInsets.bottom)
        secondVC.setTabBarHeight(height: tabBarVC.tabBar.frame.height)
        
        let tabBarItemNow = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        tabBarItemNow.titlePositionAdjustment = .init(horizontal: 0, vertical: 5)
        firstVC.tabBarItem = tabBarItemNow
        tabBarVC.selectedIndex = 0 // имитирует нажатие на таббаритем

        let tabBarItemComplete = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        tabBarItemComplete.titlePositionAdjustment = .init(horizontal: 0, vertical: 5)
        secondVC.tabBarItem = tabBarItemComplete
        
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible() // устанавливает window в качестве ключевого и видимового !
        
    return true
    }
}
