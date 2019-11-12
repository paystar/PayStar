
import UIKit
import CoreData

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
    var loginEmail: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArr = [ProfileStruct(name: "LogIn", img:UIImage(named: "loin")), ProfileStruct(name: "Home", img:UIImage(named: "h1 2")),ProfileStruct(name: "About Us", img:UIImage(named: "a5")), ProfileStruct(name: "Terms & Conditions", img:UIImage(named: "m1")), ProfileStruct(name: "Contact Us", img:UIImage(named: "cu")), ProfileStruct(name: "PrivacyPolicy", img:UIImage(named: "pps")), ProfileStruct(name: "FeedBack", img:UIImage(named: "feedb"))]
      
        
        dataArr1 = [ProfileStruct(name: "Home", img:UIImage(named: "h1 2")),ProfileStruct(name: "AboutUs", img:UIImage(named: "a5")), ProfileStruct(name: "Terms & conditions", img:UIImage(named: "m1")), ProfileStruct(name: "ContactUs", img:UIImage(named: "cu")), ProfileStruct(name: "PrivacyPolicy", img:UIImage(named: "pps")), ProfileStruct(name: "FeedBack", img:UIImage(named: "feedb")), ProfileStruct(name: "SignOut", img:UIImage(named: "signout"))]
        
        loginEmail = KeychainWrapper.standard.string(forKey: "user_email")
        emailVal()
        
        userTbl.tableFooterView = UIView(frame: .zero)
        userTbl.separatorStyle = .none
        //NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange(notification:)), name: NSNotification.Name(rawValue: "did_change_language"), object: nil)
       //  getUserDetailsData()
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
    /*func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        view.backgroundColor = UIColor.green
        let profilrImage = UIImageView(frame: CGRect(x: 20, y: 100, width: 70, height: 70))
        profilrImage.image = UIImage(named: "financier_icon")
        
        if userId != nil{
            
            let nameLabel = UILabel(frame: CGRect(x: 20, y: 180, width: 200, height: 30))
            nameLabel.text = "anyEmi"
            nameLabel.textColor = UIColor.black
            
            let emailLabel = UILabel(frame: CGRect(x: 20, y: 210, width: 200, height: 30))
            emailLabel.text = "gjhgjgjgj"//loginEmail//"anyemi@gmail.com"
            emailLabel.textColor = UIColor.black
            view.addSubview(nameLabel)
            view.addSubview(emailLabel)
        }
        view.addSubview(profilrImage)
        self.view.addSubview(view)
        return view
    }
    */
    
    func emailVal(){
        if userId != nil{
            emailLabel.text = loginEmail//"anyemi@gmail.com"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if userId != nil {
            if indexPath.row == 0 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 1 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "AboutUsController") as! AboutUsController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 2 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "TermsandConditionsViewController") as! TermsandConditionsViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 3 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 4 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 5 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "FeedBackViewController") as! FeedBackViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 6 {
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
                let vc = storyboard?.instantiateViewController(withIdentifier: "AboutUsController") as! AboutUsController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 3 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "TermsandConditionsViewController") as! TermsandConditionsViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 4 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 5 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 6 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "FeedBackViewController") as! FeedBackViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
