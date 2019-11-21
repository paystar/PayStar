//
//  Refund and CancellationViewController.swift
//  PayStar
//
//  Created by Swapna Botta on 14/11/19.
//  Copyright © 2019 SwapnaBotta. All rights reserved.
//

import UIKit

class RefundandCancellationViewController: UIViewController {
   
    @IBOutlet weak var refundTextview: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let heading = "Bills or Taxes once paid through the payment gateway shall not be refunded other then in the following circumstances:"
        
        let content = "\n \n 1. Multiple times debiting of Consumer Card/Bank Account due to tichnical error excluding Payment Gateway charges would be refunded to the consumer with in 1 week after submitting complaint form. \n \n 2. Consumers account being debited with excess amount in single transaction due to technical error will be deducted in next month transaction. \n \n 3. Due to technical error, payment being charged on the consumer's Card/Bank Account but the Bill is unsuccessful. However, if in such cases, consumer wishes to seek refund of the amount, he/she would be refunded net the amount, after deduction of Payment Gateway charges or any other charges within 1 week after submitting complaint form \n \n In case of any queries, please call anyEMI Online Services Pvt Ltd Helpdesk on +918008612200/5500 or write to helpdesk@anyemi.com"
        
        refundTextview.isEditable = false
        refundTextview.textColor = UIColor.gray
        refundTextview.isScrollEnabled = false

        let attributedText = NSMutableAttributedString(string: heading, attributes: [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20) as Any,NSAttributedString.Key.foregroundColor: UIColor.gray])
        
       // UIFont(name: "HelveticaNeue-Bold", size: 20)!, NSAttributedStringKey.foregroundColor: UIColor.green]
        
        attributedText.append(NSAttributedString(string: content, attributes: [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 20) as Any, NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        refundTextview.attributedText = attributedText
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refundTextview.isScrollEnabled = true

    }
}
/*
 
 How to add two different font size to textview text in swift.
 
 
 import UIKit
 
 class RefundandCancellationViewController: UIViewController {
 
 @IBOutlet weak var refundTextview: UITextView!
 override func viewDidLoad() {
 super.viewDidLoad()
 
 var heading = "Bills or Taxes once paid through the payment gateway shall not be refunded other then in the following circumstances:"
 var content = "\n \n 1. Multiple times debiting of Consumer Card/Bank Account due to ticnical error excluding Payment Gateway charges would be refunded to the consumer with in 1 week after submitting complaint form. \n \n 2. Consumers account being debited with excess amount in single transaction due to tecnical error will be deducted in next month transaction. \n \n 3. Due to technical error, payment being charged on the consumers Card/Bank Account but the Bill is unsuccessful. However, if in such cases, consumer wishes to seek refund of the amount, after deductionof Payment Gateway charges or any other charges within 1 week after submitting complaint form \n \n In case of any queries, please call anyEMI Online Services Pvt Ltd Helpdesk on +918008612200/5500 or write to helpdesk@anyemi.com"
 
 
 refundTextview.textColor = UIColor.gray
 refundTextview.text = heading + content
 
 }
 }
 
 */
