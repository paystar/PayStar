

import UIKit
import WebKit
import SideMenu
class AboutUsController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var aboutusWeb: WKWebView!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://www.anyemi.com/about.php") else { return }
        let request = URLRequest(url: url)
        
        aboutusWeb.load(request)
        // add activity
        self.activity.transform = CGAffineTransform(scaleX: 2, y: 2)

        self.aboutusWeb.addSubview(self.activity)
        self.activity.startAnimating()
        self.aboutusWeb.navigationDelegate = self
        self.activity.hidesWhenStopped = true
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//        DispatchQueue.main.async {
//
//            self.aboutusWeb.isOpaque = false
//            self.aboutusWeb.backgroundColor = UIColor.clear
//            self.aboutusWeb.scrollView.backgroundColor = UIColor.clear
//        }
//    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activity.stopAnimating()
    }
    @IBAction func sideMenubtn(_ sender: Any) {
        print("in aboutus")
       // aboutusWeb.alpha = 0.7//UIColor(white: 1, alpha: 0.7)
    //aboutusWeb?.backgroundColor = UIColor(white: 1, alpha: 0.9)
//        aboutusWeb.isOpaque = false
//        aboutusWeb.backgroundColor = UIColor.clear
      //self.sideMenuConfig()//toggleSideMenuView()
    }
    func sideMenuConfig(){
        // Define the menus
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuVC") as? UISideMenuNavigationController
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuFadeStatusBar  = false
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
}
//extension AboutUsController: UISideMenuNavigationControllerDelegate {
//
//    internal func sideMenuWillAppear(menu: UISideMenuNavigationController, animated: Bool) {
//        print("SideMenu Appearing! (animated: \(animated))")
//        view?.backgroundColor = UIColor(white: 1, alpha: 0.9)
//
//    }
//
//    internal func sideMenuDidAppear(menu: UISideMenuNavigationController, animated: Bool) {
//        print("SideMenu Appeared! (animated: \(animated))")
//        view?.backgroundColor = UIColor(white: 1, alpha: 0.9)
//
//    }
//
//    internal func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
//        print("SideMenu Disappearing! (animated: \(animated))")
//        view?.backgroundColor = UIColor.white
//
//    }
//
//    internal func sideMenuDidDisappear(menu: UISideMenuNavigationController, animated: Bool) {
//        print("SideMenu Disappeared! (animated: \(animated))")
//    }
//}
extension AboutUsController : UISideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
        
//        aboutusWeb.alpha = 0.5
//        aboutusWeb.backgroundColor = UIColor.clear
//        aboutusWeb.isOpaque = false
        view.alpha = 0.5
    }
     func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
    //*do the color thing*
        print("sidemenu disappear")
        view.alpha = 1
}
}
