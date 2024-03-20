import UIKit

final class CalloutView: UIView {
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = FontManager.getSelectedFont(percent: 1, weight: .bold)
        label.textColor = UIColor(resource: .text)
        label.textAlignment = .center
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = FontManager.getSelectedFont(percent: 1, weight: .regular)
        label.textColor = UIColor(resource: .text)
        label.numberOfLines = 0
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        backgroundColor = UIColor(resource: .calloutBackground)
        layer.cornerRadius = 8
        addSubview(emojiLabel)
        addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            emojiLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emojiLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            emojiLabel.widthAnchor.constraint(equalToConstant: 30),
            emojiLabel.heightAnchor.constraint(equalToConstant: 30),
            
            contentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: emojiLabel.trailingAnchor, constant: 10),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func setEmoji(_ emoji: String) {
        emojiLabel.text = emoji
    }
    
    func setContent(_ content: String) {
        contentLabel.text = content
    }
}
