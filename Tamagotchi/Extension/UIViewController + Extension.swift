import UIKit

extension UIViewController {
    
    func showAlert(tip message: String) {
        let alertController = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertType2(title: String, message: String, completed: @escaping (() -> Void) ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertActionNo = UIAlertAction(title: "취소", style: .default, handler: nil)
        let alertActionYes = UIAlertAction(title: "확인", style: .default) { [weak self]_ in
            guard let self = self else { return }
            completed()
        }
        alertController.addAction(alertActionNo)
        alertController.addAction(alertActionYes)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
}
