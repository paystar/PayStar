

import UIKit
import WebKit
import SideMenu
class PrivacyPolicyViewController: UIViewController, WKNavigationDelegate {
    
  
    @IBOutlet weak var privasyWeb: WKWebView!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //webContainer.loadRequest(NSURLRequest(url: NSURL(string: "http://anyemi.com/privacy-policy.php")! as URL) as URLRequest)
        guard let url = URL(string: "https://anyemi.com/privacy-policy.php") else { return }
        
        let request = URLRequest(url: url)
        privasyWeb.load(request)
        
        //add activity
        self.privasyWeb.addSubview(self.activity)
        self.activity.startAnimating()
        self.privasyWeb.navigationDelegate = self
        self.activity.hidesWhenStopped = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activity.stopAnimating()
    }
   
    @IBAction func sideMenuButton(_ sender: Any) {
        
        view?.backgroundColor = UIColor(white: 1, alpha: 0.9)

    }
}
extension PrivacyPolicyViewController : UISideMenuNavigationControllerDelegate {
    
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
