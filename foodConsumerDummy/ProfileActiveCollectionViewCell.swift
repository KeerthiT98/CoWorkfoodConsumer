//
//  ProfileActiveCollectionViewCell.swift
//  foodConsumerDummy
//
//  Created by Keerthi on 19/11/19.
//  Copyright © 2019 Keerthi. All rights reserved.
//

import UIKit

class ProfileActiveCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var activeRestaurantName: UILabel!
    @IBOutlet weak var activeOrderDetails: UILabel!
    @IBOutlet weak var activeOrderTime: UILabel!
    
    @IBOutlet weak var activeOrderPrice: UILabel!
    
    @IBOutlet weak var activeOrderesBtn: UIButton!
    @IBOutlet weak var activeTag: UILabel!
}
