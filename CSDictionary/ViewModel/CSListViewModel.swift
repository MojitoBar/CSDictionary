import Foundation

final class CSListViewModel {
    @Published private(set) var items: [CSItem] = []
    private let sections: [String] = ["자료구조", "알고리즘", "네트워크"]
    
    init() {
        items = CSItemService.readItems()
    }
    
    func getSectionsCount() -> Int {
        return sections.count
    }
    
    func getSection(at: Int) -> String {
        return sections[at]
    }
    
    func getItemsCount() -> Int {
        return items.count
    }
    
    func fetchItems() -> [CSItem] {
        return items
    }
    
    func fetchItem(at index: Int) -> CSItem {
        return items[index]
    }
    
    func getItemDictionary() -> [String: [CSItem]] {
        var dictionary = [String: [CSItem]]()
        for section in sections {
            dictionary[section] = items.filter { $0.category == section }
        }
        return dictionary
    }
}
