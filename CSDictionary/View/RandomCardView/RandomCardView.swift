import UIKit

final class RandomCardView: UIView {
    private var viewModel: CardViewModel
    private lazy var card: CardView = {
        let view = CardView(viewModel: viewModel)
        view.backgroundColor = UIColor(resource: .background)
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 0.3
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
        
        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: centerXAnchor),
            card.centerYAnchor.constraint(equalTo: centerYAnchor),
            card.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            card.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
    }   
}
