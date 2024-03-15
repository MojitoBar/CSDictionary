import UIKit

final class CSVideoCell: UICollectionViewCell {
    static let identifier = "CSVideoCell"
    private let videoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .light)
        button.setImage(UIImage(systemName: "play.circle", withConfiguration: imageConfig), for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.tintColor = .white
        button.backgroundColor = .black.withAlphaComponent(0.3)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(videoImageView)
        contentView.addSubview(playButton)
        NSLayoutConstraint.activate([
            videoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            videoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            videoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            videoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            playButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            playButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            playButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(url: URL) {
        Task {
            videoImageView.image = try? await ImageService.fetchImage(url: url)
        }
    }
    
    func setPlayButtonAction(_ action: UIAction) {
        playButton.addAction(action, for: .touchUpInside)
    }
}
