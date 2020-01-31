

import UIKit
import Foundation
import SideMenu
import SwiftKeychainWrapper

class MakePaymentViewController: UIViewController, UITextFieldDelegate {
    
    
    
    var scale: Bool = true
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
    @IBOutlet weak var firstContainerView: UIView!
    @IBOutlet weak var secondContainerView: UIView!
    @IBOutlet weak var thirdContainerView: UIView!
    
    
    
    let cornerRadius: CGFloat = 1

    var totalAmount: String?
    //var financerId = [SelectId]()
    var financerId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let yourImage: UIImage = UIImage(named: "logoanyemiBackGround-1")!
        backgroundImage.image = yourImage
        backgroundImage.alpha = 0.5
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        //self.activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        self.view.addSubview(activityIndicator)
        
        
//        firstContainerView.clipsToBounds = false
//        firstContainerView.layer.shadowColor = UIColor.black.cgColor
//        firstContainerView.layer.shadowOpacity = 1
//        firstContainerView.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
//        firstContainerView.layer.shadowRadius = 1
//        firstContainerView.layer.shadowPath = UIBezierPath(roundedRect: firstContainerView.bounds, cornerRadius: cornerRadius).cgPath
//
//        secondContainerView.clipsToBounds = false
//        secondContainerView.layer.shadowColor = UIColor.black.cgColor
//        secondContainerView.layer.shadowOpacity = 1
//        secondContainerView.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
//        secondContainerView.layer.shadowRadius = 1
//        secondContainerView.layer.shadowPath = UIBezierPath(roundedRect: secondContainerView.bounds, cornerRadius: cornerRadius).cgPath
//
//
//        thirdContainerView.clipsToBounds = false
//        thirdContainerView.layer.shadowColor = UIColor.black.cgColor
//        thirdContainerView.layer.shadowOpacity = 1
//        thirdContainerView.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
//        thirdContainerView.layer.shadowRadius = 1
//        thirdContainerView.layer.shadowPath = UIBezierPath(roundedRect: thirdContainerView.bounds, cornerRadius: cornerRadius).cgPath
        
        
        
        
        
        
        
        
        
        serviceNumTextField.delegate = self
        //Do any additional setup after loading the view.
        
        
        
        
        serviceNumTextField.placeholder = "Enter Service Number"

        
        searchButton.backgroundColor = UIColor.clear
        searchButton.layer.cornerRadius = 5
        searchButton.layer.borderWidth = 2
        searchButton.layer.borderColor = UIColor(red: 74/255, green: 218/255, blue: 163/225, alpha: 1).cgColor
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        firstContainerView.addShadow()
        secondContainerView.addShadow()
        thirdContainerView.addShadow()
    }
    @IBAction func sidemMenuButn(_ sender: Any) {
        sideMenuConfig()//toggleSideMenuView()
       // view?.backgroundColor = UIColor(white: 1, alpha: 0.9)

    }
        
    
    @IBAction func makePaymentButton(_ sender: Any) {
        
        let loginUserId = KeychainWrapper.standard.string(forKey: "Uid")
        if loginUserId != nil{
            print("go to payment!!!!")
            
             let makepayVC = self.storyboard?.instantiateViewController(withIdentifier: "MakePaymenyOptionsViewController") as! MakePaymenyOptionsViewController
            makepayVC.amounText = totalAmount

            
            self.navigationController?.pushViewController(makepayVC, animated: true)
            
            
//            let makepayVC = self.storyboard?.instantiateViewController(withIdentifier: "MakePaymenyOptionsViewController") as! MakePaymenyOptionsViewController
//            makepayVC.amounText = totalAmount
//            self.present(makepayVC, animated: true)
//
            //self.navigationController?.present(MakePaymenyOptionsViewController(), animated: true, completion: nil)
        }
        else{
            print("go to login VC")
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(loginVC, animated: true)
        }
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
                print("make payment response \(String(describing: response))")
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
                                self.totalAmount = dueAmount
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
        //let userid = actualInput(for: userIdTextFielf, defaultText: "User ID")

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
extension MakePaymentViewController: UISideMenuNavigationControllerDelegate {

    func sideMenuWillAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
        view.alpha = 0.5
        firstContainerView.alpha = 0.5
        secondContainerView.alpha = 0.5
        thirdContainerView.alpha = 0.5
//        view?.backgroundColor = UIColor(white: 1, alpha: 0.7)
//        firstContainerView?.backgroundColor = UIColor(white: 1, alpha: 0.7)
//        secondContainerView?.backgroundColor = UIColor(white: 1, alpha: 0.7)
//        thirdContainerView?.backgroundColor = UIColor(white: 1, alpha: 0.7)


    }

    func sideMenuDidAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }

    func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
//        view?.backgroundColor = UIColor.white
//        firstContainerView?.backgroundColor = UIColor.white
//        secondContainerView?.backgroundColor = UIColor.white
//        thirdContainerView?.backgroundColor = UIColor.white
        view.alpha = 1
        firstContainerView.alpha = 1
        secondContainerView.alpha = 1
        thirdContainerView.alpha = 1

    }

    func sideMenuDidDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
}
extension UIView {
    func addShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false

        updateShadow()
    }
    func updateShadow() {
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds,cornerRadius: 3).cgPath
    }
}
