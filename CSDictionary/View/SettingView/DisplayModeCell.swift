import UIKit

protocol DisplayModeCellDelegate: AnyObject {
    func didChangeDisplayMode(to mode: UIUserInterfaceStyle)
}

final class DisplayModeCell: UITableViewCell {
    static let identifier = "DisplayModeCell"
    weak var delegate: DisplayModeCellDelegate?
    private var segmentedControl: UISegmentedControl!
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "display", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))?.withTintColor(.appPrimary)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "화면 모드"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(resource: .settingBackground)
        selectionStyle = .none
        setupSegmentedControl()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSegmentedControl() {
        segmentedControl = UISegmentedControl(items: ["System", "Light", "Dark"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addAction(UIAction(handler: { [weak self] action in
            guard let self = self else { return }
            let selectedMode: UIUserInterfaceStyle
            switch self.segmentedControl.selectedSegmentIndex {
            case 1:
                selectedMode = .light
            case 2:
                selectedMode = .dark
            default:
                selectedMode = .unspecified
            }
            self.delegate?.didChangeDisplayMode(to: selectedMode)
        }), for: .valueChanged)
    }
    
    private func setLayout() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            
            segmentedControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            segmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}
