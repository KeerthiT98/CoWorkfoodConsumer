//
//  ItemHeaderView.swift
//  foodConsumerDummy
//
//  Created by Keerthi on 19/11/19.
//  Copyright © 2019 Keerthi. All rights reserved.
//

import UIKit

class ItemHeaderView: UITableViewCell {
     
    @IBOutlet weak var sectionName: UILabel!
    
    @IBOutlet weak var sectionTimeRange: UILabel!
    
    @IBOutlet weak var sectionSeperator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
