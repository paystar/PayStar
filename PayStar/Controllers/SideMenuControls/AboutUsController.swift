

import UIKit
import WebKit
class AboutUsController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var contentWebView: UIWebView!
    @IBOutlet weak var contentWebView1: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        contentWebView.loadRequest(NSURLRequest(url: NSURL(string: "http://anyemi.com/about.php")! as URL) as URLRequest)

    }
    
    @IBAction func sideMenuButton(_ sender: Any) {
        print("button tapped")
        toggleSideMenuView()
        
    }
    
    func webView()
    {
        let myURLString = "http://anyemi.com/about.php"
        let url = NSURL(string: myURLString)
        let request = NSURLRequest(url: url! as URL)
        
        contentWebView1 = WKWebView(frame: self.view.frame)
        contentWebView1.navigationDelegate = self
        contentWebView1.load(request as URLRequest)
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
