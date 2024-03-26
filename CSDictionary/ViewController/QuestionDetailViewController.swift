import UIKit

final class QuestionDetailViewController: UIViewController {
    private let viewModel: QuestionDetailViewModel!
    private var detailView: QuestionDetailView {
        view as! QuestionDetailView
    }
    
    init(item: CSQuestion) {
        viewModel = QuestionDetailViewModel(item: item)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = QuestionDetailView(viewModel: viewModel)
    }
}
