//
//  HomeSer.swift
//  PayStar
//
//  Created by Swapna Botta on 19/09/19.
//  Copyright © 2019 SwapnaBotta. All rights reserved.
//

import Foundation
import UIKit


struct JsonDataHome {
    
    var id: String?
    var iconHome: String?
    var typeName: String?
    var paymentMode: [String : Any]?
    init(icon: String, tpe: String, id: String, payment_mode: [String : Any]) {
        
        self.iconHome = icon
        self.typeName = tpe
        self.id = id
        self.paymentMode = payment_mode
    }
}

struct paymentModeHome {
    var id: String?
    var financierid: String?
    var Paymentmode: String?
    var paymentmodeicon: String?
    var paymentmodecode: String?
    
    init(id: String, financier_id: String, Payment_mode: String, paymentmode_icon: String, paymentmode_code: String) {
        
        self.id = id
        self.financierid = financier_id
        self.Paymentmode = Payment_mode
        self.paymentmodeicon = paymentmode_icon
        self.paymentmodecode = paymentmode_code
        
    }
    
}
