import UIKit

final class RandomCardView: UIView {
    private var viewModel: CardViewModel
    private var filterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(resource: .background)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryFilterCell.self, forCellWithReuseIdentifier: CategoryFilterCell.identifier)
        collectionView.tag = 0
        return collectionView
    }()
    private let randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(.text, for: .normal)
        button.backgroundColor = .filterBackground
        button.layer.cornerRadius = 13
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .filterBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var cardCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        collectionView.backgroundColor = UIColor(resource: .background)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.identifier)
        collectionView.isPagingEnabled = true
        collectionView.tag = 1
        return collectionView
    }()
    
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = UIColor(resource: .background)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        addSubview(filterCollectionView)
        addSubview(divider)
        addSubview(randomButton)
        addSubview(cardCollectionView)
        
        NSLayoutConstraint.activate([
            randomButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            randomButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            randomButton.heightAnchor.constraint(equalToConstant: 35),
            randomButton.widthAnchor.constraint(equalToConstant: 50),
            
            divider.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            divider.leadingAnchor.constraint(equalTo: randomButton.trailingAnchor, constant: 16),
            divider.widthAnchor.constraint(equalToConstant: 2),
            divider.heightAnchor.constraint(equalToConstant: 35),
            
            filterCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            filterCollectionView.leadingAnchor.constraint(equalTo: randomButton.trailingAnchor, constant: 16),
            filterCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 35),
            
            cardCollectionView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            cardCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            cardCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            cardCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }   
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            if let size = self.window?.frame.size.width {
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: size * 0.25 / 2, bottom: 0, trailing: size * 0.25 / 2)
            }
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        }
        return layout
    }
    
    func configureCollection(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        filterCollectionView.delegate = delegate
        filterCollectionView.dataSource = dataSource
        
        cardCollectionView.delegate = delegate
        cardCollectionView.dataSource = dataSource
    }
}
