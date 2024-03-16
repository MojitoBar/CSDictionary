import UIKit

final class TabbarViewController: UITabBarController {
    private let tabBarTitle: [(title: String, image: String)] = [
        ("CS 리스트", "list.bullet"),
        ("랜덤 카드", "note.text"),
        ("문제집", "book.pages"),
        ("환경설정", "gear")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItem()
        setLayout()
    }
    
    private func setTabBarItem() {
        var viewControllerList = [UIViewController]()
        for (index, item) in tabBarTitle.enumerated() {
            let listViewController = CSListViewController()
            let listTabBarItem = UITabBarItem(title: item.title, image: UIImage(systemName: item.image), tag: index)
            listViewController.tabBarItem = listTabBarItem
            viewControllerList.append(listViewController)
        }
        
        viewControllers = viewControllerList
    }
    
    private func setLayout() {
        tabBar.backgroundColor = UIColor(resource: .tabbar)
        tabBar.tintColor = UIColor(resource: .appPrimary)
    }
}
