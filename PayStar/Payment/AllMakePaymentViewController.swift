//
//  AllMakePaymentViewController.swift
//  PayStar
//
//  Created by Swapna Botta on 14/10/19.
//  Copyright © 2019 SwapnaBotta. All rights reserved.
//

import UIKit

class PaymentTableViewCell: UITableViewCell{
    
    @IBOutlet weak var pamntTypeLabel: UILabel!
}
class AllMakePaymentViewController: UIViewController {
  
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var electricityArray = [String]()
    var waterArray = [String]()
    var iteamsArray = [String]()
    var dthArray = [String]()
    var hpclArray = [String]()
    var gasArray = [String]()
    var mobpostpdArray = [String]()
    var bdbndpostpdArray = [String]()
    var landlineArray = [String]()
    
    //billersearch arrays
    var electrictyParamArray = [String]()
    var gasParamArray = [String]()
    var waterParamArray = [String]()
    var mobPostpParamArray = [String]()
    var brodbandParamArray = [String]()
    var landParamArray = [String]()
    var dthParamArray = [String]()
    
    var billerVC: BillerSerarchViewController!
    var category: Category?
    var categoryName: String?
    var paramName: String?
    @IBOutlet weak var categoryTopLabel: UILabel!
    var labelText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.delegate = self
        //tableView.dataSource = self
        
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        self.activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)

        activityIndicator.style = UIActivityIndicatorView.Style.gray
        self.view.addSubview(activityIndicator)
        
        
        categoryTopLabel.text = labelText
        allPaymentService()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.separatorStyle = .none

    }
    @IBAction func backButn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func allPaymentService(){
        
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }

    let urlStr = "https://dev.anyemi.com/webservices/anyemi/api.php?rquest=billermdm"
    let url = URL(string: urlStr)
    URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
    guard let respData = data else {
    return
    }
    guard error == nil else {
    print("error")
    return
    }
    do{
    let jsonObj = try JSONSerialization.jsonObject(with: respData, options: .allowFragments) as! [String: Any]
    //print("the all make payment json is \(jsonObj)")
    let billerdetailsArray = jsonObj["billerdetails"] as! [[String: Any]]
        
    for billerdetail in billerdetailsArray {
        
    self.categoryName = billerdetail["bcategoryname"] as? String
        
        let customrParams = billerdetail["bcustomerparms"] as! String
        let res = try JSONSerialization.jsonObject(with:Data(customrParams.utf8)) as! [[String: Any]]
        
        for item in res {
         self.paramName = item["paramName"] as? String
           // print("the paramNameeeee \(self.paramName)")
        if self.categoryName == "Water"{
            let bName = billerdetail["bname"] as? String
            self.waterArray.append(bName ?? "")
            self.waterParamArray.append(self.paramName ?? "")
        }
        
         if self.categoryName == "DTH"{
            let bName = billerdetail["bname"] as? String
            self.dthArray.append(bName ?? "")
            self.dthParamArray.append(self.paramName ?? "")
        }
         if self.categoryName == "Electricity"{
            let bName = billerdetail["bname"] as? String
            self.electricityArray.append(bName ?? "")
            self.electrictyParamArray.append(self.paramName ?? "")
        }
        if self.categoryName == "Gas"{
            let bName = billerdetail["bname"] as? String
            self.gasArray.append(bName ?? "")
            self.gasParamArray.append(self.paramName ?? "")
        }
        if self.categoryName == "Mobile Postpaid"{
            let bName = billerdetail["bname"] as? String
            self.mobpostpdArray.append(bName ?? "")
            self.mobPostpParamArray.append(self.paramName ?? "")
           // print("Electricity arry \(self.mobpostpdArray)")
            //print("Electricity arry count \(self.mobpostpdArray.count)")
        }
        if self.categoryName == "Broadband Postpaid"{
            let bName = billerdetail["bname"] as? String
            self.bdbndpostpdArray.append(bName ?? "")
            self.brodbandParamArray.append(self.paramName ?? "")
           // print("Electricity arry \(self.bdbndpostpdArray)")
            //print("Electricity arry count \(self.bdbndpostpdArray.count)")
        }
        if self.categoryName == "Landline Postpaid"{
            let bName = billerdetail["bname"] as? String
            self.landlineArray.append(bName ?? "")
            self.landParamArray.append(self.paramName ?? "")

           // print("Electricity arry \(self.landlineArray)")
            //print("Electricity arry count \(self.landlineArray.count)")
        }
        
        }
    }
    DispatchQueue.main.async {
    self.tableView.reloadData()
    }
    }
    catch {
    print("catch error")
    }
    DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }

    }).resume()
    }
}

extension AllMakePaymentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let category = category else {return 0}
        switch category {
        case .electricity: return electricityArray.count
        case .water: return waterArray.count
        case .cashpoint: return iteamsArray.count
        case .dth: return dthArray.count
        case .gas: return gasArray.count
        case .mobilepostpd: return mobpostpdArray.count
        case .brodbandpostpaid: return bdbndpostpdArray.count
        case .landlinepostpd: return landlineArray.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PaymentTableViewCell
        
        guard let category = category else {return cell}
        switch category {
        case .electricity: cell.pamntTypeLabel.text = electricityArray[indexPath.row]
        case .water: cell.pamntTypeLabel.text = waterArray[indexPath.row]
        case .cashpoint: cell.pamntTypeLabel.text = iteamsArray[indexPath.row]
        case .dth: cell.pamntTypeLabel.text = dthArray[indexPath.row]
        case .gas: cell.pamntTypeLabel.text = gasArray[indexPath.row]
        case .mobilepostpd: cell.pamntTypeLabel.text = mobpostpdArray[indexPath.row]
        case .brodbandpostpaid: cell.pamntTypeLabel.text = bdbndpostpdArray[indexPath.row]
        case .landlinepostpd: cell.pamntTypeLabel.text = landlineArray[indexPath.row]

        }
       // self.tableView.separatorStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cell = tableView.cellForRow(at: indexPath) as? PaymentTableViewCell

      if let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "BillerSerarchViewController") as? BillerSerarchViewController
       {
        switch category {
        case .electricity?: nextViewController.textFieldtext = electrictyParamArray[indexPath.row]
        nextViewController.labelText = cell?.pamntTypeLabel.text

            
        case .water?: nextViewController.textFieldtext = waterParamArray[indexPath.row]
        nextViewController.labelText = cell?.pamntTypeLabel.text
        case .cashpoint?: nextViewController.textFieldtext = paramName
        nextViewController.labelText = cell?.pamntTypeLabel.text

        case .dth?: nextViewController.textFieldtext = dthParamArray[indexPath.row]
        nextViewController.labelText = cell?.pamntTypeLabel.text

        case .gas?: nextViewController.textFieldtext = gasParamArray[indexPath.row]
        nextViewController.labelText = cell?.pamntTypeLabel.text

        case .mobilepostpd?: nextViewController.textFieldtext = mobPostpParamArray[indexPath.row]
        nextViewController.labelText = cell?.pamntTypeLabel.text

        case .brodbandpostpaid?: nextViewController.textFieldtext = brodbandParamArray[indexPath.row]
        nextViewController.labelText = cell?.pamntTypeLabel.text

        case .landlinepostpd?: nextViewController.textFieldtext = landParamArray[indexPath.row]
        nextViewController.labelText = cell?.pamntTypeLabel.text

        case .none:
            print("in didselect switch")
        }
        self.navigationController?.pushViewController(nextViewController, animated: true)
      }
        
        else{
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "BillerSerarchViewController") as? BillerSerarchViewController
        self.navigationController?.pushViewController(nextViewController!, animated: true)

        }
    }
}
