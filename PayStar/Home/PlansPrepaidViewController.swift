//
//  PlansPrepaidViewController.swift
//  PayStar
//
//  Created by Swapna Botta on 31/01/20.
//  Copyright © 2020 SwapnaBotta. All rights reserved.
//

import UIKit

class PlansPrepaidViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

     // Do any additional setup after loading the view.
             let yourImage: UIImage = UIImage(named: "logoanyemiBackGround-1")!
                    backgroundImage.image = yourImage
                    backgroundImage.alpha = 0.5
    }
   
    
    @IBAction func backBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
