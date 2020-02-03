import UIKit
import SideMenu

class CollectionsViewController: UIViewController {

    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var watermarkBackgroundImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let yourImage: UIImage = UIImage(named: "logoanyemiBackGround-1")!
        watermarkBackgroundImg.image = yourImage
        watermarkBackgroundImg.alpha = 0.5
        //Do any additional setup after loading the view.
        
        searchBtn.backgroundColor = UIColor.clear
        searchBtn.layer.cornerRadius = 5
        searchBtn.layer.borderWidth = 0.7
        searchBtn.layer.borderColor = UIColor(red:0/255, green: 12/255, blue: 102/225, alpha: 1).cgColor//#000C66//rgb(0, 12, 102)
        
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
    }
    
    @IBAction func sideMenuButton(_ sender: Any) {
           print("in side menu")
           //toggleSideMenuView()
           //view?.backgroundColor = UIColor(white: 1, alpha: 0.9)
       }
    
}
extension CollectionsViewController : UISideMenuNavigationControllerDelegate {
    
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

