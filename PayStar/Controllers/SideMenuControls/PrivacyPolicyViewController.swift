

import UIKit
import WebKit
class PrivacyPolicyViewController: UIViewController, WKNavigationDelegate {
    
    
    
    @IBOutlet weak var webContainer: UIWebView!
    @IBOutlet weak var webContainer1: WKWebView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        webContainer.loadRequest(NSURLRequest(url: NSURL(string: "http://anyemi.com/privacy-policy.php")! as URL) as URLRequest)
        
    }

    @IBAction func sideMenuButton(_ sender: Any) {
        
        toggleSideMenuView()
        
    }
    
    
    func webView()
    {
        let myURLString = "http://anyemi.com/privacy-policy.php"
        let url = NSURL(string: myURLString)
        let request = NSURLRequest(url: url! as URL)
        
        webContainer1 = WKWebView(frame: self.view.frame)
        webContainer1.navigationDelegate = self
        webContainer1.load(request as URLRequest)
        
        //cont.load(NSURLRequest(url: NSURL(string: "http://anyemi.com/about.php")! as URL) as URLRequest)
        // Do any additional setup after loading the view.
    }
    
    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
    }
}
