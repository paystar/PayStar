
import UIKit
import SideMenu
class RefundandCancellationViewController: UIViewController {
   
    @IBOutlet weak var refundTextview: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let heading = "Bills or Taxes once paid through the payment gateway shall not be refunded other then in the following circumstances:"
        
        let content = "\n \n 1. Multiple times debiting of Consumer Card/Bank Account due to tichnical error excluding Payment Gateway charges would be refunded to the consumer with in 1 week after submitting complaint form. \n \n 2. Consumers account being debited with excess amount in single transaction due to technical error will be deducted in next month transaction. \n \n 3. Due to technical error, payment being charged on the consumer's Card/Bank Account but the Bill is unsuccessful. However, if in such cases, consumer wishes to seek refund of the amount, he/she would be refunded net the amount, after deduction of Payment Gateway charges or any other charges within 1 week after submitting complaint form \n \n In case of any queries, please call anyEMI Online Services Pvt Ltd Helpdesk on +918008612200/5500 or write to helpdesk@anyemi.com"
        
        refundTextview.isEditable = false
        refundTextview.textColor = UIColor.gray
        refundTextview.isScrollEnabled = false

        let attributedText = NSMutableAttributedString(string: heading, attributes: [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20) as Any,NSAttributedString.Key.foregroundColor: UIColor.gray])
        
       // UIFont(name: "HelveticaNeue-Bold", size: 20)!, NSAttributedStringKey.foregroundColor: UIColor.green]
        
        attributedText.append(NSAttributedString(string: content, attributes: [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 20) as Any, NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        refundTextview.attributedText = attributedText
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refundTextview.isScrollEnabled = true

    }
    
    
    @IBAction func sideMenuButton(_ sender: Any) {
           print("in side menu")
           //toggleSideMenuView()
           view?.backgroundColor = UIColor(white: 1, alpha: 0.9)
       }
}
extension RefundandCancellationViewController : UISideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
        view.alpha = 0.5
    }
     func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
    //*do the color thing*
        print("sidemenu disappear")
        view.alpha = 1
        
}
}

