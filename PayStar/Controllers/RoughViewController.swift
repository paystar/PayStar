
/*func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    let userId: String? = KeychainWrapper.standard.string(forKey: "Uid")
    print("appdelegate userid \(userId)")
    if userId != nil{
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.window!.rootViewController = homeVC
    }
    return true
}
 -------------------
 /*@IBAction func sendText(sender: UIButton) {
 if (MFMessageComposeViewController.canSendText()) {
 let controller = MFMessageComposeViewController()
 controller.body = "Message Body"
 controller.recipients = [phoneNumber.text]
 controller.messageComposeDelegate = self
 self.presentViewController(controller, animated: true, completion: nil)
 }
 }*/
 func messageComposeViewController(_ controller: MFMessageComposeViewController!, didFinishWith result: MessageComposeResult) {
 //... handle sms screen actions
 self.dismiss(animated: true, completion: nil)
 }
*/



