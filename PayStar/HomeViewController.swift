

import UIKit

struct JsonData {
    
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

struct paymentMode {
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



class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
   // var homeItems = ["LS Pub", "HPCL", "GVMC", "CDMA AP", "APEDCL", "CASH", "FINANSIAL", "VARUN"]
   // var homeLogs = ["GVMC_icon", "CDMA_icon", "cashpoint_icon", "APEPDCL_icon", "varun finance5_icon", "financier_icon", "cashpoint_icon", "GVMC_icon"]
    
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var itemsArray = [JsonData]()
    var idArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        self.view.addSubview(activityIndicator)
        
        homeServiceCall()
        
        //Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
        layout.itemSize = CGSize(width: 95, height: 95)
        collectionView?.collectionViewLayout  = layout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func sideMenuButton(_ sender: Any) {
        print("in side menu")
        toggleSideMenuView()
    }
    
    func showActivityIndicatory() {
        var activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        
        let aData = itemsArray[indexPath.row]
        cell.paymentLabel.text = aData.typeName
        
        if let url = NSURL(string: aData.iconHome ?? "") {
            if let data = NSData(contentsOf: url as URL) {
                cell.paymentImage.image = UIImage(data: data as Data)
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "MakePaymentViewController") as! MakePaymentViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        let indexPathHome = indexPath.row
        print("home collectionItem indexpath \(indexPathHome)")
        
    }
    
    //MARK:- Service-call
    
    func homeServiceCall(){
        
        let urlStr = "https://dev.anyemi.com/webservices/anyemi/getfinancer"
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
                DispatchQueue.main.async {
                    self.activityIndicator.startAnimating()
                }
                let jsonObj = try JSONSerialization.jsonObject(with: respData, options: .allowFragments) as! [String: Any]
                print("the home json is \(jsonObj)")
                let financerArray = jsonObj["financer"] as! [[String: Any]]
                print("homw financerData \(financerArray)")
                
                for financer in financerArray {
                    
                    let id = financer["id"] as! String
                    let pic = financer["icon"] as? String
                    let typeName = financer["tpe"] as! String
                    print("home financer id \(id)")
                    self.idArray.append(id)
                    print("the home financer idsArray \(self.idArray.append(id))")
                    print(typeName)
                    print("the icons \(String(describing: pic))")
                    self.itemsArray.append(JsonData(icon: pic ?? "", tpe: typeName))
                    print("online images bug \(self.itemsArray.count)")
                    
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
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
    
    @IBAction func signOutButton(_ sender: Any) {
        print("signout tapped")
        KeychainWrapper.standard.remove(key: "Uid")
        /*let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = loginVC*/
    }
}
