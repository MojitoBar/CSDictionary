import UIKit

final class CardCell: UICollectionViewCell {
    static let identifier = "CardCell"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        label.textColor = UIColor(resource: .text)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let categoryLabel = CategoryLabel()
    private let descriptionLabel: CalloutView = {
        let label = CalloutView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("↪ 더 알아보기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.appPrimary, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .tabbar
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        addSubview(titleLabel)
        addSubview(categoryLabel)
        addSubview(descriptionLabel)
        addSubview(moreButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            moreButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    func configure(title: String, description: String, category: String) {
        titleLabel.text = title
        descriptionLabel.setContent(description)
        descriptionLabel.setEmoji("💡")
        categoryLabel.setContent(category)
    }
}
