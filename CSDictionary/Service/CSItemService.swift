import Foundation

enum CSItemService {
    static func readCSItems() async -> [CSItem] {
        await FirestoreService.shared.fetchKeywords()
    }
    
    static func readQuestions() -> [CSQuestion] {
        return DB.questionList
    }
}
