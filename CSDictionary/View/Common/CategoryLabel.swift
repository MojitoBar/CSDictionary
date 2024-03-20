import UIKit

final class CategoryLabel: UILabel {
    private let topPadding: CGFloat = 2
    private let bottomPadding: CGFloat = 2
    private let leftPadding: CGFloat = 10
    private let rightPadding: CGFloat = 10
    
    override func drawText(in rect: CGRect) {
        let padding = UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
        super.drawText(in: rect.inset(by: padding))
    }
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += leftPadding + rightPadding
        contentSize.height += topPadding + bottomPadding
        return contentSize
    }
    
    init() {
        super.init(frame: .zero)
        adjustsFontForContentSizeCategory = true
        font = FontManager.getSelectedFont(percent: 0.9, weight: .bold)
        translatesAutoresizingMaskIntoConstraints = false
        
        textColor = UIColor.white
        backgroundColor = UIColor(resource: .appPrimary)
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(_ text: String) {
        self.text = text
    }
}
