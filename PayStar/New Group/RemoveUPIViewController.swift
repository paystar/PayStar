//
//  RemoveUPIViewController.swift
//  PayStar
//
//  Created by Swapna Botta on 13/11/19.
//  Copyright © 2019 SwapnaBotta. All rights reserved.
//

import UIKit

class RemoveUPIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
  self.navigationController?.popViewController(animated: true)

    }
    @IBAction func sideMenuButton(_ sender: Any) {
           print("in side menu")
           //toggleSideMenuView()
           view?.backgroundColor = UIColor(white: 1, alpha: 0.9)
       }

}
