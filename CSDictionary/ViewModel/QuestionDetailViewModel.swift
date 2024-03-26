import Foundation

final class QuestionDetailViewModel {
    @Published private(set) var item: CSQuestion
    
    init(item: CSQuestion) {
        self.item = item
    }
    
    func getTitle() -> String {
        item.question
    }
    
    func getAnswer() -> String {
        item.answer
    }
}
