import Foundation

final class CardViewModel {
    var isFront: Bool = true
    
    func flipCard() {
        isFront.toggle()
    }
}
