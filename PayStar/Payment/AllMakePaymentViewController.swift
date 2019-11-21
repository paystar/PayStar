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
    
//    var minLength: String?
//    var maxLength: String?
//    var billerId: String?
//
//
//    //
//    var electricityminLengthArray = [String]()
//
//
//
//    var electricityArray = [String]()
//    var waterArray = [String]()
//    var iteamsArray = [String]()
//    var dthArray = [String]()
//    var hpclArray = [String]()
//    var gasArray = [String]()
//    var mobpostpdArray = [String]()
//    var bdbndpostpdArray = [String]()
//    var landlineArray = [String]()
//
//    //billersearch arrays
//    var electrictyParamArray = [String]()
//    var gasParamArray = [String]()
//    var waterParamArray = [String]()
//    var mobPostpParamArray = [String]()
//    var brodbandParamArray = [String]()
//    var landParamArray = [String]()
//    var dthParamArray = [String]()
    
    
    
    var arrayOfBillerData = [JsonDataBiller]()
    
    var category: Category?
    var categoryName: String?
    var paramName: String?
    
    
    var billerVC: BillerSerarchViewController!
    //var category: Category?
    //var categoryName: String?
    //var paramName: String?
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
        
        
        categoryName = category?.asString()

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
                    
                    let bCat = billerdetail["bcategoryname"] as! String
                    
                    // only parse if it's the correct category
                    if bCat.uppercased() == self.categoryName {
                        
                        // create new array of cDetails objects
                        var aParams = [cDetails]()
                        
                        let customrParams = billerdetail["bcustomerparms"] as! String
                        let res = try JSONSerialization.jsonObject(with:Data(customrParams.utf8)) as! [[String: Any]]
                        
                        for item in res {
                            
                            if let pn = item["paramName"] as? String,
                                let minL = item["minLength"] as? String,
                                let maxL = item["maxLength"] as? String {
                                
                                // create new cDetails object
                                let cd = cDetails(paramName: pn, minLength: minL, maxLength: maxL)
                                
                                // append it to the aParams array
                                aParams.append(cd)
                            }
                        }
                        
                        let bName = billerdetail["bname"] as! String
                        
                        // create JsonDataBiller object
                        let jdBiller = JsonDataBiller(bname: bName,
                                                      bcategoryname: bCat,
                                                      bcustomerparms: aParams)
                        
                        // append it to array
                        self.arrayOfBillerData.append(jdBiller)
                        
                    }
                    
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            catch {
                print("catch error")
            }
            
            
        }).resume()
    }
}

extension AllMakePaymentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let category = category else {return 0}
//        switch category {
//        case .electricity: return electricityArray.count
//        case .water: return waterArray.count
//        case .cashpoint: return iteamsArray.count
//        case .dth: return dthArray.count
//        case .gas: return gasArray.count
//        case .mobilepostpd: return mobpostpdArray.count
//        case .brodbandpostpaid: return bdbndpostpdArray.count
//        case .landlinepostpd: return landlineArray.count
//
//        }
        
        return arrayOfBillerData.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PaymentTableViewCell
        
        cell.pamntTypeLabel.text = arrayOfBillerData[indexPath.row].bname
        
        // self.tableView.separatorStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewBillerSearchViewController") as? NewBillerSearchViewController {
            nextViewController.toplabeText = arrayOfBillerData[indexPath.row].bname
            nextViewController.selectedBiller = arrayOfBillerData[indexPath.row]
            self.navigationController?.pushViewController(nextViewController, animated: true)
        } else {
            print("Could not instantiate TextFiViewController")
        }
    }
    
    
    
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         let cell = tableView.cellForRow(at: indexPath) as? PaymentTableViewCell
//
//      if let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "BillerSerarchViewController") as? BillerSerarchViewController
//       {
//        switch category {
//        case .electricity?: nextViewController.textFieldtext = electrictyParamArray[indexPath.row]
//        KeychainWrapper.standard.set(self.electrictyParamArray[indexPath.row], forKey: "paramName")
//        nextViewController.elMinL = electricityminLengthArray[indexPath.row]
//
//       // KeychainWrapper.standard.set(self.paramName ?? "", forKey: "paramName")
//        nextViewController.labelText = cell?.pamntTypeLabel.text
//
//        case .water?: nextViewController.textFieldtext = waterParamArray[indexPath.row]
//        print("water paramname \(self.waterParamArray)")
//        print("water paramname count\(self.waterParamArray.count)")
//        nextViewController.labelText = cell?.pamntTypeLabel.text
//
//
//        case .cashpoint?: nextViewController.textFieldtext = paramName
//        nextViewController.labelText = cell?.pamntTypeLabel.text
//
//        case .dth?: nextViewController.textFieldtext = dthParamArray[indexPath.row]
//        nextViewController.labelText = cell?.pamntTypeLabel.text
//
//        case .gas?: nextViewController.textFieldtext = gasParamArray[indexPath.row]
//        nextViewController.labelText = cell?.pamntTypeLabel.text
//
//        case .mobilepostpd?: nextViewController.textFieldtext = mobPostpParamArray[indexPath.row]
//        nextViewController.labelText = cell?.pamntTypeLabel.text
//
//        case .brodbandpostpaid?: nextViewController.textFieldtext = brodbandParamArray[indexPath.row]
//        nextViewController.labelText = cell?.pamntTypeLabel.text
//
//        case .landlinepostpd?: nextViewController.textFieldtext = landParamArray[indexPath.row]
//        nextViewController.labelText = cell?.pamntTypeLabel.text
//
//        case .none:
//            print("in didselect switch")
//        }
//        self.navigationController?.pushViewController(nextViewController, animated: true)
//      }
//        else{
//        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "BillerSerarchViewController") as? BillerSerarchViewController
//        self.navigationController?.pushViewController(nextViewController!, animated: true)
//        }
//    }
}
