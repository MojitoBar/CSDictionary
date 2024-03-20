import UIKit

final class SettingCell: UITableViewCell {
    static let identifier = "SettingCell"
    private var titleLabel: UILabel!
    private var iconImageView: UIImageView!
    private var descriptionLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(resource: .settingBackground)
        selectionStyle = .none
        setupIconImageView()
        setupTitleLabel()
        setupDescriptionLabel()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupIconImageView() {
        iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(iconImageView)
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        contentView.addSubview(titleLabel)
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            
            descriptionLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    func configure(option: SettingOption, description: String = "") {
        titleLabel.text = option.title
        descriptionLabel.text = description
        iconImageView.image = UIImage(systemName: option.icon, withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        iconImageView.tintColor = .appPrimary
    }
}
