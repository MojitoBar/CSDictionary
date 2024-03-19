import UIKit
import CryptoKit

enum ImageService {
    private static let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!

    private static func cachePath(for url: URL) -> URL {
        return cacheDirectory.appendingPathComponent(url.absoluteString)
    }
    static func fetchImage(url: URL) async throws -> UIImage {
        if let image = retrieveCachedImage(withFilename: url.absoluteString) {
            return image
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "ImageService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid image data"])
        }
        cacheImage(image, withFilename: url.absoluteString)
        return image
    }
    static func cacheImage(_ image: UIImage, withFilename filename: String) {
        let hash = sha256(filename)
        if let data = image.jpegData(compressionQuality: 0.7) ?? image.pngData() {
            let fileManager = FileManager.default
            if let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
                let fileURL = cacheDirectory.appendingPathComponent(hash)
                try? data.write(to: fileURL)
            }
        }
    }
    static func retrieveCachedImage(withFilename filename: String) -> UIImage? {
        let hash = sha256(filename)
        let fileManager = FileManager.default
        if let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            let fileURL = cacheDirectory.appendingPathComponent(hash)
            if let imageData = try? Data(contentsOf: fileURL) {
                return UIImage(data: imageData)
            }
        }
        return nil
    }
    static func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    static func clearCache() {
        do {
            let fileManager = FileManager.default
            let fileURLs = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil)
            for fileURL in fileURLs {
                try fileManager.removeItem(at: fileURL)
            }
        } catch {
            NSLog("Error clearing cache: \(error)")
        }
    }
    static func cacheSize() -> Int {
        do {
            let fileManager = FileManager.default
            let fileURLs = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil)
            let size = fileURLs.reduce(0) { partialResult, url in
                let attributes = try? fileManager.attributesOfItem(atPath: url.path)
                if let fileSize = attributes?[.size] as? NSNumber {
                    return partialResult + fileSize.intValue
                } else {
                    return partialResult
                }
            }
            return size
        } catch {
            NSLog("Error getting cache size: \(error)")
            return 0
        }
    }
    static func formatBytes(_ bytes: Int) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useMB, .useGB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: Int64(bytes))
    }
}
