import Foundation

enum CSItemService {
    static func readItems() -> [CSItem] {
        return DB.csList
    }
}
