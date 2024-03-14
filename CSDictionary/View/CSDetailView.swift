import UIKit

final class CSDetailView: UIView {
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(resource: .background)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
