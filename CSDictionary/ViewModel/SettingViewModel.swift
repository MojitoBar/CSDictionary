import Foundation

final class SettingViewModel {
    let sections = SettingSection.allCases
        
    func itemsCount(in section: Int) -> Int {
        sections[section].items.count
    }
    
    func item(at indexPath: IndexPath) -> SettingOption {
        sections[indexPath.section].items[indexPath.row]
    }
    
    func icon(at indexPath: IndexPath) -> String {
        sections[indexPath.section].icons[indexPath.row]
    }
    
    func sectionTitle(at index: Int) -> String {
        sections[index].rawValue
    }
    
    func option(at indexPath: IndexPath) -> SettingOption {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: return .contactDeveloper
            case 1: return .addCSKeyword
            default: return .contactDeveloper
            }
        case 1:
            switch indexPath.row {
            case 0: return .displayMode
            case 1: return .textSize
            case 2: return .leaveReview
            case 3: return .notificationSetting
            default: return .displayMode
            }
        case 2:
            switch indexPath.row {
            case 0: return .clearImageCache
            default: return .clearImageCache
            }
        case 3:
            switch indexPath.row {
            case 0: return .removeAds
            default: return .removeAds
            }
        default:
            return .contactDeveloper
        }
    }
}
