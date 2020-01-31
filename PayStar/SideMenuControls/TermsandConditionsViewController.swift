

import UIKit
import WebKit
import SideMenu
class TermsandConditionsViewController: UIViewController, WKNavigationDelegate {

   
    @IBOutlet weak var termscondiWeb: WKWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //Do any additional setup after loading the view.
        
        //webViewTC.loadRequest(NSURLRequest(url: NSURL(string: "http://anyemi.com/termsandconditions.php")! as URL) as URLRequest)
        
        guard let url = URL(string: "https://anyemi.com/termsandconditions.php") else { return }
        
        let request = URLRequest(url: url)
        termscondiWeb.load(request)
        
        // add activity
        self.termscondiWeb.addSubview(self.activity)
        self.activity.startAnimating()
        self.termscondiWeb.navigationDelegate = self
        self.activity.hidesWhenStopped = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activity.stopAnimating()
    }
    
    @IBAction func sideMenuButton(_ sender: Any) {
        termscondiWeb?.backgroundColor = UIColor(white: 1, alpha: 0.9)
    }
    
}
extension TermsandConditionsViewController : UISideMenuNavigationControllerDelegate {
    
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
