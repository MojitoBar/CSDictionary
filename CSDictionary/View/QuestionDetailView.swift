import UIKit
import WebKit
import Combine

final class QuestionDetailView: UIView {
    private var cancellable = Set<AnyCancellable>()
    private let viewModel: QuestionDetailViewModel
    private let parser: CustomMarkdownParser = CustomMarkdownParser()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = FontManager.getSelectedFont(percent: 1.3, weight: .bold)
        label.numberOfLines = 0
        label.textColor = UIColor(resource: .text)
        return label
    }()
    private let categoryLabel = CategoryLabel()
    private let descriptionLabel: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.adjustsFontForContentSizeCategory = true
        textView.font = FontManager.getSelectedFont(percent: 1.3, weight: .regular)
        textView.text = "불러오는 중..."
        return textView
    }()
    init (viewModel: QuestionDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = UIColor(resource: .background)
        setBinding()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBinding() {
        viewModel.$item
            .sink { [weak self] item in
                guard let self = self else { return }
                self.titleLabel.text = item.question
                self.categoryLabel.text = item.category
                self.parser.parse(markdownText: item.answer, completion: { string in
                    self.descriptionLabel.attributedText = string
                })
            }
            .store(in: &cancellable)
    }
    
    private func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(categoryLabel)
        scrollView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),

            categoryLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            categoryLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),

            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
                        
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
        ])
    }
}
