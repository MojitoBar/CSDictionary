import Foundation

final class CSDetailViewModel {
    @Published private(set) var item: CSItem
    
    init(item: CSItem) {
        self.item = item
    }
    
    func getTitle() -> String {
        item.name
    }
    
    func getShortDescription() -> String {
        item.shortDescription
    }
}
