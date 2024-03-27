import Foundation

enum CSItemService {
    static func readCSItems() -> [CSItem] {
        return DB.csList
    }
    
    static func readQuestions() -> [CSQuestion] {
        return DB.questionList
    }
}
