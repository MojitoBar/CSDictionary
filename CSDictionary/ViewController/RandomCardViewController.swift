import UIKit

enum CollectionViewType: Int {
    case category
    case card
}

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
        let type = CollectionViewType(rawValue: collectionView.tag)!
        switch type {
        case .category:
            let title = DB.SearchSection[indexPath.row]
            let font = UIFont.systemFont(ofSize: 14)
            let textAttributes = [NSAttributedString.Key.font: font]
            let textSize = title.size(withAttributes: textAttributes)
            let padding: CGFloat = 30
            return CGSize(width: textSize.width + padding, height: 35)
        case .card:
            if let size = view.window?.screen.bounds.size {
                return CGSize(width: size.width * 0.7, height: size.height * 0.4)
            }
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = CollectionViewType(rawValue: collectionView.tag)!
        switch type {
        case .category:
            return DB.CSSections.count
        case .card:
            return DB.CSSections.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = CollectionViewType(rawValue: collectionView.tag)!
        switch type {
        case .category:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryFilterCell.identifier, for: indexPath) as! CategoryFilterCell
            cell.backgroundColor = .filterBackground
            cell.layer.cornerRadius = 13
            cell.configure(title: DB.CSSections[indexPath.row])
            return cell
        case .card:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell
            cell.layer.cornerRadius = 13
            let item = DB.csList[indexPath.row]
            cell.configure(title: item.name, description: item.shortDescription, category: item.category)
            return cell
        }
    }
}
