import UIKit

final class CSDetailViewController: UIViewController {
    private let viewModel: CSDetailViewModel!
    private var detailView: CSDetailView {
        view as! CSDetailView
    }
    
    init(item: CSItem) {
        viewModel = CSDetailViewModel(item: item)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = CSDetailView(viewModel: viewModel)
    }
}
