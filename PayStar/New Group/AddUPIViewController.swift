//
//  AddUPIViewController.swift
//  PayStar
//
//  Created by Swapna Botta on 13/11/19.
//  Copyright © 2019 SwapnaBotta. All rights reserved.
//

import UIKit

class AddUPIViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputUPItextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        inputUPItextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkUPIButton(_ sender: Any) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           
               textField.resignFirstResponder()
              
           return true

       }
    
    @IBAction func sideMenuButton(_ sender: Any) {
           print("in side menu")
           //toggleSideMenuView()
           view?.backgroundColor = UIColor(white: 1, alpha: 0.9)
       }
}
