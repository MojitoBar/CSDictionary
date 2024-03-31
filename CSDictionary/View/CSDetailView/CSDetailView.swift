import UIKit
import Combine

final class CSDetailView: UIView {
    private var parser = CustomMarkdownParser()
    private var cancellable = Set<AnyCancellable>()
    private var viewModel: CSDetailViewModel!
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = FontManager.getSelectedFont(percent: 2.0, weight: .bold)
        label.textColor = UIColor(resource: .text)
        return label
    }()
    
    private let categoryLabel = CategoryLabel()

    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = FontManager.getSelectedFont(percent: 1.2, weight: .bold)
        label.textColor = UIColor(resource: .text)
        label.text = "요약 설명"
        return label
    }()

    private let calloutView: CalloutView = {
        let calloutView = CalloutView()
        calloutView.translatesAutoresizingMaskIntoConstraints = false
        return calloutView
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = FontManager.getSelectedFont(percent: 1.2, weight: .bold)
        label.textColor = UIColor(resource: .text)
        label.text = "상세 설명"
        return label
    }()
    
    private let detailDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = FontManager.getSelectedFont(weight: .regular)
        label.textColor = UIColor(resource: .text)
        label.numberOfLines = 0
        label.text = "불러오는 중..."
        return label
    }()
    
    private let videoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = FontManager.getSelectedFont(percent: 1.2, weight: .bold)
        label.textColor = UIColor(resource: .text)
        label.text = "관련 영상"
        return label
    }()
    
    private let videoCollectionView = CSVideoCollectionView()
    
    init(viewModel: CSDetailViewModel) {
        super.init(frame: .zero)
        backgroundColor = UIColor(resource: .background)
        self.viewModel = viewModel
        setBinding()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBinding() {
        viewModel.$item
            .sink { [weak self] item in
                self?.titleLabel.text = item.keyword
                self?.calloutView.setEmoji("💡")
                self?.calloutView.setContent(item.shortDescription)
                self?.categoryLabel.text = item.category
                self?.parser.parse(markdownText: item.description, completion: { string in
                    self?.detailDescription.attributedText = string
                })
            }
            .store(in: &cancellable)
    }
    
    private func setLayout() {
        addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(categoryLabel)
        scrollView.addSubview(summaryLabel)
        scrollView.addSubview(calloutView)
        scrollView.addSubview(detailLabel)
        scrollView.addSubview(detailDescription)
        scrollView.addSubview(videoLabel)
        scrollView.addSubview(videoCollectionView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            categoryLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            categoryLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),

            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        
            summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            summaryLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            calloutView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 10),
            calloutView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            calloutView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            detailLabel.topAnchor.constraint(equalTo: calloutView.bottomAnchor, constant: 20),
            detailLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            detailLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            detailDescription.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 10),
            detailDescription.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            detailDescription.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            videoLabel.topAnchor.constraint(equalTo: detailDescription.bottomAnchor, constant: 20),
            videoLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),

            videoCollectionView.topAnchor.constraint(equalTo: videoLabel.bottomAnchor, constant: 10),
            videoCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            videoCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            videoCollectionView.heightAnchor.constraint(equalToConstant: 130),
            
            videoCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
        ])
    }
    
    func collectionViewConfigure(delegate: UICollectionViewDelegate & UICollectionViewDataSource) {
        videoCollectionView.delegate = delegate
        videoCollectionView.dataSource = delegate
    }
}
