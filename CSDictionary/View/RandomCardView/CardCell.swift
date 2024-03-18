import UIKit

final class CardCell: UICollectionViewCell {
    static let identifier = "CardCell"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
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
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            categoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10)
        ])
    }
    
    func configure(title: String, description: String, category: String) {
        titleLabel.text = title
        descriptionLabel.setContent(description)
        descriptionLabel.setEmoji("💡")
        categoryLabel.setContent(category)
    }
}
