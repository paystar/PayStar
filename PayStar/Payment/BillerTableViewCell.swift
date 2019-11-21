//
//  BillerTableViewCell.swift
//  PayStar
//
//  Created by Swapna Botta on 21/11/19.
//  Copyright © 2019 SwapnaBotta. All rights reserved.
//

import UIKit

class BillerTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //textField.delegate = self as UITextFieldDelegate
    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.text = ""
//    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
    }
}
