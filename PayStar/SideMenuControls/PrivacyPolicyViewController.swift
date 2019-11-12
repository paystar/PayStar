

import UIKit
import WebKit
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
        
        // add activity
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
        
        toggleSideMenuView()
        
    }
}
