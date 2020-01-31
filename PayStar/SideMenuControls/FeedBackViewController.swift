
import UIKit
import SwiftKeychainWrapper
import SideMenu
class FeedBackViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate  {

    @IBOutlet weak var containerView: UIView!
    
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
        textView.text = ""
        messageTextView.textColor = UIColor.black
    }
    
    @IBAction func submitButton(_ sender: Any) {
        print("in submit")
        let phoneNUm = phonenumTextfield.text
        if(nameTextfield.text?.isEmpty)!{
            AlertFun.ShowAlert(title: "", message: "Please enter name", in: self)
        }
        else if(subjectTextfield.text?.isEmpty)!{
            AlertFun.ShowAlert(title: "", message: "Please enter subject", in: self)
        }
        else if(phonenumTextfield.text?.isEmpty)!{
            AlertFun.ShowAlert(title: "", message: "Please enter Mobile Number", in: self)
        }
        else if phoneNUm!.count <= 9{
            AlertFun.ShowAlert(title: "", message: "Invalid Mobile Number", in: self)
        }
            
        else if(messageTextView.text?.isEmpty)!{
            AlertFun.ShowAlert(title: "", message: "Please enter Message", in: self)
        }
        else{
            feedbackService()
        }
    }
    
    func feedbackService(){
        
        guard let loginUID: String = KeychainWrapper.standard.string(forKey: "Uid") else{return}
        guard let name: String = nameTextfield.text else{return}
        guard let subject: String = subjectTextfield.text else{return}
        guard let email: String = emailTextfield.text else{return}
        let msg: String = messageTextView.text
        
        let parameters = [
            "user_id": loginUID,
            "name": name,
            "subject": subject,
            "email": email,
            "mobile_number": phonenumTextfield.text as Any,
            "message": msg
            ] as [String : Any]
        let url = URL(string: "https://dev.anyemi.com/webservices/anyemi/feedback")
        var req =  URLRequest(url: url!)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Contet-Type")
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters as Any, options: .prettyPrinted) else {return}
        req.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: req, completionHandler: {(data, response, error) in
            if response != nil {
                // print(response)
            }
            if let data = data {
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                    print("the json of forgotpassword \(json)")
                    
                    let feedBackStatus = json["status"] as? String
                    DispatchQueue.main.async {
                        
                        if feedBackStatus == "Failed"
                        {
                            AlertFun.ShowAlert(title: "", message: json["msg"] as! String, in: self)
                        }
                        else{
                            DispatchQueue.main.async {
                                AlertFun.ShowAlert(title: "", message: "feedback submitted", in: self)
                            }
                        }
                    }
                }catch{
                    print("error")
                }
            }
        }).resume()
    }
 //7093482917 -- feedback
    
    @IBAction func sideMenuButton(_ sender: Any) {
        print("in side menu")
        //toggleSideMenuView()
        //view?.backgroundColor = UIColor(white: 1, alpha: 0.9)
        //containerView?.backgroundColor = UIColor(white: 1, alpha: 0.9)
    }
}
extension FeedBackViewController : UISideMenuNavigationControllerDelegate {
    
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
