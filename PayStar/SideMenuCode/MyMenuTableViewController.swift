

import UIKit

class MyMenuTableViewController: UITableViewController {
    
    var selectedMenuItem : Int = 0
    
    var menuItems = ["Home", "LogIn", "Paybills", "AboutUs", "TermsandCondition", "PrivacyPolicy", "Contact Us", "FeedBack","SignOut"]
    //var menuIcons = ["settings", "settings", "settings", "qr code", "add business", "service", "employees", "settings", "employee time off", "billing", "raise", "my business"]
   var loginEmail: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.sectionHeaderHeight = 250
        
        //Customize apperance of table view
        tableView.contentInset = UIEdgeInsets(top: -64, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.blue
        tableView.scrollsToTop = false
 
        //Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRow(at: IndexPath(row: selectedMenuItem, section: 0), animated: false, scrollPosition: .middle)
        
        loginEmail = KeychainWrapper.standard.string(forKey: "user_email")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clear
            cell!.textLabel?.textColor = UIColor.white
          
        }
        
        cell!.textLabel?.text = menuItems[indexPath.row]//"ViewController #\(indexPath.row+1)"
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        view.backgroundColor = UIColor.green
       
        let profilrImage = UIImageView(frame: CGRect(x: 20, y: 100, width: 70, height: 70))
        profilrImage.image = UIImage(named: "hpcl")
        
        let nameLabel = UILabel(frame: CGRect(x: 20, y: 180, width: 200, height: 30))
        nameLabel.text = "anyEmi"
        nameLabel.textColor = UIColor.black
        
        let emailLabel = UILabel(frame: CGRect(x: 20, y: 210, width: 200, height: 30))
        emailLabel.text = loginEmail//"anyemi@gmail.com"
        emailLabel.textColor = UIColor.black
        
        view.addSubview(profilrImage)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        self.view.addSubview(view)
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    /*override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
            
        } else if indexPath.row == 1 {
            return 50
            
        } else if indexPath.row == 2 {
            return 50
            
        } else if indexPath.row == 3 {
            return 50
            
        } else if indexPath.row == 4 {
            return 50
            
        }else if indexPath.row == 5 {
            return 50
            
        }else if indexPath.row == 6 {
            return 50
        }
            
        else {
            return 50
        }
    }
    */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("did select row: \(indexPath.row)")
        
        if (indexPath.row == selectedMenuItem) {
            return
        }
        
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        switch (indexPath.row) {
       /* case 0:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
            break*/
        case 1:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
            break
        case 2:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "MakePaymentViewController")
            break
        case 3:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "AboutUsController")
            break
        case 4:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "TermsandConditionsViewController")
            break
        case 5:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "PrivacyPolicyViewController")
            break
            
        case 6:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "ContactUsViewController")
            break
            
        case 7:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "FeedBackViewController")
            break
        /*case 8:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
            break
    */
            
        default:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
            break
        }
        sideMenuController()?.setContentViewController(destViewController)
    }
}
