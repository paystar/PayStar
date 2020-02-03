

import UIKit

class PlansTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var amountBtn: UIButton!
    @IBOutlet weak var talktimeLabel: UILabel!
    @IBOutlet weak var validityLabel: UILabel!
    
        override func layoutSubviews() {
           super.layoutSubviews()
            //containerView.dropShadow(scale: true)
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
