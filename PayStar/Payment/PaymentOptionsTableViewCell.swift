

import UIKit

class PaymentOptionsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var paymentmodeImage: UIImageView!
    
    @IBOutlet weak var paymentLabel: UILabel!
    let cornerRadius: CGFloat = 1


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentView.clipsToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        contentView.layer.shadowRadius = 1
        contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: cornerRadius).cgPath
        
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}
