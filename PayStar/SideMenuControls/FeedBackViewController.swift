
import UIKit
class FeedBackViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate  {

    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var subjectTextfield: UITextField!
    @IBOutlet weak var subjectView: UIView!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var phonenumTextfield: UITextField!
    @IBOutlet weak var phnumView: UIView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var messView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        
        messageTextView.resignFirstResponder()
        
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            
            textView.resignFirstResponder()
            return true
            
        }
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text == ""
    }
    @IBAction func sideMenuButn(_ sender: Any) {
        toggleSideMenuView()
    }

}
