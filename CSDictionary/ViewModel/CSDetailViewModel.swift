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
    
    func getUrls() -> [String] {
        item.urls ?? []
    }
    
    func getVideoImage() -> [String] {
        var images: [String] = []
        guard let urls = item.urls else { return [] }
        for url in urls {
            if let urlComponents = URLComponents(string: url),
               let queryItems = urlComponents.queryItems {
                for item in queryItems where item.name == "v" {
                    images.append("https://img.youtube.com/vi/\(item.value ?? "")/0.jpg")
                }
            }
        }
        return images
    }
}
