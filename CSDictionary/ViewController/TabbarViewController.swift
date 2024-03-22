import UIKit
import FirebaseAnalytics

final class TabbarViewController: UITabBarController {
    private let tabBarTitle: [(title: String, image: String)] = [
        ("CS 리스트", "list.bullet"),
        ("문제집", "book.pages"),
        ("환경설정", "gear")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItem()
        setLayout()
        
        AnalyticsManager.logEvent("tabbar_viewed")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let mode = DisplayManager.loadDisplayModeChoice()
        DisplayManager.setDisplayMode(mode: mode)
    }
    
    private func setTabBarItem() {
        let viewControllerList = [CSListViewController(), CSListViewController(), SettingViewController()]
        for (index, item) in tabBarTitle.enumerated() {
            let listTabBarItem = UITabBarItem(title: item.title, image: UIImage(systemName: item.image), tag: index)
            viewControllerList[index].tabBarItem = listTabBarItem   
        }
        viewControllers = viewControllerList
    }
    
    private func setLayout() {
        tabBar.backgroundColor = UIColor(resource: .tabbar)
        tabBar.tintColor = UIColor(resource: .appPrimary)
    }
}
