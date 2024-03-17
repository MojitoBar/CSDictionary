import UIKit

final class RandomCardViewController: UIViewController {
    private let viewModel: CardViewModel = CardViewModel()
    private var randomCardView: RandomCardView {
        return view as! RandomCardView
    }
    
    override func loadView() {
        view = RandomCardView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(resource: .background)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
