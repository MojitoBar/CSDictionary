import UIKit

final class CSDetailViewController: UIViewController {
    private var detailView: CSDetailView {
        view as! CSDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = CSDetailView()
    }
}
