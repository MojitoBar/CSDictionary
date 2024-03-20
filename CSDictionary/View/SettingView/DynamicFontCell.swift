import UIKit

protocol DynamicFontCellDelegate: AnyObject {
    func didChangeFontSize()
}

final class DynamicFontCell: UITableViewCell {
    static let identifier = "DynamicFontCell"
    weak var delegate: DynamicFontCellDelegate?
    private var segmentedControl: UISegmentedControl!
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "textformat.size", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))?.withRenderingMode(.alwaysTemplate)
        imageView.image = image
        imageView.tintColor = .appPrimary
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "글자 크기"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = FontManager.getSelectedFont()
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
    
    private func getSelectedIndex() -> Int {
        let fontSize = UserDefaults.standard.string(forKey: "fontSize") ?? "large"
        switch fontSize {
        case "small":
            return 0
        case "medium":
            return 1
        case "large":
            return 2
        case "xlarge":
            return 3
        case "xxlarge":
            return 4
        default:
            return 2
        }
    }
    
    private func setupSegmentedControl() {
        segmentedControl = UISegmentedControl(items: ["더 작게", "작게", "보통", "크게", "더 크게"])
        segmentedControl.selectedSegmentIndex = getSelectedIndex()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addAction(UIAction(handler: { [weak self] action in
            guard let self = self else { return }
            let index = self.segmentedControl.selectedSegmentIndex
            self.delegate?.didChangeFontSize()
            switch index {
            case 0:
                UserDefaults.standard.set("small", forKey: "fontSize")
            case 1:
                UserDefaults.standard.set("medium", forKey: "fontSize")
            case 2:
                UserDefaults.standard.set("large", forKey: "fontSize")
            case 3:
                UserDefaults.standard.set("xlarge", forKey: "fontSize")
            case 4:
                UserDefaults.standard.set("xxlarge", forKey: "fontSize")
            default:
                break
            }
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
    
    func setFont() {
        titleLabel.font = FontManager.getSelectedFont()
    }
}
