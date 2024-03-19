import UIKit

public enum ConfirmManager {
    public static func makeAlert(title: String, message: String, action: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            action()
        }
        alert.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cancelAction)
        
        return alert
    }
}
