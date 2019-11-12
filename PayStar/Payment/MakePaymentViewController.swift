

import UIKit
import Foundation
import SideMenu
class MakePaymentViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var serviceNumTextField: UITextField!
    @IBOutlet weak var nameIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var callIcon: UIImageView!
    @IBOutlet weak var callLabel: UILabel!
    @IBOutlet weak var serviceNumIcon: UIImageView!
    @IBOutlet weak var serviceNumLabel: UILabel!
    @IBOutlet weak var fatherNameIcon: UIImageView!
    @IBOutlet weak var fatherNameLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueamountLabel: UILabel!
    @IBOutlet weak var servicechargeLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    var nsobjJson: JsonFields?
    //var financerId = [SelectId]()
    var financerId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var yourImage: UIImage = UIImage(named: "logoanyemiBackGround-1")!
        backgroundImage.image = yourImage
        backgroundImage.alpha = 0.5
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        //self.activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        self.view.addSubview(activityIndicator)
        
        serviceNumTextField.delegate = self
        //Do any additional setup after loading the view.
        searchButton.backgroundColor = UIColor.clear
        searchButton.layer.cornerRadius = 5
        searchButton.layer.borderWidth = 2
        searchButton.layer.borderColor = UIColor(red: 74/255, green: 218/255, blue: 163/225, alpha: 1).cgColor
    }
    
    @IBAction func sidemMenuButn(_ sender: Any) {
        sideMenuConfig()//toggleSideMenuView()
    }
    
    @IBAction func makePaymentButton(_ sender: Any) {
        
        
        let loginUserId = KeychainWrapper.standard.string(forKey: "Uid")
        if loginUserId != nil{
            print("go to payment!!!!")
        }
        else{
            print("go to login VC")
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(loginVC, animated: true)
        }
        
        /*let payOption = self.storyboard?.instantiateViewController(withIdentifier: "PaymentOptionsViewController") as! PaymentOptionsViewController
         self.navigationController?.pushViewController(payOption, animated: true)
         */
        //self.navigationController?.present(PaymentOptionsViewController(), animated: true)
    }
    func makePaymentService(){
        
        let parameters = ["assessmentNo":  Int(serviceNumTextField.text ?? "") as Any,
                          "taxtype":"tax_type",
                          "finance":"4",
                          "user_id":""]
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        
        let url = URL(string: "https://dev.anyemi.com/webservices/anyemi/getassment_details")
        var req =  URLRequest(url: url!)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Contet-Type")
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else {return}
        req.httpBody = httpBody
        let session = URLSession.shared
        
        session.dataTask(with: req, completionHandler: {(data, response, error) in
            if response != nil {
                print("make payment response \(response)")
            }
            if let data = data {
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                    
                    let status = json["status"] as? String
                    if status == "Success"{
                        
                        print("the json for make payment \(json)")
                        
                        let emiArray = json["emi"] as! [[String : Any]]
                        let loanDetails = json["loan_details"] as! [String : Any]
                        let userPhNum = loanDetails["phone"] as? String
                        let adderss = loanDetails["address"] as? String//financer
                        //let financerId = loanDetails["financer"] as? String
                        //self.financerId = loanDetails["financer"] as? String
                        //KeychainWrapper.standard.set(self.financerId ?? "", forKey: "financer")
                        
                        KeychainWrapper.standard.set(self.nsobjJson?.finId ?? "", forKey: "financer")
                        
                        print("payment financerid \(String(describing: self.financerId))")
                        for detail in emiArray{
                            let userName = detail["customer"] as? String
                            print("make user name \(String(describing: userName))")
                            let serviceNum = detail["loan_number"] as? String
                            let dueDate = detail["due_date"] as? String
                            let dueAmount = detail["emi_amount"] as? String
                            
                            DispatchQueue.main.async {
                                self.nameLabel.text = userName
                                self.callLabel.text = userPhNum
                                
                                self.serviceNumLabel.text = serviceNum
                                //self.dueDateLabel.text = dueDate
                                self.dueDateLabel.text = dueDate
                                
                                /*let dateFormatter = DateFormatter()
                                 let datePicker = UIDatePicker()
                                 let dueDateJson: NSDate = dueDate as? NSDate ?? ""
                                 dateFormatter.dateFormat = "d-MMM-yyyy"
                                 self.dueDateLabel.text = dateFormatter.string(from: datePicker.date)
                                 */
                                self.fatherNameLabel.text = adderss
                                let dueAmnt = dueAmount
                                let rsSymbol = "\u{20B9}";
                                
                                self.dueamountLabel.text = (rsSymbol)  +  " "  + (dueAmnt!)
                                self.servicechargeLabel.text = "\u{20B9}";
                                self.totalLabel.text = (rsSymbol)  +  " "  + (dueAmnt!)
                            }      
                        }
                    }
                        
                    else{
                        
                        DispatchQueue.main.async {
                            AlertFun.ShowAlert(title: "", message: "Assessment Number not found", in: self)
                        }
                    }
                    
                    
                }catch{
                    print("error")
                }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
            }
        }).resume()
        //et nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        //self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func dateFormating(){
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func searchBtnTapped(_ sender: Any) {
        
        let servcNum = actualInput(for: serviceNumTextField, defaultText: "Enter Service Number")
        switch (servcNum.isEmpty){
        case (true):
            AlertFun.ShowAlert(title: "", message: "Service number should not be empty", in: self)
        default:
            makePaymentService()
        }
        
        //makePaymentService()
    }
    func actualInput(for textField: UITextField, defaultText: String) -> String {
        let text = textField.text ?? ""
        if text == defaultText {
            return ""
        } else {
            return text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    func sideMenuConfig(){
        // Define the menus
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuVC") as? UISideMenuNavigationController
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuFadeStatusBar  = false
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        // Set up a cool background image for demo purposes
    }
}
