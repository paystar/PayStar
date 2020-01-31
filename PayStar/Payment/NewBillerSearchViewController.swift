//
//  NewBillerSearchViewController.swift
//  PayStar
//
//  Created by Swapna Botta on 21/11/19.
//  Copyright © 2019 SwapnaBotta. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class NewBillerSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var billerName : String?
    var finalSearchValue : String = ""
    var finalSearchValueAmnt : String = ""
    var hasFinalSearchValueAmnt : Bool = false
    var rowCount: Int?
    var textCount: Int?
    var alertMinL: Int?
    var alertMaxL: Int?
    var alertParam: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var topLabel: UILabel!
    var cell : BillerTableViewCell?

    var textFieldArray = [String]()
    var selectedBiller: JsonDataBiller?
    var toplabeText: String?
    var textFieldValue =  [String]()
    
    var saveBillerId: String = ""
    
    //let count = tableView.numberOfRows(inSection: 0)
    //let indexPaths = (0..<rowCount).map{IndexPath(row: $0, section: 0)}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.text = toplabeText
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.separatorStyle = .none
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let indexPaths = (0..<rowCount ?? 0).map{IndexPath(row: $0, section: 0)}

        if section == 0 {
            
            self.rowCount = selectedBiller?.bcustomerparms.count ?? 0
            if selectedBiller?.bcategoryname == "Mobile Postpaid"{
                if selectedBiller?.bname == "Vodafone Postpaid (Fetch u0026 Pay)"  || selectedBiller?.bname == "Airtel Postpaid (Fetch u0026 Pay)" || selectedBiller?.bname == "BSNL Mobile Postpaid"
                {
                    return selectedBiller?.bcustomerparms.count ?? 0
                }
                
            return  self.rowCount! + 1
            }
            if selectedBiller?.bcategoryname == "DTH"{
                if selectedBiller?.bname == "Sun Direct TV (With Validation)"
                {
                    return rowCount!+1
                }
                return  self.rowCount! + 1
            }
            else{
                return rowCount ?? 0//selectedBiller?.bcustomerparms.count ?? 0
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "textfieldCell", for: indexPath) as? BillerTableViewCell
            cell?.searchTextfield.delegate = self

            if self.rowCount! - 1 >= indexPath.row
            {
             if let customerDetail = selectedBiller?.bcustomerparms[indexPath.row] {
                
                alertParam = customerDetail.paramName
                KeychainWrapper.standard.set(alertParam ?? "", forKey: "paramName")
                cell?.searchTextfield.text = alertParam
                if let strMinlngth: String = customerDetail.minLength {
                    alertMinL = Int(strMinlngth)
                }
                if let strMaxlngth: String = customerDetail.maxLength {
                    alertMaxL = Int(strMaxlngth)
                }
                cell?.searchTextfield.addTarget(self, action: #selector(searchPhoneEditingChanged(textField:)), for: .editingChanged)
            }
             else{
                print("no tf")
                cell?.searchTextfield.text = "missing"
                }
            }
        else{
            cell?.searchTextfield.text = "Amount"
                hasFinalSearchValueAmnt  = true
                cell?.searchTextfield.placeholder = "Amount"
            cell?.searchTextfield.addTarget(self, action: #selector(searchAmountEditingChanged(textField:)), for: .editingChanged)
            }
            
            //cell?.searchTextfield.addTarget(self, action: #selector(searchAmountEditingChanged(textField:)), for: .editingChanged)
            //cell?.searchTextfield.addTarget(self, action: #selector(searchPhoneEditingChanged(textField:)), for: .editingChanged)
        } else if indexPath.section == 1 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as? BillerTableViewCell
            cell?.searchButton.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
            cell?.searchButton.backgroundColor = UIColor.clear
            cell?.searchButton.layer.cornerRadius = 5
            cell?.searchButton.layer.borderWidth = 0.5//rgb(12, 20, 70
            cell?.searchButton.layer.borderColor = UIColor(red: 12/255, green: 20/255, blue: 70/225, alpha: 1).cgColor
            
            if selectedBiller?.bcategoryname == "Mobile Postpaid" || selectedBiller?.bcategoryname == "DTH"{
                cell?.searchButton.setTitle("Pay", for: .normal)
            }
        }
        return cell!
    }
    
    @objc func searchPhoneEditingChanged(textField: UITextField) {
        finalSearchValue = textField.text!
        self.textCount = self.finalSearchValue.count
    }
    
    @objc func searchAmountEditingChanged(textField: UITextField) {
        finalSearchValueAmnt = textField.text!
        //self.textCount = self.finalSearchValue.count
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if hasFinalSearchValueAmnt == false{
        textField.placeholder = alertParam
            
        }
       //textField.text = alertParam
        //hasFinalSearchValueAmnt = true
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 55
        }
        return 40
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text == alertParam{
            textField.text = ""
        }
        else if hasFinalSearchValueAmnt{
          //  alertParam = ""
        }
        else{
            textField.text = finalSearchValue
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func buttonClicked(sender: UIButton) {
        //let buttonRow = sender.tag
        print("in newbiller search button")
        print("the amount value \(finalSearchValueAmnt)")
        print("the phone value \(finalSearchValue)")

        if self.finalSearchValue.isEmpty{
            AlertFun.ShowAlert(title: "", message: "Please enter \(self.alertParam ?? "")", in: self)
        }
        else if self.textCount ?? 0 < self.alertMinL ?? 0{
            AlertFun.ShowAlert(title: "", message: "\(self.alertParam ?? "") Not Less Than \(self.alertMinL ?? 0)", in: self)
        }
        else if self.textCount ?? 0 > self.alertMaxL ?? 0{
            AlertFun.ShowAlert(title: "", message: "\(self.alertParam ?? "") Not More Than \(self.alertMaxL ?? 0)", in: self)
        }
        else if self.finalSearchValueAmnt.isEmpty && hasFinalSearchValueAmnt{
            AlertFun.ShowAlert(title: "", message: "Please enter Amount", in: self)
        }
        else{
        billerFetchService()
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func billerFetchService(){
        
        let textFieldKey: String = KeychainWrapper.standard.string(forKey: "paramName") ?? ""
        print("fetch paramname \(textFieldKey)")
       // var textFieldValue: String = (cell?.searchTextfield.text)!
        
        print("fetch BILLER ID \(saveBillerId)")
        
//        let parameters = ["billDetails": [
//            "billerId" : saveBillerId,
//            "customerParams" : [["name": textFieldKey,"value": finalSearchValue]]]] as [String : Any]
        
        
        let parameters = ["billDetails": [
                   "billerId" : saveBillerId,
                   "customerParams" : [["name": textFieldKey,"value": finalSearchValue]]]] as [String : Any]
        
        print("the textfield value is  \(finalSearchValue)")
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
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                     print("fetching json \(json)")
                    let fetchStatus = json["status"] as? String
                    print("fetching json status \(String(describing: fetchStatus))")

                    if fetchStatus == "sucess"{
                        
                        let billerDetails = json["response"] as! [String:Any]
                        let value = billerDetails["billerResponse"] as! String
                        print(value)
                        let res = try JSONSerialization.jsonObject(with:Data(value.utf8)) as! [String: Any]
                        self.billerName = res["billerName"] as? String
                        let servcNumber = res["fieldValue"] as? String
                        let consumName = res["customerName"] as? String
                        let bDate = res["billDate"] as? String
                        let bPerd = res["billPeriod"] as? String
                        let bNum = res["billNumber"] as? String
                        let bDueDate = res["dueDate"] as? String
                        let amount = res["amount"] as? Double
                        
                        print("fetch only APEPDCL biller name \(String(describing: self.billerName))")
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
                            
                            AlertFun.ShowAlert(title: "", message: json["msg"] as! String, in: self)
                            //AlertFun.ShowAlert(title: "", message: json["msg"] as! String, in: self)
                        }
                    }
                }catch{
                    print("error")
                }
            }
        }).resume()
    }
}
//extension UITextField {
//
//    var isEmpty: Bool {
//        if let text = textField.text, !text.isEmpty {
//            return false
//        }
//        return true
//    }
//}
