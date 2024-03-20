import UIKit

enum DisplayManager {
    static func setDisplayMode(mode: UIUserInterfaceStyle) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.compactMap { $0 as? UIWindowScene }
        for windowScene in windowScenes {
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = mode
            }
        }
    }
    
    static func saveDisplayModeChoice(mode: UIUserInterfaceStyle) {
        UserDefaults.standard.set(mode.rawValue, forKey: "displayMode")
    }
    
    static func loadDisplayModeChoice() -> UIUserInterfaceStyle {
        let displayModeChoice = UserDefaults.standard.integer(forKey: "displayMode")
        return UIUserInterfaceStyle(rawValue: displayModeChoice) ?? .unspecified
    }
}
