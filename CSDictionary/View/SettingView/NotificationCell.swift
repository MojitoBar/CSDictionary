import UIKit

protocol NotificationCellDelegate: AnyObject {
    func notiClicked()
}

final class NotificationCell: UITableViewCell {
    static let identifier = "NotificationCell"
    private var titleLabel: UILabel!
    private var iconImageView: UIImageView!
    weak var delegate: NotificationCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(resource: .settingBackground)
        selectionStyle = .none
        setupIconImageView()
        setupTitleLabel()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.notiClicked()
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
        titleLabel.font = FontManager.getSelectedFont()
        contentView.addSubview(titleLabel)
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
        ])
    }
    
    func configure(option: SettingOption, description: String = "") {
        titleLabel.text = option.title
        iconImageView.image = UIImage(systemName: option.icon, withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        iconImageView.tintColor = .appPrimary
    }
    
    func setFont() {
        titleLabel.font = FontManager.getSelectedFont()
    }
}
