import UIKit

final class CSListViewController: UIViewController {
    var listView: UIView! = {
        return CSListView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = listView
    }
}

