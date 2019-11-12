//
//  BillerSerarchViewController.swift
//  PayStar
//
//  Created by Swapna Botta on 02/11/19.
//  Copyright © 2019 SwapnaBotta. All rights reserved.
//

import UIKit

class BillerSerarchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var topnameLabel: UILabel!
    var textFieldtext: String?
    var labelText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBtn.backgroundColor = UIColor.clear
        searchBtn.layer.cornerRadius = 5
        searchBtn.layer.borderWidth = 0.5//rgb(12, 20, 70
        searchBtn.layer.borderColor = UIColor(red: 12/255, green: 20/255, blue: 70/225, alpha: 1).cgColor
        
        searchTextField.delegate = self
        searchTextField.text = textFieldtext
        topnameLabel.text = labelText
        //searchTextField.text = "dhuhj"
        // Do any additional setup after loading the view.
    }

    @IBAction func bachButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func searchButton(_ sender: Any) {
        print("search papped")
    }
    
    
    
}
