//
//  ProfileViewController.swift
//  PayStar
//
//  Created by Swapna Botta on 13/11/19.
//  Copyright © 2019 SwapnaBotta. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import SideMenu

class ProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var oldPasswordTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var popupView: UIView!
    //var loginUID: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.isHidden = true
        oldPasswordTextfield.delegate = self
        passwordTextField.delegate = self
        confirmPassword.delegate = self
        
        
//        let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
//        var set = SideMenuSettings()
//        set.statusBarEndAlpha = 0
//        set.presentationStyle = SideMenuPresentationStyle.menuSlideIn
//        set.presentationStyle.presentingEndAlpha = 0.5
//
//
//        set.menuWidth = min(view.frame.width, view.frame.height) * 0.90
//        //menu.sideMenuManager.addScreenEdgePanGesturesToPresent(toView: self.view)
//        menu.settings = set
//        //SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
//        SideMenuManager.default.leftMenuNavigationController = menu
//
        
        
        //sideMenuConfig()
        
        
        
        
        //loginUID =
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == oldPasswordTextfield || textField == passwordTextField || textField == confirmPassword{
            textField.resignFirstResponder()
            return true

        }
        return true

    }
    @IBAction func popSubmitButn(_ sender: Any) {
        
        let passwordCount = passwordTextField.text

        if(oldPasswordTextfield.text?.isEmpty)!{
            AlertFun.ShowAlert(title: "", message: "Please enter old password", in: self)
        }
        else if(passwordTextField.text?.isEmpty)!{
            AlertFun.ShowAlert(title: "", message: "Please enter password", in: self)
        }
        else if passwordCount!.count <= 5{
            AlertFun.ShowAlert(title: "", message: "Password atleat contains 6 characters", in: self)
        }
        else if(confirmPassword.text?.isEmpty)!{
            AlertFun.ShowAlert(title: "", message: "Please enter confirm password", in: self)
        }
        else if(passwordTextField.text != confirmPassword.text)
        {
            AlertFun.ShowAlert(title: "", message: "Password and Confirm Password doesn't Match", in: self)
        }
        else{
            changePasswordService()
           //registerService()
        }
    }
    func changePasswordService(){
        guard let loginUID: String = KeychainWrapper.standard.string(forKey: "Uid") else {return}
        print("login uid in profile\(loginUID)")
        let loginPassword: String = KeychainWrapper.standard.string(forKey: "password") ?? ""
        
        print("login password in profilrVC: \(loginPassword)")
        let parameters = ["user_id": loginUID,
                          "old_password": oldPasswordTextfield.text as Any,
                          "new_password": passwordTextField.text as Any
                         ] as [String : Any]
        
        let url = URL(string: "https://dev.anyemi.com/webservices/anyemi/changePassword")
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
                    print("the json of change password \(json)")
                    
                    let changePasswordStatus = json["status"] as? String
                    DispatchQueue.main.async {
                        //Success
                        
                        if changePasswordStatus == "Failed"
                        {
                            AlertFun.ShowAlert(title: "", message: json["Description"] as! String, in: self)
                        }
                        else{
                            if loginPassword == self.oldPasswordTextfield.text {
                                DispatchQueue.main.async {
                                    //AlertFun.ShowAlert(title: "", message: json["msg"] as! String, in: self)
                                    self.showToast(message: json["msg"] as! String)//#454341

                                    self.popupView.isHidden = true
                                    self.view?.backgroundColor = .white

                                    KeychainWrapper.standard.removeObject(forKey: "password")
                                    print("after chenged password \(loginPassword)")
                                    KeychainWrapper.standard.set(self.passwordTextField.text ?? "", forKey: "password")//9876543219--222222//8908908900---123123
                                }
                            }
                        }
                      
                    }
                }catch{
                    print("error")
                }
            }
        }).resume()
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view != self.popupView {
            dismissView()
        }
    }
    
    func dismissView() {
        self.popupView.isHidden = true
        view?.backgroundColor = .white
    }
    
    @IBAction func changePasswordButn(_ sender: Any) {
        view?.backgroundColor = UIColor(white: 1, alpha: 0.7)
        popupView.isHidden = false
    }
    @IBAction func addUPIButn(_ sender: Any) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddUPIViewController") as? AddUPIViewController
        self.navigationController?.pushViewController(nextViewController!, animated: true)
    }
    @IBAction func removeUpiButon(_ sender: Any) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "RemoveUPIViewController") as? RemoveUPIViewController
        self.navigationController?.pushViewController(nextViewController!, animated: true)
    }
    
     @IBAction func sideMenuButton(_ sender: Any) {
           print("in side menu")
           //toggleSideMenuView()
           //view?.backgroundColor = UIColor(white: 1, alpha: 0.9)
       }
    func sideMenuConfig(){
        // Define the menus
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "UISideMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuFadeStatusBar  = false

        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)

        // Set up a cool background image for demo purposes
    }
    
    func sidemenuOpenCloseColorChang(){

//        let menu = storyboard!.instantiateViewController(withIdentifier: "UISideMenuNavigationController") as! UISideMenuNavigationController
//        var set = SideMenuSettings()
//        set.statusBarEndAlpha = 0
//        set.presentationStyle = SideMenuPresentationStyle.menuSlideIn
//        set.presentationStyle.presentingEndAlpha = 0.5
//
//        set.menuWidth = min(view.frame.width, view.frame.height) * 0.90
//        //menu.sideMenuManager.addScreenEdgePanGesturesToPresent(toView: self.view)
//        menu.settings = set
//        //SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
//        SideMenuManager.default.leftMenuNavigationController = menu
    }
}

//extension ProfileViewController : UISideMenuNavigationControllerDelegate {
//    internal func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
//    //*do the color thing*
//        print("sidemenu disappear")
//
//    view?.backgroundColor = UIColor.white
//}
//}


extension ProfileViewController : UISideMenuNavigationControllerDelegate {
    
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
