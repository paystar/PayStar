

import UIKit
import SideMenu
class MakePaymenyOptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var amounText: String?
    var paymentmodeImageArray = ["billdesk", "c-card", "hdfc", "instamojo", "Paytm", "Scan&Pay", "UPI-img"]
    
    var paymenLabelArray = ["BillDesk", "Card", "Hdfe", "Instamojo", "Paytem", "ScanAndPay", "Upi"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let rsSymbol = "\u{20B9}";
        
        self.amountLabel.text = (rsSymbol)  +  " "  + (amounText ?? "")
        self.tableView.separatorStyle = .none

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MakePayCellTableViewCell
        cell.paymentmodeImage.image = UIImage(named: paymentmodeImageArray[indexPath.row])
        cell.paymentLabel.text = paymenLabelArray[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.00
    }
    
    
    @IBAction func sideMenuButton(_ sender: Any) {
        print("in side menu")
        //toggleSideMenuView()
        //view?.backgroundColor = UIColor(white: 1, alpha: 0.9)
    }
    
}
extension MakePaymenyOptionsViewController : UISideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
        view.alpha = 0.5
    }
     func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
    //*do the color thing*
        print("sidemenu disappear")
        view.alpha = 1
        
}
}
