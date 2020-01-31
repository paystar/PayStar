//
//  PrepaidMobileServiceViewController.swift
//  PayStar
//
//  Created by Swapna Botta on 31/01/20.
//  Copyright © 2020 SwapnaBotta. All rights reserved.
//

import UIKit
import DropDown

class PrepaidMobileServiceViewController: UIViewController {
    let dropDown = DropDown()
    
    @IBOutlet weak var backgrounrImage: UIImageView!
    @IBOutlet weak var mobileNumTextField: UITextField!
    
    
    @IBOutlet weak var amountTextfield: UITextField!
    
    
    @IBOutlet weak var plansBtn: UIButton!
    
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var operatorButon: UIButton!
    @IBOutlet weak var stateButn: UIButton!
    @IBOutlet weak var rechrgTypLabel: UILabel!
    @IBOutlet weak var rechrgButn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let yourImage: UIImage = UIImage(named: "logoanyemiBackGround-1")!
               backgrounrImage.image = yourImage
               backgrounrImage.alpha = 0.5
        
        operatorButon.backgroundColor = UIColor.clear
        operatorButon.layer.cornerRadius = 5
        operatorButon.layer.borderWidth = 2
        operatorButon.layer.borderColor = UIColor(red: 74/255, green: 218/255, blue: 163/225, alpha: 1).cgColor
        
        stateButn.backgroundColor = UIColor.clear
        stateButn.layer.cornerRadius = 5
        stateButn.layer.borderWidth = 2
        stateButn.layer.borderColor = UIColor(red: 74/255, green: 218/255, blue: 163/225, alpha: 1).cgColor
        
        rechrgButn.backgroundColor = UIColor.clear
        rechrgButn.layer.cornerRadius = 5
        rechrgButn.layer.borderWidth = 2
        rechrgButn.layer.borderColor = UIColor(red: 74/255, green: 218/255, blue: 163/225, alpha: 1).cgColor
        
    }
    
    
    @IBAction func operatorButnAction(_ sender: Any) {
        dropDown.anchorView = operatorLabel
        dropDown.dataSource = ["Select Operator", "AIRTEL", "BSNL", "IDEA", "VODAFONE", "RELIANCE JIO", "TATA INDICOM", "TATA DOCOMO", "AIRCEL", "TELENOR", "VIRGIN GSM", "VIRGIN CDMA", "MTS", "Jio"]
        //dropDownLeft.width = 200
        dropDown.direction = .bottom
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            
            self.operatorLabel.text = " " + item
            //self.tryBtn.setTitle(item, for: .normal)
        }
        dropDown.show()
    }
    
    
    @IBAction func stateButtonAction(_ sender: Any) {
        dropDown.anchorView = stateLabel
        dropDown.dataSource = ["Select State","Andhra Pradesh","Tamil Nadu","Rajasthan","West Bengal","Madhya Pradesh","Delhi","Gujarath","Harayana","Jummu and Kashmir","Karnataka","Kerala","Bihar","Punjab","Orissa","Himachal Pradesh","Assam","Chennai",]
        //dropDownLeft.width = 200
        dropDown.direction = .bottom
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            
            self.stateLabel.text = " " + item
            //self.tryBtn.setTitle(item, for: .normal)
        }

        dropDown.show()
    }
    
    @IBAction func rechrgTypeAction(_ sender: Any) {
        dropDown.anchorView = rechrgTypLabel
        dropDown.dataSource = ["Select Recharge Type","Top UP","Special Recharge"]
        //dropDownLeft.width = 200
        dropDown.direction = .bottom
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            
            self.rechrgTypLabel.text = " " + item
    }
        dropDown.show()
    }
       
    
    @IBAction func plansBtnAction(_ sender: Any) {
        
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "PlansPrepaidViewController") as? PlansPrepaidViewController
        self.navigationController?.pushViewController(nextViewController!, animated: true)
    }
    
    @IBAction func rechargeFinalButton(_ sender: Any) {
    }
    
    
    
    
    
}
