//
//  MakePaymenyOptionsViewController.swift
//  PayStar
//
//  Created by Swapna Botta on 14/11/19.
//  Copyright © 2019 SwapnaBotta. All rights reserved.
//

import UIKit

class MakePaymenyOptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var amounText: String?
    var paymentmodeImageArray = ["billdesk", "c-card", "hdfc", "instamojo", "Paytm", "Scan&Pay", "UPI-img"]
    
    var paymenLabelArray = ["BillDesk", "Card", "Hdfe", "Instamojo", "Paytem", "ScanAndPay", "Upi"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.amountLabel.text = amounText
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
}
