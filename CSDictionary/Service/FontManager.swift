import UIKit

enum Size: String {
    case small
    case medium
    case large
    case xlarge
    case xxlarge
}

enum FontManager {
    static func saveUserTextSizeChoice(size: Size) {
        UserDefaults.standard.set(size, forKey: "fontSize")
    }

    static func loadUserTextSizeChoice() -> Size {
        let textSizeChoice = UserDefaults.standard.string(forKey: "fontSize") ?? "large"
        return Size(rawValue: textSizeChoice) ?? .medium
    }

    static func getSelectedFont(percent: CGFloat = 1, weight: UIFont.Weight = .regular) -> UIFont {
        let choice = loadUserTextSizeChoice()
        let fontSize = calculateFontSize(from: choice)
        return UIFont.systemFont(ofSize: (fontSize * percent), weight: weight)
    }

    static func calculateFontSize(from choice: Size) -> CGFloat {
        switch choice {
        case .small:
            return 11
        case .medium:
            return 13
        case .large:
            return 15
        case .xlarge:
            return 17
        case .xxlarge:
            return 19
        }
    }
}
