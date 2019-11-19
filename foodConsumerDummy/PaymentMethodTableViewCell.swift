//
//  PaymentMethodTableViewCell.swift
//  foodConsumerDummy
//
//  Created by Keerthi on 19/11/19.
//  Copyright © 2019 Keerthi. All rights reserved.
//

import UIKit

class PaymentMethodTableViewCell: UITableViewCell {

    @IBOutlet weak var paymentLogo: UIImageView!
    
    @IBOutlet weak var paymentMethod: UILabel!
    
    @IBOutlet weak var paymentArrowRight: UIImageView!
    
    @IBOutlet weak var balance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
