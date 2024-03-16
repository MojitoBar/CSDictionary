import Foundation

struct StaticData {
    static let sections: [String] = ["자료구조", "알고리즘", "네트워크"]
    static let searchSection: [String] = ["검색 결과"]
}

final class CSListViewModel {
    @Published private(set) var items: [CSItem] = []
    private var filteredItems: [CSItem] = []
    
    init() {
        items = CSItemService.readItems()
    }
    
    var isSearching: Bool = false
    
    var sections: [String] {
        isSearching ? ["검색 결과"] : StaticData.sections
    }
    
    func item(at indexPath: IndexPath) -> CSItem {
        isSearching ? filteredItems[indexPath.row] : items.filter { $0.category == sections[indexPath.section] }[indexPath.row]
    }
    
    func itemsCount(in section: Int) -> Int {
        let sectionItems = items.filter { $0.category == sections[section] }
        return isSearching ? filteredItems.count : sectionItems.count
    }
    
    func filterItems(for searchText: String) {
        isSearching = !searchText.isEmpty
        filteredItems = items.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
}
