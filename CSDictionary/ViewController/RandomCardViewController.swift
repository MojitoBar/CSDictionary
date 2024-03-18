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
        randomCardView.configureCollection(delegate: self, dataSource: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "랜덤 카드"
        navigationController?.navigationBar.topItem?.searchController = nil
    }
}

extension RandomCardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = DB.category[indexPath.row]
        let font = UIFont.systemFont(ofSize: 14)
        let textAttributes = [NSAttributedString.Key.font: font]
        let textSize = title.size(withAttributes: textAttributes)
        let padding: CGFloat = 30
        return CGSize(width: textSize.width + padding, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        DB.category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryFilterCell.identifier, for: indexPath) as! CategoryFilterCell
        cell.backgroundColor = .filterBackground
        cell.layer.cornerRadius = 13
        cell.configure(title: DB.category[indexPath.row])
        return cell
    }
}
