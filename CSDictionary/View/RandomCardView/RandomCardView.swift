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
    private lazy var card: CardView = {
        let view = CardView(viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(card)
        addSubview(filterCollectionView)
        addSubview(divider)
        addSubview(randomButton)
        
        NSLayoutConstraint.activate([
            randomButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            randomButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            randomButton.heightAnchor.constraint(equalToConstant: 35),
            randomButton.widthAnchor.constraint(equalToConstant: 50),
            
            divider.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            divider.leadingAnchor.constraint(equalTo: randomButton.trailingAnchor, constant: 16),
            divider.widthAnchor.constraint(equalToConstant: 2),
            divider.heightAnchor.constraint(equalToConstant: 35),
            
            filterCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            filterCollectionView.leadingAnchor.constraint(equalTo: randomButton.trailingAnchor, constant: 16),
            filterCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 35),
            
            card.centerXAnchor.constraint(equalTo: centerXAnchor),
            card.centerYAnchor.constraint(equalTo: centerYAnchor),
            card.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            card.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
    }   
    
    func configureCollection(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        filterCollectionView.delegate = delegate
        filterCollectionView.dataSource = dataSource
        filterCollectionView.register(CategoryFilterCell.self, forCellWithReuseIdentifier: CategoryFilterCell.identifier)
    }
}
