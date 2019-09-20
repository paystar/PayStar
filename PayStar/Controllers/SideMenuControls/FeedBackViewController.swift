
import UIKit
import WebKit
class FeedBackViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var cont: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let myURLString = "http://anyemi.com/about.php"
        let url = NSURL(string: myURLString)
        let request = NSURLRequest(url: url! as URL)
        
        cont = WKWebView(frame: self.view.frame)
        cont.navigationDelegate = self
        cont.load(request as URLRequest)
        
        
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
    @IBAction func sideMenuButn(_ sender: Any) {
        toggleSideMenuView()
    }

}
