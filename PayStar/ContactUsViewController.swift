

import UIKit
import WebKit
class ContactUsViewController: UIViewController, WKNavigationDelegate {

    
    @IBOutlet weak var contectUsWebView: UIWebView!
    @IBOutlet weak var contectUsWebView1: WKWebView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        contectUsWebView.loadRequest(NSURLRequest(url: NSURL(string: "http://anyemi.com/contact.php")! as URL) as URLRequest)
    }
    
    @IBAction func sideMenuButton(_ sender: Any) {
        
        toggleSideMenuView()
    }
    
    func webView()
    {
        let myURLString = "http://anyemi.com/contact.php"
        let url = NSURL(string: myURLString)
        let request = NSURLRequest(url: url! as URL)
        
        contectUsWebView1 = WKWebView(frame: self.view.frame)
        contectUsWebView1.navigationDelegate = self
        contectUsWebView1.load(request as URLRequest)
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
