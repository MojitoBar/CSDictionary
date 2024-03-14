import UIKit
import Combine

final class CSDetailView: UIView {
    private var cancellable = Set<AnyCancellable>()
    private var viewModel: CSDetailViewModel!
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(resource: .text)
        return label
    }()
    
    private let categoryLabel = CategoryLabel()

    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = UIColor(resource: .text)
        label.text = "요약 설명"
        return label
    }()

    private let calloutView: CalloutView = {
        let calloutView = CalloutView()
        calloutView.translatesAutoresizingMaskIntoConstraints = false
        return calloutView
    }()
    
    init(viewModel: CSDetailViewModel) {
        super.init(frame: .zero)
        backgroundColor = UIColor(resource: .background)
        self.viewModel = viewModel
        setBinding()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBinding() {
        viewModel.$item
            .sink { [weak self] item in
                self?.titleLabel.text = item.name
                self?.calloutView.setEmoji("💡")
                self?.calloutView.setContent(item.shortDescription)
                self?.categoryLabel.text = item.category
            }
            .store(in: &cancellable)
    }
    
    private func setLayout() {
        addSubview(titleLabel)
        addSubview(categoryLabel)
        addSubview(summaryLabel)
        addSubview(calloutView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            categoryLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            categoryLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        
            summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            summaryLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            calloutView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 10),
            calloutView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            calloutView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
        ])
    }
}
