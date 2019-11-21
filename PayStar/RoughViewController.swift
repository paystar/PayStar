
/*
{
    //  if self.Uid != nil{
    //   if self.regPhnum == self.userIdTextFielf.text && self.regPassword == self.passwordTextField.text{
    let saveUserId: Bool = KeychainWrapper.standard.set(self.Uid!, forKey: "Uid")
    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
    let navigationController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeNavigation")
    let appDelagate = UIApplication.shared.delegate
    appDelagate?.window??.rootViewController = navigationController
    /*}
     else if self.Uid != nil && self.regPassword != self.passwordTextField.text{
     AlertFun.ShowAlert(title: "", message: "entered wrong password", in: self)
     }
     }
     else{
     AlertFun.ShowAlert(title: "", message: "Please register", in: self)
     }
     */
    /*
     if self.regPassword == self.passwordTextField.text {
     AlertFun.ShowAlert(title: "", message: "entered wrong password", in: self)
     }
     else if self.Uid == nil{
     print("login fail")
     AlertFun.ShowAlert(title: "", message: "Please register", in: self)
     }
     else{
     let saveUserId: Bool = KeychainWrapper.standard.set(self.Uid!, forKey: "Uid")
     let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
     let navigationController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeNavigation")
     let appDelagate = UIApplication.shared.delegate
     appDelagate?.window??.rootViewController = navigationController
     }
     */
}
*/

/*
 
 
 func isUserExist(handleComplete:@escaping ((Bool)->())) {
 
 let userId: String? = KeychainWrapper.standard.string(forKey: "Uid")
 DispatchQueue.main.async {
 if userId != nil{
 AlertFun.ShowAlert(title: "Title", message: "This user is Already exist", in: self)
 handleComplete(false)
 }else{
 handleComplete(true)
 }
 }
 
 }
 and call this function where you want to check validate for Uid like this :
 
 self.isUserExist { isExxist in
 if isExxist {
 self.registerService()
 self.otpTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
 }else{
 //here you can do whatever you want
 }
 
 }
 */
//*********************************************

//AllMakePaymentViewController servicecall

/*
 func allPaymentService(){
 
 let urlStr = "https://dev.anyemi.com/webservices/anyemi/api.php?rquest=billermdm"
 let url = URL(string: urlStr)
 URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
 guard let respData = data else {
 return
 }
 guard error == nil else {
 print("error")
 return
 }
 do{
 let jsonObj = try JSONSerialization.jsonObject(with: respData, options: .allowFragments) as! [String: Any]
 //print("the all make payment json is \(jsonObj)")
 let billerdetailsArray = jsonObj["billerdetails"] as! [[String: Any]]
 for billerdetail in billerdetailsArray {
 self.categoryName = billerdetail["bcategoryname"] as? String
 /* print("the category name \(categoryName)")
 
 let categoryNam = KeychainWrapper.standard.string(forKey: "allCatName")
 print("home category name \(categoryNam)")
 if categoryName == categoryNam{
 guard let bName = billerdetail["bname"] as? String else { break }
 self.iteamsArray.append(bName)
 }*/
 if self.categoryName == "Water"{
 let bName = billerdetail["bname"] as? String
 self.iteamsArray.append(bName ?? "")
 }
 else if self.categoryName == "Landline Postpaid"{
 let bName = billerdetail["bname"] as? String
 self.iteamsArray.append(bName ?? "")
 }
 else if self.categoryName == "DTH"{
 let bName = billerdetail["bname"] as? String
 self.iteamsArray.append(bName ?? "")
 }
 }
 DispatchQueue.main.async {
 self.tableView.reloadData()
 }
 }
 catch {
 print("catch error")
 }
 }).resume()
 }*/


/*
 
 extension String {
 
 var isPhoneNumberValid: Bool {
 
 let charcter  = NSCharacterSet(charactersInString: "+0123456789").invertedSet
 var filtered:NSString!
 let inputString:NSArray = self.componentsSeparatedByCharactersInSet(charcter)
 filtered = inputString.componentsJoinedByString("")
 return  self == filtered
 
 }
 
 var isPasswordValid: Bool {
 do {
 let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
 if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil){
 
 if(self.characters.count>=6 && self.count<=20){
 return true
 }else{
 return false
 }
 }else{
 return false
 }
 } catch {
 return false
 }
 }
 }
 
 */
/*

    var waterArray = [String]()
    //billersearch arrays
    var waterParamArray = [String]()
    
    var billerVC: BillerSerarchViewController!
    var category: Category?
    var categoryName: String?
    var paramName: String?
    var labelText: String?
  
            do{
                let jsonObj = try JSONSerialization.jsonObject(with: respData, options: .allowFragments) as! [String: Any]
                //print("the all make payment json is \(jsonObj)")
                let billerdetailsArray = jsonObj["billerdetails"] as! [[String: Any]]
                
                for billerdetail in billerdetailsArray {
                    
                    self.categoryName = billerdetail["bcategoryname"] as? String
                    
                    let customrParams = billerdetail["bcustomerparms"] as! String
                    let res = try JSONSerialization.jsonObject(with:Data(customrParams.utf8)) as! [[String: Any]]
                    
                    for item in res {
                        self.paramName = item["paramName"] as? String
                        //print("the paramNameeeee \(self.paramName)")
                        if self.categoryName == "Water"{
                            let bName = billerdetail["bname"] as? String
                            self.waterArray.append(bName ?? "")
                            self.waterParamArray.append(self.paramName ?? "")
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
           
extension AllMakePaymentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let category = category else {return 0}
        switch category {
        case .water: return waterArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PaymentTableViewCell
        
        guard let category = category else {return cell}
        switch category {
        case .water: cell.pamntTypeLabel.text = waterArray[indexPath.row]
        }
         self.tableView.separatorStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? PaymentTableViewCell
        
        if let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "BillerSerarchViewController") as? BillerSerarchViewController
        {
            switch category {
           
            case .water?: nextViewController.textFieldtext = waterParamArray[indexPath.row]
            nextViewController.labelText = cell?.pamntTypeLabel.text
            case .none:
                print("in didselect switch")
            }
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        else{
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "BillerSerarchViewController") as? BillerSerarchViewController
            self.navigationController?.pushViewController(nextViewController!, animated: true)
        }
    }
}


*/

/*
Bills or Taxes once paid through the payment gateway shall not be refunded other then in the following circumstances:

1. Multiple times debiting of Consumer Card/Bank Account due to ticnical error excluding Payment Gateway charges would be refunded to the consumer with in 1 week after submitting complaint form.
 
 2. Consumers account being debited with excess amount in single transaction due to tecnical error will be deducted in next month transaction.
 
 3. Due to technical error, payment being charged on the consumers Card/Bank Account but the Bill is unsuccessful. However, if in such cases, consumer wishes to seek refund of the amount, after deductionof Payment Gateway charges or any other charges within 1 week after submitting complaint form
 
 In case of any queries, please call anyEMI Online Services Pvt Ltd Helpdesk on +918008612200/5500 or write to helpdesk@anyemi.com



*/

//
//  NewBillerSearchViewController.swift
//  PayStar
//
//  Created by Swapna Botta on 21/11/19.
//  Copyright © 2019 SwapnaBotta. All rights reserved.
//

