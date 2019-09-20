

import UIKit

class PaymentOptionsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var walletView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var paymentmodeImageArray = ["billdesk", "c-card", "hdfc", "instamojo", "Paytm", "Scan&Pay", "UPI-img", "wallethdpi"]
    
    var paymenLabelArray = ["BillDesk", "Card", "Hdfe", "Instamojo", "Paytem", "ScanAndPay", "Upi", "Wallet"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        walletView.layer.cornerRadius = 10
        walletView.layer.borderWidth = 1
        walletView.layer.borderColor = UIColor(red: 74/255, green: 218/255, blue: 163/225, alpha: 1).cgColor
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PaymentOptionsTableViewCell
        cell.paymentmodeImage.image = UIImage(named: paymentmodeImageArray[indexPath.row])
        cell.paymentLabel.text = paymenLabelArray[indexPath.row]
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.00
    }
    

}
