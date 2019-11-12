

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
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activity.stopAnimating()
    }
    @IBAction func sideMenubtn(_ sender: Any) {
        print("in aboutus")
      //self.sideMenuConfig()//toggleSideMenuView()
    }
    func sideMenuConfig(){
        // Define the menus
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuVC") as? UISideMenuNavigationController
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuFadeStatusBar  = false
        
         // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        // Set up a cool background image for demo purposes
    }
}
