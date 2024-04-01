import Foundation

enum CSService {
    static func readCSItems() async -> [CSItem] {
        await FirestoreService.shared.fetchKeywords()
    }
    
    static func readQuestions() async -> [CSQuestion] {
        await FirestoreService.shared.fetchQuestions()
    }
}
