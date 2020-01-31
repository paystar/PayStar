

import UIKit

class PaymentOptionsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var paymentmodeImage: UIImageView!
    
    @IBOutlet weak var paymentLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}
