import Foundation

struct CSQuestion: Codable {
    let question: String
    let answer: String
    let category: String
    var tailQuestion: [String]? = nil
}
