
import UIKit
import Foundation
public class AlertFun {

    class func ShowAlert(title: String, message: String, in vc: UIViewController) {
        DispatchQueue.main.async {

        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
        }
    }
    
}
