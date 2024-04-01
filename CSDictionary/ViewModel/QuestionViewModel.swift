import Foundation

final class QuestionViewModel {
    @Published private(set) var items: [CSQuestion] = []
    private var filteredItems: [CSQuestion] = []
    
    var isSearching: Bool = false
    
    var sections: [String] {
        isSearching ? ["검색 결과"] : DB.CSSections
    }
    
    func fetchItems() async {
        items = await CSService.readQuestions()
    }
    
    func item(at indexPath: IndexPath) -> CSQuestion {
        isSearching ? filteredItems[indexPath.row] : items.filter { $0.category == sections[indexPath.section] }[indexPath.row]
    }
    
    func itemsCount(in section: Int) -> Int {
        let sectionItems = items.filter { $0.category == sections[section] }
        return isSearching ? filteredItems.count : sectionItems.count
    }
    
    func filterItems(for searchText: String) {
        isSearching = !searchText.isEmpty
        filteredItems = items.filter { $0.question.lowercased().contains(searchText.lowercased()) }
    }
}
