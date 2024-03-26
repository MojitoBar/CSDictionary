import UIKit

final class CustomMarkdownParser {
    func parse(markdownText: String, completion: @escaping (NSAttributedString?) -> Void) {
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
                guard let image = image else {
                    group.leave()
                    return
                }
                
                let imageAttachment = NSTextAttachment()
                imageAttachment.image = image
                let ratio = image.size.width / image.size.height
                let width = UIScreen.main.bounds.width
                imageAttachment.bounds = CGRect(x: 0, y: 0, width: width, height: width / ratio)
                let imageAttributedString = NSAttributedString(attachment: imageAttachment)
                
                DispatchQueue.main.async {
                    attributedString.replaceCharacters(in: match!.range, with: imageAttributedString)
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            completion(attributedString)
        }
    }
    
    private func loadImageAsync(from url: URL, completion: @escaping (UIImage?) -> Void) {
        Task {
            let image = try? await ImageService.fetchImage(url: url)
            completion(image)
        }
    }
    private func applyStyles(to attributedString: NSMutableAttributedString) {
        let boldPattern = "\\*\\*(.*?)\\*\\*"
        let italicPattern = "\\*(.*?)\\*"
        
        let textRange = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(.foregroundColor, value: UIColor.text, range: textRange)
        attributedString.addAttribute(.font, value: FontManager.getSelectedFont(), range: textRange)
            
        applyStyle(to: attributedString, with: boldPattern, attributes: [
            .font: FontManager.getSelectedFont(weight: .bold)
        ])
        
        applyStyle(to: attributedString, with: italicPattern, attributes: [
            .font: FontManager.getSelectedFont()
        ])
    }
    private func applyStyle(to attributedString: NSMutableAttributedString, with pattern: String, attributes: [NSAttributedString.Key: Any]) {
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: attributedString.length)
        regex.enumerateMatches(in: attributedString.string, options: [], range: range) { (match, _, _) in
            guard let matchRange = match?.range(at: 1) else { return }
            
            attributedString.addAttributes(attributes, range: matchRange)
            
            let replaceRange = match!.range(at: 0)
            if let style = attributes[.font] as? UIFont, style == UIFont.boldSystemFont(ofSize: UIFont.systemFontSize) {
                attributedString.replaceCharacters(in: NSRange(location: replaceRange.location, length: 2), with: "")
                attributedString.replaceCharacters(in: NSRange(location: replaceRange.location + matchRange.length - 2, length: 2), with: "")
            } else if let style = attributes[.font] as? UIFont, style == UIFont.italicSystemFont(ofSize: UIFont.systemFontSize) {
                attributedString.replaceCharacters(in: NSRange(location: replaceRange.location, length: 1), with: "")
                attributedString.replaceCharacters(in: NSRange(location: replaceRange.location + matchRange.length - 1, length: 1), with: "")
            }
        }
    }
}

