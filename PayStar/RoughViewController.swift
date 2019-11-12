
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


