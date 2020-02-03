
import UIKit
import HMSegmentedControl
import SideMenu
class PlansPrepaidViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let cornerRadius: CGFloat = 1

    @IBOutlet weak var tableView: UITableView!
    
     let segmentedControl = HMSegmentedControl(sectionTitles: ["POPULAR", "SPECIAL RECHARGE", "TOP UP", "2G/3G/4G DATA", "FULL TALKTIME", "ROAMING"])
    var sortedArray = [String]()
    
    let talktimeArray = ["26.66", "500.00","26.66", "500.00","26.66", "500.00","26.66", "500.00"]
    let validityArray = ["42 Days", "28 Days", "52 Days", "18 Days", "76 Days", "23 Days", "42 Days", "120 Days"]
    
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
     // Do any additional setup after loading the view.
             let yourImage: UIImage = UIImage(named: "logoanyemiBackGround-1")!
            backgroundImage.image = yourImage
                    backgroundImage.alpha = 0.5
        
        designSegmentedControl()
        self.sortedArray = self.validityArray.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.separatorStyle = .none
    }
      //for  segment
       func designSegmentedControl(){
        
           let width:CGFloat = view.frame.width
           let height:CGFloat = 40
           let xAxis:CGFloat = 0
           let yAxis:CGFloat = topContainerView.frame.height//50//segmentedControl.frame.origin.y+segmentedControl.frame.size.height
        
           segmentedControl?.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
           
           //segmentedControl?.frame = CGRect(x: 10, y: 60, width: 500, height: 60)

           segmentedControl?.backgroundColor = UIColor(red: 4/255, green: 118/255, blue: 208/255, alpha: 1.0)//UIColor.yellow
           //segmentedControl.translatesAutoresizingMaskIntoConstraints = false
           segmentedControl?.selectionIndicatorLocation = .down
           segmentedControl?.selectionIndicatorColor = UIColor(red: 63/255, green: 191/255, blue: 255/255, alpha: 1.0)//UIColor.red//
        segmentedControl?.selectionIndicatorHeight = 2.5
        //segmentedControl?.segmentWidthStyle = .dynamic
           segmentedControl?.titleTextAttributes = [
               NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
               NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)
           ]
           segmentedControl?.selectedTitleTextAttributes = [
               NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
               NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)
           ]
           print("out index")
           segmentedControl?.indexChangeBlock = { index in
               print(index)
               if index == 0{

                self.sortedArray = self.validityArray.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                print("segmnent 0 \(self.sortedArray)")
                self.tableView.reloadData()
                  }
               
               if index == 1{
                self.sortedArray = self.validityArray.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedDescending }
                print("segmnent 1 \(self.sortedArray)")
                self.tableView.reloadData()
               }
            if index == 2{
            self.sortedArray = self.validityArray.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedSame }
                         print("segmnent 1 \(self.sortedArray)")
                self.tableView.reloadData()

            }
            if index == 3{
            self.sortedArray = self.validityArray.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                         print("segmnent 1 \(self.sortedArray)")
                         self.tableView.reloadData()
            }
            
           }
           self.view.addSubview(segmentedControl!)
       }
    
    @IBAction func backBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlansTableViewCell
                cell.layoutIfNeeded()
                cell.containerView.dropShadow()
        cell.talktimeLabel.text = talktimeArray[indexPath.row]
        cell.validityLabel.text = sortedArray[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PlansTableViewCell
        
        //cell.containerView.dropShadow()
    }
}
extension UIView {
 func dropShadow(scale: Bool = true) {
   layer.masksToBounds = false
   layer.shadowColor = UIColor.black.cgColor
   layer.shadowOpacity = 0.5
   layer.shadowOffset = CGSize(width: -1, height: 1)
   layer.shadowRadius = 1
   layer.shadowPath = UIBezierPath(rect: bounds).cgPath
   layer.shouldRasterize = true
   layer.rasterizationScale = scale ? UIScreen.main.scale : 1
 }
}
extension PlansPrepaidViewController : UISideMenuNavigationControllerDelegate {
    
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
