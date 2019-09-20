

import UIKit
import MessageUI
class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var phoneNumView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var conformPasswordTextField: UITextField!
    @IBOutlet weak var conformPasswordView: UIView!
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var sendOtpButton: UIButton!
    
    var otpField: Int?
    
    //MARK:- lifecycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.phoneNumTextField.keyboardType = .phonePad
        doneButtonOnKeyboard()
        
        otpTextField.isHidden = true
    }
    
    //MARK:- numberpad stuff
    func doneButtonOnKeyboard(){
        let toolBar: UIToolbar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: "doneClicked")]
        toolBar.sizeToFit()
        phoneNumTextField.inputAccessoryView = toolBar
    }
    @objc func doneClicked(){
        phoneNumTextField.resignFirstResponder()
    }
    //MARK:- Textfield delegate methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if  textField == self.self.conformPasswordTextField {
            animateViewMoving(up: true, moveValue: 60)
        }
        
        if textField == nameTextField{
            nameView.backgroundColor = UIColor.blue
        }
        else if textField == phoneNumTextField{
            phoneNumView.backgroundColor = UIColor.blue
        }
        else if textField == phoneNumTextField{
            phoneNumView.backgroundColor = UIColor.blue
        }
        else if textField == emailTextField{
            emailView.backgroundColor = UIColor.blue
        }
        else if textField == passwordTextField{
            passwordView.backgroundColor = UIColor.blue
        }
        else if textField == conformPasswordTextField{
            conformPasswordView.backgroundColor = UIColor.blue
        }
        else{
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- ButtonActions
    
    @IBAction func backButton(_ sender: Any) {
        
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(loginVC, animated: true)
        
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if (phoneNumTextField.text?.isPhoneNumber)!
        {
            print("valid PhoneNum")
        //if (passwordTextField.text!.isPasswordValid){
        if(nameTextField.text == ""){
            AlertFun.ShowAlert(title: "", message: "Please enter name", in: self)
        }
        else if(phoneNumTextField.text == ""){
            AlertFun.ShowAlert(title: "", message: "Please enter MobileNumber", in: self)
        }
        else if(passwordTextField.text == ""){
            AlertFun.ShowAlert(title: "", message: "Please enter Password", in: self)
        }
        else if(conformPasswordTextField.text == ""){
            AlertFun.ShowAlert(title: "", message: "Please enter ConformPassword", in: self)
        }
        else if(passwordTextField.text != conformPasswordTextField.text)
        {
            AlertFun.ShowAlert(title: "", message: "Please enter SamePassword", in: self)
            /*registerButton.isHidden = true
             sendOtpButton.isHidden = false
             otpTextField.isHidden = false
             registerService()*/
        }
        else if (nameTextField.text ==  "" || phoneNumTextField.text == "" || passwordTextField.text ==  "" || conformPasswordTextField.text == "")
        {
            registerButton.isHidden = false
            sendOtpButton.isHidden = true
            AlertFun.ShowAlert(title: "Title", message: "RequiredAllFields", in: self)
        }
        else{
            registerButton.isHidden = true
            sendOtpButton.isHidden = false
            otpTextField.isHidden = false
            registerService()
            }
       // }
           /* else
            {
                AlertFun.ShowAlert(title: "", message: "Password must contain 8 characters", in: self)
                print("not validPhone")
            }*/
    }
        else
        {
            AlertFun.ShowAlert(title: "", message: "Please enter valid Phonenum", in: self)
            print("not validPhone")
        }
    }
    
    @IBAction func sendOTPButton(_ sender: Any) {
        
        otpService()
    }
    
    //MARK:- Service part
    func registerService(){
        
        print("register tapped")
        
        let parameters = ["mobile_number": Int(phoneNumTextField.text ?? ""),
                          "email":emailTextField.text,
                          "password":passwordTextField.text,
                          "name": nameTextField.text] as? [String : Any]
        
        let url = URL(string: "https://dev.anyemi.com/webservices/anyemi/register")
        var req =  URLRequest(url: url!)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Contet-Type")
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else {return}
        req.httpBody = httpBody
        
        let session = URLSession.shared
        
        session.dataTask(with: req, completionHandler: {(data, response, error) in
            if let response = response {
                // print(response)
            }
            if let data = data {
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                    print("the json regggggggggggis \(json)")
                    
                    let phNum = json["mobile_number"] as? Int
                    //let name = json["name"] as? String
                    //print("the name \(name)")
                    let status = json["status"] as? String
                    self.otpField = json["otp"] as? Int
                    
                    DispatchQueue.main.async {
                        self.otpTextField.text = self.otpField as? String
                    }
                    print("the status is \(status)")
                    print("the userid id \(phNum)")
                    print("the otp is \(self.otpField)")
                }catch{
                    print("error")
                }
            }
        }).resume()
        
        //et nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        //self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func otpService(){
        
        let parameters = ["mobile_number":phoneNumTextField.text,
                          "otp": otpTextField.text] as? [String : Any]
        
        let url = URL(string: "https://dev.anyemi.com/webservices/anyemi/otpverify")
        var req =  URLRequest(url: url!)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Contet-Type")
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else {return}
        req.httpBody = httpBody
        
        let session = URLSession.shared
        
        session.dataTask(with: req, completionHandler: {(data, response, error) in
            if let response = response {
                // print(response)
            }
            if let data = data {
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                    print("the json of otppppppppp \(json)")
                    let Uid = json["id"] as? String
                    let name = json["name"] as? String
                    let email = json["email"] as? String
                    let phNum = json["username"] as? String
                    print("otp id \(Uid)")
                    print("otp name \(name)")
                    print("otp email \(email)")
                    print("otp phnumber \(phNum)")
                    
                    DispatchQueue.main.async {
                        KeychainWrapper.standard.set(Uid ?? "", forKey: "id")
                        KeychainWrapper.standard.set(phNum ?? "", forKey: "user_phnum")
                        KeychainWrapper.standard.set(self.passwordTextField.text!, forKey: "user_password")
                    }
                    /*if (id?.isEmpty)!{
                   print("some error in reg")
                    }
                   else{*/
                    DispatchQueue.main.async {
                        if (self.otpTextField.text == String(self.otpField!)){
                            print("registration successfullllll...")
                             /*let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                             self.navigationController?.pushViewController(nextViewController, animated: true)
                             */
                            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                            self.present(loginVC, animated: true)
                        }
                        else{
                            print("register fail")
                        }
                    }
                 //}
                }catch{
                    print("error")
                }
            }
        }).resume()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //MARK:- Service part

    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    
    /*func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if  textField == self.self.otpTextField {
            animateViewMoving(up: true, moveValue: 60)
        }
    }*/
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if  textField == self.self.conformPasswordTextField {
            animateViewMoving(up: false, moveValue: 60)
        }
    }
}

//MARK:- validations
/*
extension String {
   
    var isPhoneNumber: Bool {
        let PHONE_REGEX = "^[6-9][0-9]{9}$";
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
    var isPasswordValid: Bool{
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        return passwordValidation.evaluate(with: self)
    }
}
*/
