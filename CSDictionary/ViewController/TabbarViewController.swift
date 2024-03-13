import UIKit

final class TabbarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItem()
        setLayout()
    }
    
    func setTabBarItem() {
        let listViewController = ListViewController()
        let listTabBarItem = UITabBarItem(title: "CS 리스트", image: UIImage(systemName: "list.bullet"), tag: 0)
        listViewController.tabBarItem = listTabBarItem
        
        let listViewController1 = ListViewController()
        let listTabBarItem1 = UITabBarItem(title: "랜덤 카드", image: UIImage(systemName: "note.text"), tag: 1)
        listViewController1.tabBarItem = listTabBarItem1
        
        let listViewController2 = ListViewController()
        let listTabBarItem2 = UITabBarItem(title: "문제집", image: UIImage(systemName: "book.pages"), tag: 2)
        listViewController2.tabBarItem = listTabBarItem2
    
        let listViewController3 = ListViewController()
        let listTabBarItem3 = UITabBarItem(title: "환경설정", image: UIImage(systemName: "gear"), tag: 3)
        listViewController3.tabBarItem = listTabBarItem3
        
        viewControllers = [listViewController, listViewController1, listViewController2, listViewController3]
    }
    
    func setLayout() {
        tabBar.backgroundColor = UIColor(resource: .tabbar)
        tabBar.tintColor = UIColor(resource: .primary)
    }
}
