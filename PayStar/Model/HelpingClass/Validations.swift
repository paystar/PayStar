//
//  Validations.swift
//  PayStar
//
//  Created by Swapna Botta on 11/09/19.
//  Copyright © 2019 SwapnaBotta. All rights reserved.
//

import Foundation
import UIKit
extension String {
    
    var isPhoneNumberValid: Bool {
        let PHONE_REGEX = "^[6-9][0-9]{9}$";
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
    var isPasswordValid: Bool{
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{6,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        return passwordValidation.evaluate(with: self)
    }
}
