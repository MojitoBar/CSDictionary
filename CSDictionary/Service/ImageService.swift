import UIKit

enum ImageService {
    static func fetchImage(url: URL) async throws -> UIImage {
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
            
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
            throw NSError(domain: "fetch error", code: 1004)
        }
        guard let image = UIImage(data: data) else { 
            throw NSError(domain: "image coverting error", code: 999)
        }
        return image
    }
}
