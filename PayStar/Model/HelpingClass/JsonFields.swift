//
//  JsonFields.swift
//  PayStar
//
//  Created by Swapna Botta on 28/09/19.
//  Copyright © 2019 SwapnaBotta. All rights reserved.
//

import UIKit

class JsonFields: NSObject {
    
    /*var uID: String?
    var phNum: String?
    var uEmail: String?
    var uPassword: String?
    var uName: String?
    var otpField: String?*/
    var finId: String?
    
    init(financer: String) {
        self.finId = financer
    }
}
