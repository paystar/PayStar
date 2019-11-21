//
//  FetchBillerViewController.swift
//  PayStar
//
//  Created by Swapna Botta on 19/11/19.
//  Copyright © 2019 SwapnaBotta. All rights reserved.
//

import UIKit

class FetchBillerViewController: UIViewController {
    
    
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
        
        print("amount aaaaaaaa\(amount)")
        
        billerNameLabel.text = nameText
        servcNumLabel.text = servcNum
        consumrNameLabel.text = consumrName
        billDateLabel.text = billerDate
        billPeriodLabel.text = bPeropd
        billrnumrLabel.text = bNumber
        billDueDtaLabel.text = dueDate
        servcChargLabel.text = servcCharge
        //var strAmount: String = amount as? String ?? ""
        
        if let priceOfProduct = amount {
            amountLabel.text = String(priceOfProduct )
        }
        //totalAmoun = amount
        if let priceOfProduct = amount {
            totalAmntLabel.text = String(priceOfProduct )
        }
        
        
        
        //amountLabel.text = String(amount)
        //totalAmntLabel.text = totalAmoun
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
