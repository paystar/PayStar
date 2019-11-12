

import UIKit
import WebKit
class ContactUsViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var contactWeb: WKWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //contectUsWebView.loadRequest(NSURLRequest(url: NSURL(string: "http://anyemi.com/contact.php")! as URL) as URLRequest)
        guard let url = URL(string: "https://anyemi.com/contact.php") else { return }
        
        let request = URLRequest(url: url)
        contactWeb.load(request)
        
        // add activity
        contactWeb.addSubview(self.activity)
        activity.startAnimating()
        contactWeb.navigationDelegate = self
        activity.hidesWhenStopped = true
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activity.stopAnimating()
    }
   
    @IBAction func sideMenu(_ sender: Any) {
        toggleSideMenuView()
    }
    
}
