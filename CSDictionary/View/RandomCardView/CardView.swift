import UIKit

final class CardView: UIView {
    private let viewModel: CardViewModel
    private let frontView: CardFrontView = {
        let view = CardFrontView()
        view.backgroundColor = UIColor(resource: .appPrimary).withAlphaComponent(0.5)
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .appPrimary).withAlphaComponent(0.5)
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.layer.cornerRadius = 20
        setLayout()
        frontView.configure(title: "Stack", category: "자료구조")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        flipCard()
    }
    
    private func setLayout() {
        addSubview(backView)
        addSubview(frontView)
        
        NSLayoutConstraint.activate([
            frontView.topAnchor.constraint(equalTo: topAnchor),
            frontView.leadingAnchor.constraint(equalTo: leadingAnchor),
            frontView.trailingAnchor.constraint(equalTo: trailingAnchor),
            frontView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backView.topAnchor.constraint(equalTo: topAnchor),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func flipCard() {
        if viewModel.isFront {
            UIView.transition(from: frontView, to: backView, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: backView, to: frontView, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        viewModel.flipCard()
    }
}
