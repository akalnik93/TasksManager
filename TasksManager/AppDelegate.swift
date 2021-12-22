import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
 
        let firstVC = NowTasksViewController()
        let secondVC = CompleteTasksViewController()
        
        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers([firstVC, secondVC], animated: true)
        tabBarVC.tabBar.backgroundColor = .black
        tabBarVC.tabBar.unselectedItemTintColor = .white
        tabBarVC.tabBar.tintColor = .cyan
        
        firstVC.setTabBarHeight(height: tabBarVC.tabBar.frame.height + window!.safeAreaInsets.bottom)
        secondVC.setTabBarHeight(height: tabBarVC.tabBar.frame.height)
        
        let tabBarItemNow = UITabBarItem.init(title: "now", image: UIImage(named: "now"), tag: 0)
        tabBarItemNow.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tabBarItemNow.titlePositionAdjustment = .init(horizontal: 0, vertical: 8)
        firstVC.tabBarItem = tabBarItemNow
        tabBarVC.selectedIndex = 0

        let tabBarItemComplete = UITabBarItem.init(title: "complete", image: UIImage(named: "complete"), tag: 0)
        tabBarItemComplete.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tabBarItemComplete.titlePositionAdjustment = .init(horizontal: 0, vertical: 8)
        secondVC.tabBarItem = tabBarItemComplete
        
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
        
    return true
    }
}
