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
        sections[indexPath.section].items[indexPath.row]
    }
}
