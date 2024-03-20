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

    static func getSelectedFont() -> UIFont {
        let choice = loadUserTextSizeChoice()
        let fontSize = calculateFontSize(from: choice)
        return UIFont.systemFont(ofSize: fontSize)
    }

    static func calculateFontSize(from choice: Size) -> CGFloat {
        switch choice {
        case .small:
            return 13
        case .medium:
            return 15
        case .large:
            return 17
        case .xlarge:
            return 19
        case .xxlarge:
            return 21
        }
    }
}
