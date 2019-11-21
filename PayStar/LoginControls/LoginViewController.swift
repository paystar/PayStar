

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var containerViewheight: NSLayoutConstraint!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var userIdTextFielf: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logoHeight: NSLayoutConstraint!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var loginButton: UIButton!
    //9876543212 ---- 1234567
    //let deviceSize = UIScreen.main.bounds.size
    var regId: Int?
    var regPhnum: String?
    var regPassword: String?
    public var Uid: String?
    //var userid: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIdTextFielf.placeholder = "User ID"
        passwordTextField.placeholder = "Password"
        
        userIdTextFielf.text = userIdTextFielf.placeholder
        passwordTextField.text = passwordTextField.placeholder
        
        loginButton.layer.cornerRadius = 10
        self.contentLabel.text = "    Designed & Developed by \n   anyEMI Online Services Pvt Ltd"
        regId = KeychainWrapper.standard.integer(forKey: "id")
        regPhnum = KeychainWrapper.standard.string(forKey: "user_phnum")
        regPassword = KeychainWrapper.standard.string(forKey: "user_password")
    }
   /* func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }*/
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == textField.placeholder
        {
            if textField == passwordTextField
            {
                passwordTextField.isSecureTextEntry = true
            }
            //textField.text.
            textField.text = ""
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField.text?.isEmpty ?? true {
            textField.text = textField.placeholder
            passwordTextField.clearsOnBeginEditing = false
            passwordTextField.isSecureTextEntry = false
        }
    }
    
   
    @IBAction func loginButton(_ sender: Any) {
        let userid = actualInput(for: userIdTextFielf, defaultText: "User ID")
        let password = actualInput(for: passwordTextField, defaultText: "Password")
        
        switch (userid.isEmpty, password.isEmpty) {
        case (true, true):
            AlertFun.ShowAlert(title: "", message: "Please enter User ID and Password", in: self)
            
        case (true, _):
            AlertFun.ShowAlert(title: "", message: "Please enter User ID", in: self)
            
        case (_, true):
            AlertFun.ShowAlert(title: "", message: "Please enter Password", in: self)
            
        default:
            logInService()
        }
    }
    
    func actualInput(for textField: UITextField, defaultText: String) -> String {
        let text = textField.text ?? ""
        if text == defaultText {
            return ""
        } else {
            return text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 280, height: 40))
        toastLabel.backgroundColor = UIColor.gray//black.withAlphaComponent(0.5)
        toastLabel.center = self.view.center
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont(name: "Helvetica Neue", size: 15)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.5
        toastLabel.layer.cornerRadius = 20;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 15.0, delay: 0.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

    @IBAction func registerButton(_ sender: Any) {
        /*let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
         self.navigationController?.pushViewController(nextViewController, animated: true)
         */
        let regVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController1") as! RegistrationViewController1
        self.present(regVC, animated: true)
    }
    @IBAction func forgotPasswordButton(_ sender: Any) {
        print("forgot button tapped")
        
        let userid = actualInput(for: userIdTextFielf, defaultText: "User ID")
        switch (userid.isEmpty){
        case (true):
            AlertFun.ShowAlert(title: "", message: "Please enter PhoneNumber", in: self)
        default:
            forgotPasswordService()
        }
        //self.forgotPasswordService()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    //MARK:- Service part
    func logInService(){
        
        let parameters = ["username":Int(userIdTextFielf.text ?? "") as Any,
                          "imei_number":"madhavism2012@gmail.com",
                          "password":passwordTextField.text as Any,
                          "name":"name"]
        
        let url = URL(string: "https://dev.anyemi.com/webservices/anyemi/login")
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
                    print("the json of loginnnnnn \(json)")
                    var loginStatus = json["status"] as? String
                    print("login status: \(loginStatus)")
                    DispatchQueue.main.async {
                        
                        if loginStatus == "Failed"
                        {
                            AlertFun.ShowAlert(title: "", message: json["msg"] as! String, in: self)
                            
                            //AlertFun.ShowAlert(title: "", message: "Invalid creditials", in: self)
                        }
                            
                        else{
                            self.Uid = json["id"] as? String
                            //let loginPhoneNum = json["user_id"] as! String
                            let nameL = json["user_name"] as? String
                            let emailL = json["user_email"] as? String
                            // print("login email \(emailL!)")
                            print("login uid \(String(describing: self.Uid))")
                            
                        KeychainWrapper.standard.set(self.passwordTextField.text ?? "", forKey:"password")
                            KeychainWrapper.standard.set(emailL ?? "", forKey: "user_email")

                            KeychainWrapper.standard.set(nameL ?? "", forKey: "user_name")

                        var savedPasswrd1: String = KeychainWrapper.standard.string(forKey: "password") ?? ""
                            
                            print("saved login password \(savedPasswrd1)")
                            let saveUserId: Bool = KeychainWrapper.standard.set(self.Uid!, forKey: "Uid")
                           // let savePassword: Bool = KeychainWrapper.standard.set(self.Uid!, forKey: "Uid")

                            // DispatchQueue.main.async {
                            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                            let navigationController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeNavigation")
                            let appDelagate = UIApplication.shared.delegate
                            appDelagate?.window??.rootViewController = navigationController
                            // }
                        }
                    }
                }catch{
                    print("error")
                }
            }
        }).resume()
    }
    
    func forgotPasswordService(){
        let parameters = ["mobile_number":userIdTextFielf.text]
        let url = URL(string: "https://dev.anyemi.com/webservices/anyemi/api.php?rquest=forgetPassword")
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
                    
                    var forgotStatus = json["status"] as? String
                    DispatchQueue.main.async {
                        if forgotStatus == "Failed"
                        {
                            //self.showToast(message: "Password sent to your mobile number")
                            AlertFun.ShowAlert(title: "", message: "Phone number does not exist", in: self)
                        }
                        else{
                            DispatchQueue.main.async {
                                self.showToast(message: "Password sent to your Mobile Number")//#454341
                                //AlertFun.ShowAlert(title: "", message: "Password sent to your mobile number", in: self)
                            }
                        }
                    }
                }catch{
                    print("error")
                }
            }
        }).resume()
    }
}

/*
extension UIScreen {
    
    /// Retrieve the (small) width from portrait mode
    static var portraitWidth : CGFloat { return min(UIScreen.main.bounds.width, UIScreen.main.bounds.size.height) }
    
    /// Retrieve the (big) height from portrait mode
    static var portraitHeight : CGFloat { return max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)  }
    
    /// Retrieve the (big) width from landscape mode
    static var landscapeWidth : CGFloat { return max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) }
    
    /// Retrieve the (small) height from landscape mode
    static var landscapeHeight : CGFloat { return min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) }
}
*/
