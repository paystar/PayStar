//
//  NewBillerSearchViewController.swift
//  PayStar
//
//  Created by Swapna Botta on 21/11/19.
//  Copyright © 2019 SwapnaBotta. All rights reserved.
//

import UIKit

class NewBillerSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var billerName : String?

    
    var finalSearchValue : String = ""

    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var topLabel: UILabel!
    var cell : BillerTableViewCell?

    var textFieldArray = [String]()
    var selectedBiller: JsonDataBiller?
    var toplabeText: String?
    
    var textFieldValue =  [String]()
    
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
        if section == 0 {
            return selectedBiller?.bcustomerparms.count ?? 0
        }
        return 1
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // var cell : BillerTableViewCell?

        if indexPath.section == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "textfieldCell", for: indexPath) as! BillerTableViewCell
            
            cell?.searchTextfield.delegate = self

            if let param = selectedBiller?.bcustomerparms[indexPath.row] {
                cell?.searchTextfield.text = param.paramName
                
               // cell?.searchTextfield.text = textFieldValue[indexPath.row]
            } else {
                cell?.searchTextfield.text = "missing data"
            }
            cell?.searchTextfield.addTarget(self, action: #selector(searchEditingChanged(textField:)), for: .editingChanged)

            //cell?.searchTextfield.text = textFieldArray[indexPath.row]
            
        } else if indexPath.section == 1 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! BillerTableViewCell
            cell?.searchButton.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
            cell?.searchButton.backgroundColor = UIColor.clear
            cell?.searchButton.layer.cornerRadius = 5
            cell?.searchButton.layer.borderWidth = 0.5//rgb(12, 20, 70
            cell?.searchButton.layer.borderColor = UIColor(red: 12/255, green: 20/255, blue: 70/225, alpha: 1).cgColor
        }
        return cell!
    }
    @objc func searchEditingChanged(textField: UITextField) {
        finalSearchValue = textField.text!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 55
        }
        return 40
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func buttonClicked(sender: UIButton) {
        //let buttonRow = sender.tag
        print("in newbiller search button")
        billerFetchService()

    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func billerFetchService(){
        
        var textFieldKey: String = KeychainWrapper.standard.string(forKey: "paramName") ?? ""
        print("fetch paramname \(textFieldKey)")
       // var textFieldValue: String = (cell?.searchTextfield.text)!
        var billerID: String = KeychainWrapper.standard.string(forKey: "billerId") ?? ""
        print("fetch BILLER ID \(billerID)")
        
        let parameters = ["billDetails": [
            "billerId" : "EPDCLOB00ANP01",
            "customerParams" : [["name": textFieldKey,"value": finalSearchValue]]]] as [String : Any]
        
        
        print("the textfield value is  \(textFieldValue)")
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
    
}
