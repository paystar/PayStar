

import UIKit
import MessageUI
import SwiftKeychainWrapper
class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var phoneNumView: UIView!
    @IBOutlet weak var phonenumisIDLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var conformPasswordTextField: UITextField!
    @IBOutlet weak var conformPasswordView: UIView!
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var sendOtpButton: UIButton!
    @IBOutlet weak var otpcountLabel: UILabel!
    @IBOutlet weak var resendButn: UIButton!
    let deviceSize = UIScreen.main.bounds.size
    var otpField: Int?
    var otpTimer = Timer()
    var totalTime = 60
    var regUid: String?
    var savUid: String?
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
        resendButn.isHidden = true
        
    }
    //MARK:- numberpad stuff
    func doneButtonOnKeyboard(){
        let toolBar: UIToolbar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(RegistrationViewController1.doneClicked))]
        toolBar.sizeToFit()
        phoneNumTextField.inputAccessoryView = toolBar
    }
    @objc func doneClicked(){
        phoneNumTextField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumTextField{
            let newStringInTextField = (phoneNumTextField.text as NSString?)?.replacingCharacters(in: range, with: string)
            phonenumisIDLabel.text = newStringInTextField
            phonenumisIDLabel.textColor = UIColor.black
        }
        return true
    }
    //MARK:- Textfield delegate methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        
        if  textField == self.self.conformPasswordTextField {
            animateViewMoving(up: true, moveValue: 60)
        }
        if  textField == self.self.otpTextField {
            animateViewMoving(up: true, moveValue: 90)
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
        if (phoneNumTextField.text?.isPhoneNumberValid)!
        {
            
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
            }
            else if (nameTextField.text ==  "" || phoneNumTextField.text == "" || passwordTextField.text ==  "" || conformPasswordTextField.text == "")
            {
                registerButton.isHidden = false
                sendOtpButton.isHidden = true
                AlertFun.ShowAlert(title: "", message: "RequiredAllFields", in: self)
            }
            else{
                registerButton.isHidden = true
                sendOtpButton.isHidden = false
                otpTextField.isHidden = false
                resendButn.isHidden = false
                otpcountLabel.isHidden = false
                
                
                DispatchQueue.main.async {
                    let strOtp: String?
                                   if let v = self.otpField {
                                      strOtp = "\(v)"
                                       self.otpTextField.text = strOtp
                                   }
                }
                
//                DispatchQueue.main.async {
//                    self.otpTextField.text = self.otpField as? String
//                }
                registerService()
                self.otpTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            }
        }
        else{
            AlertFun.ShowAlert(title: "", message: "Please enter valid PhoneNumber", in: self)
        }
    }
    
    @IBAction func sendOTPButton(_ sender: Any) {
        
        otpService()
        
    }
    
    @IBAction func resendOtpButn(_ sender: Any) {
        print("resendotp tapped")
        otpTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        registerService()
    }
    @objc func update() {
        if(totalTime > 0) {
            totalTime = totalTime - 1
            print(totalTime)
            otpcountLabel.text = String(totalTime)
            resendButn.isEnabled = false
            otpcountLabel.isHidden = false
            //resendButn.setTitle("\(totalTime) Resend Otp", for: .normal)
        }
        else {
            otpcountLabel.isHidden = true
            resendButn.isEnabled = true
            
            otpTimer.invalidate()
            //resendButn.setTitle("Send OTP",for: .normal)

            print("call your api")
            //registerService()
            totalTime = 60
            otpTimer.fire()
            //otpTimer.fire()
            // if you want to reset the time make count = 60 and resendTime.fire()
        }
    }
    
    @IBAction func allreadyUserButn(_ sender: Any) {
        let regVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(regVC, animated: true)
    }
    
    //MARK:- Service part
    @objc func registerService(){
        
        print("register tapped")
        
        let parameters = ["mobile_number": Int(phoneNumTextField.text ?? "") as Any,
                          "email":emailTextField.text as Any,
                          "password":passwordTextField.text as Any,
                          "name": nameTextField.text as Any]
        
        let url = URL(string: "https://dev.anyemi.com/webservices/anyemi/register")
        var req =  URLRequest(url: url!)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Contet-Type")
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else {return}
        req.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: req, completionHandler: {(data, response, error) in
            if response != nil {
                // print(response)
            }
            if let data = data {
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                    let regUserStatus = json["status"] as? String
                    
                    if regUserStatus == "sucess"
                    {
                        print("the json regggggggggggis \(json)")
                        let phNum = json["mobile_number"] as? Int
                        let status = json["status"] as? String
                        print("the ph num \(String(describing: phNum))")
                        print("the ph num \(String(describing: status))")

                        self.otpField = json["otp"] as? Int
                        // self.otpTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
                    }
                    else{
                        DispatchQueue.main.async {
                            self.registerButton.isHidden = false
                            self.sendOtpButton.isHidden = true
                            self.otpTextField.isHidden = true
                            self.resendButn.isHidden = true
                            self.otpcountLabel.isHidden = true
                            self.otpTimer.invalidate()
                            
                            AlertFun.ShowAlert(title: "", message: "user exist", in: self)
                        }
                        
                    }
                }catch{
                    print("error")
                }
            }
        }).resume()
    }
    @objc func otpService(){
        
        let parameters = ["mobile_number": phoneNumTextField.text as Any,
                          "otp": otpTextField.text as Any]
        let url = URL(string: "https://dev.anyemi.com/webservices/anyemi/otpverify")
        var req =  URLRequest(url: url!)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Contet-Type")
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else {return}
        req.httpBody = httpBody
        
        let session = URLSession.shared
        
        session.dataTask(with: req, completionHandler: {(data, response, error) in
            if response != nil {
                // print(response)
            }
            if let data = data {
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                    print("the json of otppppppppp \(json)")
                    DispatchQueue.main.async {
                        if (self.otpTextField.text == String(self.otpField ?? 12)){
                            print("registration successfullllll...")
                            let mobileNum = json["mobile_number"] as! [String : Any]
                            self.regUid = mobileNum["id"] as? String
                            let name = mobileNum["name"] as? String
                            let email = mobileNum["email"] as? String
                            let phNum = mobileNum["username"] as? String
                            print("otp name \(String(describing: name))")
                            print("otp phnumber \(String(describing: phNum))")
                            print("otp uid \(String(describing: self.regUid))")
                            print("otp name \(String(describing: email))")

                            DispatchQueue.main.async {
                                KeychainWrapper.standard.set(self.regUid!, forKey: "regUid")
                                KeychainWrapper.standard.set(phNum!, forKey: "user_phnum")
                                KeychainWrapper.standard.set(self.passwordTextField.text!, forKey: "user_password")
                            }
                            print("the otp uid keywrap \(KeychainWrapper.standard.set(self.regUid!, forKey: "regUid"))")
                            self.otpTimer.invalidate()
                            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                            self.present(loginVC, animated: true)
                        }
                        else if self.otpTextField.text == ""{
                            AlertFun.ShowAlert(title: "", message: "Please enter OTP", in: self)
                            print("register fail")
                        }
                        else {
                            AlertFun.ShowAlert(title: "", message: "Invalid OTP", in: self)
                            print("register fail")
                        }
                    }
                }catch{
                    print("error")
                }
            }
        }).resume()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if  textField == self.self.conformPasswordTextField {
            animateViewMoving(up: false, moveValue: 60)
        }
        if  textField == self.self.otpTextField {
            animateViewMoving(up: false, moveValue: 90)
        }
    }
}
