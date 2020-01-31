//
//  FetchBillerViewController.swift
//  PayStar
//
//  Created by Swapna Botta on 19/11/19.
//  Copyright © 2019 SwapnaBotta. All rights reserved.
//

import UIKit

class FetchBillerViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var billerNameLabel: UILabel!
    @IBOutlet weak var servcNumLabel: UILabel!
    @IBOutlet weak var consumrNameLabel: UILabel!
    @IBOutlet weak var billDateLabel: UILabel!
    @IBOutlet weak var billPeriodLabel: UILabel!
    @IBOutlet weak var billrnumrLabel: UILabel!
    @IBOutlet weak var billDueDtaLabel: UILabel!
    @IBOutlet weak var servcChargLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var totalAmntLabel: UILabel!
    
    var nameText: String?
    var servcNum: String?
    var consumrName: String?
    var billerDate: String?
    var bPeropd: String?
    var bNumber: String?
    var dueDate: String?
    var servcCharge: String?
    var amount: Double?
    var totalAmoun: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        //activityIndicator.startAnimating()
        print("amount aaaaaaaa\(String(describing: amount))")
        billerNameLabel.text = nameText
        servcNumLabel.text = servcNum
        consumrNameLabel.text = consumrName
        billDateLabel.text = billerDate
        billPeriodLabel.text = bPeropd
        billrnumrLabel.text = bNumber
        billDueDtaLabel.text = dueDate
        servcChargLabel.text = servcCharge
        //var strAmount: String = amount as? String ?? ""
        //let dueAmnt = dueAmount
        let rsSymbol = "\u{20B9}";
        
        //self.dueamountLabel.text = (rsSymbol)  +  " "  + (dueAmnt!)

        if let bllrAmount = amount {
            amountLabel.text = (rsSymbol)  +  " "  + String(bllrAmount )
        }
        //totalAmoun = amount
        if let totalAmount = amount {
            totalAmntLabel.text = (rsSymbol)  +  " "  + String(totalAmount)
        }
        
        //activityIndicator.stopAnimating()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func payButton(_ sender: Any) {
        
        let makepayVC = self.storyboard?.instantiateViewController(withIdentifier: "MakePaymenyOptionsViewController") as! MakePaymenyOptionsViewController
        makepayVC.amounText = totalAmntLabel.text
        self.navigationController?.pushViewController(makepayVC, animated: true)
        //self.present(makepayVC, animated: true)
        
    }
}
