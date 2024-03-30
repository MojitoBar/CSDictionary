import Foundation

struct CSItem: Codable {
    let keyword: String
    let shortDescription: String
    let description: String
    let category: String
    var urls: [String]? = nil
}
