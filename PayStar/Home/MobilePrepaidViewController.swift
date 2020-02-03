
import UIKit
import DropDown
class MobilePrepaidViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var cell: UITableViewCell?
    
    @IBOutlet weak var selectOperButtn: UIButton!
    @IBOutlet weak var selectOpertrTextField: UITextField!
    @IBOutlet weak var selectOprtortableView: UITableView!
    
    
    
    @IBOutlet weak var stateTableView: UITableView!
    
    @IBOutlet weak var sateButn: UIButton!
    @IBOutlet weak var stateTextField: UITextField!
    
    
    
    @IBOutlet weak var topupBtn: UIButton!
    @IBOutlet weak var topupTextfild: UITextField!
    @IBOutlet weak var topupTableView: UITableView!
    
    
    var topupArray = ["one","two", "hsbdj"]

    var stateArray = ["one","two", "hsbdj","jshdkj", "hfskd", "hsdjgfukdjs", "jdkhj"]
    var selectOperatorArray = ["fsdfsd", "sdfsdgds", "dsfrere", "fesfwsf", "fwefwefe", "fsdfsd", "sdfsdgds", "dsfrere", "fesfwsf", "fwefwefe"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectOprtortableView.isHidden = true
        selectOprtortableView.separatorStyle = .none
        stateTableView.separatorStyle = .none
        stateTableView.isHidden = true
        topupTableView.separatorStyle = .none
        topupTableView.isHidden = true
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectOperatrButton(_ sender: Any) {
        selectOprtortableView.isHidden = false
        selectOperButtn.setAttributedTitle(nil, for: .normal)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == selectOprtortableView{
        return selectOperatorArray.count
        }
        if tableView == stateTableView{
            return stateArray.count
        }
        if tableView == topupTableView{
            return topupArray.count
        }
        return 1
        
    }
    
    @IBAction func stateButn(_ sender: Any) {
        
        stateTableView.isHidden = false
        selectOperButtn.setAttributedTitle(nil, for: .normal)
        
        
    }
    
    @IBAction func topupButton(_ sender: Any) {
        topupTableView.isHidden = false
        topupBtn.setAttributedTitle(nil, for: .normal)
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        if tableView == selectOprtortableView{
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 

            self.cell?.textLabel?.text = selectOperatorArray[indexPath.row]
            self.cell?.selectionStyle = .none
        }
        
        if tableView == stateTableView{
            cell = tableView.dequeueReusableCell(withIdentifier: "statecell", for: indexPath) 

            self.cell?.textLabel?.text = stateArray[indexPath.row]
            self.cell?.selectionStyle = .none
        }
        
        if tableView == topupTableView{
            cell = tableView.dequeueReusableCell(withIdentifier: "topupcell", for: indexPath) 
            
            self.cell?.textLabel?.text = topupArray[indexPath.row]
            self.cell?.selectionStyle = .none
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if tableView == selectOprtortableView{
        selectOpertrTextField.text = cell?.textLabel?.text//selectOperatorArray[indexPath.row]
        selectOprtortableView.isHidden = true
        }
        if tableView == stateTableView{
            stateTextField.text = cell?.textLabel?.text//selectOperatorArray[indexPath.row]
            stateTableView.isHidden = true
        }
        
        if tableView == topupTableView{
            topupTextfild.text = cell?.textLabel?.text//selectOperatorArray[indexPath.row]
            topupTableView.isHidden = true
        }
        
    }
    

}
