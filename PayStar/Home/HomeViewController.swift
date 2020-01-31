

import UIKit
import SDWebImage
import SideMenu
import SwiftKeychainWrapper


struct JsonData {
    
    var iconHome: String?
    var typeName: String?
    var id: String?
    init(icon: String, tpe: String, id: String) {
        self.iconHome = icon
        self.typeName = tpe
        self.id = id
    }
}

enum Category: String, CaseIterable {
    case water = "WATER"
    //case hpcl = "HPCL"
    case electricity = "ELECTRICITY"
    case gas = "GAS"
    case brodbandpostpaid = "BROADBAND POSTPAID"
    case landlinepostpd = "LANDLINE POSTPAID"
    case mobilepostpd = "MOBILE POSTPAID"
    //case cashpoint = "CASHPOINT"
    case dth = "DTH"
    
    static var asArray: [Category] {return self.allCases}
    
    func asInt() -> Int {
        return Category.asArray.firstIndex(of: self)!
    }
    func asString() -> String {
        return self.rawValue
    }
}

struct JsonDataBiller{
    var billerId: String?
    var bname: String = ""
    var bcategoryname: String = ""
    var bcustomerparms: [cDetails] = [cDetails]()
    
    init(billerId: String, bname: String, bcategoryname: String, bcustomerparms: [cDetails]){
        self.billerId = billerId
        self.bname = bname
        self.bcategoryname = bcategoryname
        self.bcustomerparms = bcustomerparms
    }
}

struct cDetails{
    var paramName: String = ""
    var minLength: String = ""
    var maxLength: String = ""
    init(paramName: String, minLength: String, maxLength: String) {
        self.paramName = paramName
        self.minLength = minLength
        self.maxLength = maxLength
    }
}

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var itemsArray = [JsonData]()
    var allCatName: String!
    var typeName: String?
    var savedTypenameKey: String?
    @IBOutlet weak var backgrounrImage: UIImageView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //logoanyemiBackGround-1
        let yourImage: UIImage = UIImage(named: "logoanyemiBackGround-1")!
        backgrounrImage.image = yourImage
        backgrounrImage.alpha = 0.5
        
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        self.view.addSubview(activityIndicator)
        sideMenuConfig()
        homeServiceCall()
        
        //Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
        layout.itemSize = CGSize(width: 80, height: 95)
        
        collectionView?.collectionViewLayout  = layout
    }
    
    func sideMenuConfig(){
        // Define the menus
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "UISideMenuNavigationController") as? UISideMenuNavigationController
        
//        let menu = storyboard!.instantiateViewController(withIdentifier: "UISideMenuNavigationController") as! UISideMenuNavigationController
//        var set = SideMenuSettings()
//        set.presentationStyle.menuStartAlpha = 0
        //let presentationStyle = selectedPresentationStyle()
//        var settings = SideMenuSettings()
//        settings.presentationStyle.presentingEndAlpha = 0
//        presentationStyle.presentingEndAlpha = 0
//        settings.presentationStyle = presentationStyle

        
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuFadeStatusBar  = false
        //SideMenuManager.default.
        //SideMenuSettings().presentationStyle.presentingEndAlpha = 1
       
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func sideMenuButton(_ sender: Any) {
        print("in side menu")
 
        //view?.backgroundColor = UIColor(white: 1, alpha: 0.7)
    }
    
    func showActivityIndicatory() {
        let activityView = UIActivityIndicatorView(style: .whiteLarge)
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
        cell.paymentImage.sd_setImage(with: URL(string:aData.iconHome ?? ""), placeholderImage: UIImage(named: "varun finance5_icon"))
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        print("tableview collection images \(String(describing: aData.iconHome))")
        //print("tableview collection images count\(aData.iconHome?.count))")
        /*if let url = NSURL(string: aData.iconHome ?? "") {
            if let data = NSData(contentsOf: url as URL) {
                cell.paymentImage.image = UIImage(data: data as Data)
            }
        }*/
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if itemsArray[indexPath.item].typeName == "APEPDCL"{
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "MakePaymentViewController") as? MakePaymentViewController
            self.navigationController?.pushViewController(nextViewController!, animated: true)
            
        }
        if itemsArray[indexPath.item].typeName == "MOBILE PREPAID"{
            print("inprpaid!!!!!")
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "PrepaidMobileServiceViewController") as? PrepaidMobileServiceViewController
            self.navigationController?.pushViewController(nextViewController!, animated: true)
            }
        if itemsArray[indexPath.item].typeName == "CASH POINT" {
               AlertFun.ShowAlert(title: "", message: "Will update soon..", in: self)

            }
        else{
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "AllMakePaymentViewController") as? AllMakePaymentViewController

            switch Category(rawValue: itemsArray[indexPath.item].typeName!) {

            case .water?: nextViewController?.category = .water
            nextViewController?.labelText = (nextViewController?.category).map { $0.rawValue }
            case .electricity?: nextViewController?.category = .electricity
            nextViewController?.labelText = (nextViewController?.category).map { $0.rawValue }

            //case .cashpoint?: nextViewController?.category = .cashpoint
            //nextViewController?.labelText = (nextViewController?.category).map { $0.rawValue }

            case .gas?: nextViewController?.category = .gas
            nextViewController?.labelText = (nextViewController?.category).map { $0.rawValue }

            //case .hpcl?: nextViewController?.category = .hpcl
            case .mobilepostpd?: nextViewController?.category = .mobilepostpd
            nextViewController?.labelText = (nextViewController?.category).map { $0.rawValue }

            case .landlinepostpd?: nextViewController?.category = .landlinepostpd
            nextViewController?.labelText = (nextViewController?.category).map { $0.rawValue }

            case .brodbandpostpaid?: nextViewController?.category = .brodbandpostpaid
            nextViewController?.labelText = (nextViewController?.category).map { $0.rawValue }

            case .dth?: nextViewController?.category = .dth
            nextViewController?.labelText = (nextViewController?.category).map { $0.rawValue }

            default: print("in default")//AlertFun.ShowAlert(title: "", message: "will update soon..", in: self)
            }
            self.navigationController?.pushViewController(nextViewController!, animated: true)
        }
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
                //print("the home json is \(jsonObj)")
                let financerArray = jsonObj["financer"] as! [[String: Any]]
                //print("home financerData \(financerArray)")
                
                for financer in financerArray {
                    let id = financer["id"] as? String
                    let pic = financer["icon"] as? String
                    self.typeName = financer["tpe"] as? String
                    KeychainWrapper.standard.set(self.typeName!, forKey: "typeName")
                    self.savedTypenameKey = KeychainWrapper.standard.string(forKey: "typeName")
                    //print("saved keychain typename \(self.savedTypenameKey)")
                    //print("the type is \(self.typeName)")
                    self.itemsArray.append(JsonData(icon: pic ?? "", tpe: self.typeName ?? "", id: id ?? ""))
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension HomeViewController : UISideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
        view.alpha = 0.5
    }
     func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
    //*do the color thing*
        print("sidemenu disappear")
        view.alpha = 1
        
}
}
