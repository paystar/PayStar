
import UIKit
import CoreData
import SwiftKeychainWrapper

class UserProfileCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var icons:UIImageView!
}
struct ProfileStruct {
    var name: String!
    var img: UIImage!
}

class LeftMenuVC: UIViewController {
    var dataArr = [ProfileStruct]()
    var dataArr1 = [ProfileStruct]()

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var userTbl: UITableView!
    var userName: String?
    var userPhone: String?
    let userId: String? = KeychainWrapper.standard.string(forKey: "Uid")

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    var loginEmail: String?
    var loginName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArr = [ProfileStruct(name: "Login", img:UIImage(named: "loin")), ProfileStruct(name: "Home", img:UIImage(named: "h1 2")), ProfileStruct(name: "Collections", img:UIImage(named: "collec")), ProfileStruct(name: "About Us", img:UIImage(named: "a5")), ProfileStruct(name: "Terms & Conditions", img:UIImage(named: "m1")), ProfileStruct(name: "Contact Us", img:UIImage(named: "cu")),ProfileStruct(name: "Refund & Cancellation", img:UIImage(named: "cancellation")), ProfileStruct(name: "Privacy Policy", img:UIImage(named: "pps")), ProfileStruct(name: "FeedBack", img:UIImage(named: "feedb"))]
      
        
        dataArr1 = [ProfileStruct(name: "Home", img:UIImage(named: "h1 2")), ProfileStruct(name: "Collections", img:UIImage(named: "collec")), ProfileStruct(name: "About Us", img:UIImage(named: "a5")),ProfileStruct(name: "Profile", img:UIImage(named: "profile")), ProfileStruct(name: "Terms & Conditions", img:UIImage(named: "m1")), ProfileStruct(name: "Contact Us", img:UIImage(named: "cu")), ProfileStruct(name: "Refund & Cancellation", img:UIImage(named: "cancellation")), ProfileStruct(name: "Privacy Policy", img:UIImage(named: "pps")), ProfileStruct(name: "FeedBack", img:UIImage(named: "feedb")), ProfileStruct(name: "SignOut", img:UIImage(named: "signout"))]
        
        loginEmail = KeychainWrapper.standard.string(forKey: "user_email")
        loginName = KeychainWrapper.standard.string(forKey: "user_name")
        emailVal()
        
        userTbl.tableFooterView = UIView(frame: .zero)
        userTbl.separatorStyle = .none
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
   /* @objc func languageDidChange(notification: NSNotification){
        userTbl.reloadData()
    }*/
}

//MARK:- tableview delegate
extension LeftMenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userId != nil {
            return dataArr1.count
        }
      return  dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UserProfileCell
        
        //cell.lblTitle.text = dataArr[indexPath.row].name
        //cell.icons.image = dataArr[indexPath.row].img
        if userId != nil{
            cell.lblTitle.text = dataArr1[indexPath.row].name
            cell.icons.image = dataArr1[indexPath.row].img
            cell.lblTitle.highlightedTextColor = UIColor.blue
        }
        else{
            cell.lblTitle.text = dataArr[indexPath.row].name
            cell.icons.image = dataArr[indexPath.row].img
            cell.lblTitle.highlightedTextColor = UIColor.blue
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    
    func emailVal(){
        if userId != nil{
            emailLabel.text = loginEmail//"anyemi@gmail.com"
            nameLabel.text = loginName
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if userId != nil {
            if indexPath.row == 0 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 1 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "CollectionsViewController") as! CollectionsViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 2 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "AboutUsController") as! AboutUsController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 3 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 4 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "TermsandConditionsViewController") as! TermsandConditionsViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 5 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 6 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "RefundandCancellationViewController") as! RefundandCancellationViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 7 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 8 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "FeedBackViewController") as! FeedBackViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 9 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
                KeychainWrapper.standard.removeObject(forKey: "Uid")//(key: "Uid")
            }
        }
         else{
            if indexPath.row == 0 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 1 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 2 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 3 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "AboutUsController") as! AboutUsController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 4 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "TermsandConditionsViewController") as! TermsandConditionsViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 5 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 6 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "RefundandCancellationViewController") as! RefundandCancellationViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 7 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 8 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(vc, animated: true)

//                let vc = storyboard?.instantiateViewController(withIdentifier: "FeedBackViewController") as! FeedBackViewController
//                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
