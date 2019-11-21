//
//  BillerSerarchViewController.swift
//  PayStar
//
//  Created by Swapna Botta on 02/11/19.
//  Copyright © 2019 SwapnaBotta. All rights reserved.
//

import UIKit

class BillerSerarchViewController: UIViewController, UITextFieldDelegate {

    var billerName : String?
    
    var elMinL: String?
    
    var countText: String?
    
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
        
        countText = searchTextField.text
        print("electrictuyhuik minLength \(elMinL)")
        
        
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
    
    func billerFetchService(){
        
        var textFieldKey: String = KeychainWrapper.standard.string(forKey: "paramName") ?? ""
        print("fetch paramname \(textFieldKey)")
        var textFieldValue: String = searchTextField.text as? String ?? ""
        var billerID: String = KeychainWrapper.standard.string(forKey: "billerId") ?? ""
        print("fetch BILLER ID \(billerID)")

        
        let parameters = ["billDetails": [
            "billerId" : "EPDCLOB00ANP01",
        "customerParams" : [["name": textFieldKey,"value": textFieldValue]]]] as [String : Any]

        let url = URL(string: "https://app.anyemi.com/anyemi_v1/fetch")
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
                    var json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                   // print("fetching json \(json)")
                    let fetchStatus = json["status"] as? String
                    
   
                    if fetchStatus == "sucess"{
                        let billerDetails = json["response"] as! [String:Any]
                        let value = billerDetails["billerResponse"] as! String
                        print(value)
                        
                        let res = try JSONSerialization.jsonObject(with:Data(value.utf8)) as! [String: Any]
                         self.billerName = res["billerName"] as? String
                         var servcNumber = res["fieldValue"] as? String
                         var consumName = res["customerName"] as? String
                         var bDate = res["billDate"] as? String
                         var bPerd = res["billPeriod"] as? String
                         var bNum = res["billNumber"] as? String
                         var bDueDate = res["dueDate"] as? String
                         var amount = res["amount"] as? Double
                    
                    
                    print("fetch only APEPDCL biller name \(self.billerName)")
                    DispatchQueue.main.async {

                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "FetchBillerViewController") as? FetchBillerViewController
                        nextViewController?.nameText = self.billerName
                        nextViewController?.servcNum = servcNumber
                        nextViewController?.consumrName = consumName
                        nextViewController?.billerDate = bDate
                        nextViewController?.bPeropd = bPerd
                        nextViewController?.bNumber = bNum
                        nextViewController?.dueDate = bDueDate
                        nextViewController?.amount = amount
                        self.navigationController?.pushViewController(nextViewController!, animated: true)
                    }

                    }
                    else{
                        DispatchQueue.main.async {

                        AlertFun.ShowAlert(title: "", message: "Invalid service Number", in: self)
                        }
                    }
                    
                   
                }catch{
                    print("error")
                }
            }
        }).resume()
    }

    @IBAction func searchButton(_ sender: Any) {
        print("search papped")
//        if countText?.count >= elMinL {
//            AlertFun.ShowAlert(title: "", message: "count not more then 8", in: self)
//
//        }
        billerFetchService()


    }
    
    
}
