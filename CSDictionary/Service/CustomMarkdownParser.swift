import UIKit

final class CustomMarkdownParser {
    func parse(markdownText: String, completion: @escaping (NSAttributedString?) -> Void) {
        var imageInfos = [(range: NSRange, image: NSAttributedString?)]()
        let attributedString = NSMutableAttributedString(string: markdownText)
        applyStyles(to: attributedString)
        
        let group = DispatchGroup()
        
        let imagePattern = "!\\[.*?\\]\\((.*?)\\)"
        let regex = try! NSRegularExpression(pattern: imagePattern, options: [])
        let text = attributedString.string
        let range = NSRange(location: 0, length: text.utf16.count)
        
        regex.enumerateMatches(in: text, options: [], range: range) { match, _, _ in
            guard let matchRange = match?.range(at: 1),
                  let subrange = Range(matchRange, in: text),
                  let imageUrl = URL(string: String(text[subrange])) else { return }
            
            group.enter()
            loadImageAsync(from: imageUrl) { image in
                if let image = image {
                    let ratio = image.size.width / image.size.height
                    let width = UIScreen.main.bounds.width - 40
                    let imageAttachment = NSTextAttachment()
                    imageAttachment.image = image
                    imageAttachment.bounds = CGRect(x: 0, y: 0, width: width, height: width / ratio)
                    let imageAttributedString = NSAttributedString(attachment: imageAttachment)
                    
                    DispatchQueue.main.sync {
                        imageInfos.append((range: match!.range, image: imageAttributedString))
                    }
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            for imageInfo in imageInfos.sorted(by: { $0.range.location > $1.range.location }) {
                if let imageAttrString = imageInfo.image {
                    attributedString.replaceCharacters(in: imageInfo.range, with: imageAttrString)
                }
            }
            completion(attributedString)
        }
    }
    private func loadImageAsync(from url: URL, completion: @escaping (UIImage?) -> Void) {
        Task {
            if let image = try? await ImageService.fetchImage(url: url) {
                let radiusImage = applyRadius(to: image, radius: 12)
                completion(radiusImage)
            } else {
                completion(nil)
            }
        }
    }
    private func applyRadius(to image: UIImage, radius: CGFloat) -> UIImage {
        let rect = CGRect(origin: .zero, size: image.size)
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
        image.draw(in: rect)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage!
    }
    private func applyStyles(to attributedString: NSMutableAttributedString) {
        let boldPattern = "\\*\\*(.*?)\\*\\*"
        let h1 = "(^# .*)"
        let h3 = "(^### .*)"
        let textRange = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(.foregroundColor, value: UIColor.text, range: textRange)
        attributedString.addAttribute(.font, value: FontManager.getSelectedFont(), range: textRange)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: textRange)
            
        applyStyle(to: attributedString, with: boldPattern, attributes: [
            .font: FontManager.getSelectedFont(weight: .bold)
        ])
        
        applyStyle(to: attributedString, with: h1, attributes: [
            .font: FontManager.getSelectedFont(percent: 2.0, weight: .bold)
        ])
        
        applyStyle(to: attributedString, with: h3, attributes: [
            .font: FontManager.getSelectedFont(percent: 1.2, weight: .bold)
        ])
    }
    private func applyStyle(to attributedString: NSMutableAttributedString, with pattern: String, attributes: [NSAttributedString.Key: Any]) {
        let regex = try! NSRegularExpression(pattern: pattern, options: [.anchorsMatchLines])
        let range = NSRange(location: 0, length: attributedString.length)
        var matches: [NSTextCheckingResult] = []
        
        regex.enumerateMatches(in: attributedString.string, options: [], range: range) { match, _, _ in
            if let match = match {
                matches.append(match)
            }
        }
        
        for match in matches.reversed() {
            let matchRange = match.range(at: 1)
            attributedString.addAttributes(attributes, range: matchRange)
            
            let replaceRange = match.range(at: 0)
            if let style = attributes[.font] as? UIFont, style == FontManager.getSelectedFont(weight: .bold) {
                attributedString.replaceCharacters(in: NSRange(location: replaceRange.location, length: 2), with: "")
                attributedString.replaceCharacters(in: NSRange(location: replaceRange.location + matchRange.length, length: 2), with: "")
            } else if let style = attributes[.font] as? UIFont, style == FontManager.getSelectedFont(percent: 2.0, weight: .bold) {
                attributedString.replaceCharacters(in: NSRange(location: replaceRange.location, length: 2), with: "")
            } else if let style = attributes[.font] as? UIFont, style == FontManager.getSelectedFont(percent: 1.2, weight: .bold) {
                attributedString.replaceCharacters(in: NSRange(location: replaceRange.location, length: 4), with: "")
            }
        }
    }
}

