import UIKit
import SafariServices

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
        detailView.collectionViewConfigure(delegate: self)
    }
    
    override func loadView() {
        view = CSDetailView(viewModel: viewModel)
    }
    
    private func openWebPage(url: String) {
        if let url = URL(string: url) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
}

extension CSDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getVideoImage().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CSVideoCell.identifier, for: indexPath)
        if let cell = cell as? CSVideoCell, let url = URL(string: viewModel.getVideoImage()[indexPath.row]) {
            cell.configure(url: url)
            cell.setPlayButtonAction(UIAction(handler: { [weak self] _ in
                guard let self = self else { return }
                self.openWebPage(url: self.viewModel.getUrls()[indexPath.row])
            }))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 180, height: 130)
    }
}
