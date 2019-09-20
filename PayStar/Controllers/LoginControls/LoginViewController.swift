

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var userIdTextFielf: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logoHeight: NSLayoutConstraint!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var loginButton: UIButton!
    
    var regId: Int?
    var regPhnum: String?
    var regPassword: String?
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        imgLogo.layer.cornerRadius = imgLogo.frame.height/2
        loginButton.layer.cornerRadius = 10
        self.contentLabel.text = "    Designed and Devloped by \n   anyEmi Online Services Pvt Ltd"
        regId = KeychainWrapper.standard.integer(forKey: "id")
        regPhnum = KeychainWrapper.standard.string(forKey: "user_phnum")
        regPassword = KeychainWrapper.standard.string(forKey: "user_password")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    //MARK:- ButtonActions
    
    @IBAction func loginButton(_ sender: Any) {
    
        if (userIdTextFielf.text?.isPhoneNumber)!
        {
        if(userIdTextFielf.text == ""){
            AlertFun.ShowAlert(title: "", message: "Please enter PhoneNumber", in: self)
        }
        else if(passwordTextField.text == ""){
            AlertFun.ShowAlert(title: "", message: "Please enter Password", in: self)
        }
        else if(passwordTextField.text == "") && (userIdTextFielf.text == "") {
            AlertFun.ShowAlert(title: "", message: "Please enter PhoneNumber & Password", in: self)
        }
        else{
            logInService()
        }
        }
        else{
            AlertFun.ShowAlert(title: "", message: "Please enter Valid PhoneNumber", in: self)
        }
    }
    @IBAction func registerButton(_ sender: Any) {
          /*let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
         self.navigationController?.pushViewController(nextViewController, animated: true)
         */
        let regVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        self.present(regVC, animated: true)
    }
    @IBAction func forgotPasswordButton(_ sender: Any) {
        print("forgot button tapped")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //MARK:- Service part
    
    func logInService(){
        
        let parameters = ["username":Int(userIdTextFielf.text ?? ""),
                          "imei_number":"madhavism2012@gmail.com",
                          "password":passwordTextField.text,
                          "name":"name"] as? [String : Any]
        
        let url = URL(string: "https://dev.anyemi.com/webservices/anyemi/login")
        var req =  URLRequest(url: url!)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Contet-Type")
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters as Any, options: .prettyPrinted) else {return}
        req.httpBody = httpBody
        
        let session = URLSession.shared
        
        session.dataTask(with: req, completionHandler: {(data, response, error) in
            if let response = response {
                // print(response)
            }
            if let data = data {
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                    print("the json of loginnnnnn \(json)")
                    
                    let Uid = json["id"] as? String
                    let loginPhoneNum = json["user_id"] as? String
                    let nameL = json["user_name"] as? String
                    let emailL = json["user_email"] as? String
                    /*
                    print("login id \(Uid!)")
                    print("login name \(nameL!)")
                    print("login email \(emailL!)")
                    print("login phnumber \(loginPhoneNum!)")
                    */
                    let saveUserId: Bool = KeychainWrapper.standard.set(Uid ?? "", forKey: "Uid")
                    print("the userid is \(saveUserId)")
                    
                    if (Uid?.isEmpty)!
                    {
                        print("login fail")
                    }
                    else{
                       
                        DispatchQueue.main.async {
                            
                            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                            let navigationController = UINavigationController(rootViewController: homeVC)
                            let appDelagate = UIApplication.shared.delegate
                            appDelagate?.window??.rootViewController = navigationController
                            /*
                            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                            let appDelagate = UIApplication.shared.delegate
                            appDelagate?.window??.rootViewController = homeVC
                            */
                             //if(self.regPhnum == loginPhoneNum){
                             /*  print("login successfullll....!!!!!!")
                             let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                             let homeVC = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                             self.present(homeVC, animated: true, completion: nil)
                             */
                        }
                    }
                    /*DispatchQueue.main.async {
                        
                        //if(self.regPhnum == loginPhoneNum){
                            print("login successfullll....!!!!!!")
                            let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let homeVC = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                            self.present(homeVC, animated: true, completion: nil)
                       // }
                    //else{
                      //      print("login fail")
                        //}
                    }*/
                }catch{
                    print("error")
                }
            }
        }).resume()
    }
}


