

import UIKit

class MakePaymentViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var serviceNumTextField: UITextField!
    @IBOutlet weak var nameIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var callIcon: UIImageView!
    @IBOutlet weak var callLabel: UILabel!
    @IBOutlet weak var serviceNumIcon: UIImageView!
    @IBOutlet weak var serviceNumLabel: UILabel!
    @IBOutlet weak var fatherNameIcon: UIImageView!
    @IBOutlet weak var fatherNameLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueamountLabel: UILabel!
    @IBOutlet weak var servicechargeLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Do any additional setup after loading the view.
        searchButton.backgroundColor = UIColor.clear
        searchButton.layer.cornerRadius = 5
        searchButton.layer.borderWidth = 2
        searchButton.layer.borderColor = UIColor(red: 74/255, green: 218/255, blue: 163/225, alpha: 1).cgColor
    
    }
    
    @IBAction func sidemMenuButn(_ sender: Any) {
        toggleSideMenuView()
    }
    
    @IBAction func makePaymentButton(_ sender: Any) {
        
    }
    func makePaymentService(){
        
        let parameters = ["assessmentNo":  Int(serviceNumTextField.text ?? ""),
                          "taxtype":"tax_type",
                          "finance":"4",
                          "user_id":""] as? [String : Any]
        
        let url = URL(string: "https://dev.anyemi.com/webservices/anyemi/getassment_details")
        var req =  URLRequest(url: url!)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Contet-Type")
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else {return}
        req.httpBody = httpBody
        
        let session = URLSession.shared
        
        session.dataTask(with: req, completionHandler: {(data, response, error) in
            if let response = response {
                // print(response)
            }
            if let data = data {
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                    print("the json for make payment \(json)")
                    
                    let emiArray = json["emi"] as! [[String : Any]]
                    let loanDetails = json["loan_details"] as! [String : Any]
                    let userPhNum = loanDetails["phone"] as? String
                    let adderss = loanDetails["address"] as? String

                    for detail in emiArray{
                        let userName = detail["customer"] as? String
                        print("make user name \(userName)")
                        let serviceNum = detail["loan_number"] as? String
                        let dueDate = detail["due_date"] as? String
                        let dueAmount = detail["emi_amount"] as? String
                        
                        DispatchQueue.main.async {
                            
                            self.nameLabel.text = userName
                            self.callLabel.text = userPhNum
                            self.serviceNumLabel.text = serviceNum
                            self.dueDateLabel.text = dueDate
                            self.dueamountLabel.text = dueAmount
                            self.fatherNameLabel.text = adderss
                            
                        }
                        
                    }
                    
                    /*
                    let details = json["loan_details"] as! [String : Any]
                    
                        let userName = details["customer_name"] as? String
                        print("make user name \(userName)")
                         let userPhNum = details["phone"] as? String
                         let serviceNum = details["loan_number"] as? String
                        
                        DispatchQueue.main.async {
                            
                            self.nameLabel.text = userName
                            self.callLabel.text = userPhNum
                            self.serviceNumLabel.text = serviceNum
                            
                        }
                    */
                    
                }catch{
                    print("error")
                }
            }
        }).resume()
        
        //et nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        //self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        makePaymentService()
    }
   
}
