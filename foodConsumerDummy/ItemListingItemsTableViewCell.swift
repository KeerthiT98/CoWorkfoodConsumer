//
//  ItemListingItemsTableViewCell.swift
//  foodConsumerDummy
//
//  Created by Keerthi on 18/11/19.
//  Copyright © 2019 Keerthi. All rights reserved.
//

import UIKit

class ItemListingItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemType: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBOutlet weak var itemMinus: UIButton!
    
    @IBOutlet weak var itemAdd: UIButton!
    
    @IBOutlet weak var itemPlus: UIButton!
    
    @IBOutlet weak var buttonsView: UIView!
    
    
    @IBAction func itemMinusClick(_ sender: Any) {
        var qty = Int(itemAdd.titleLabel!.text!)
        if( qty! > 1){
            itemAdd.setTitle(String(qty!-1), for: .normal)
        }
        else
        {
            itemAdd.setTitle("ADD", for: .normal)
            itemPlus.isHidden = false
            itemMinus.isHidden = false
            buttonsView.backgroundColor = UIColor.white
            buttonsView.layer.borderColor = UIColor(named: "secondary")?.cgColor
            itemAdd.setTitleColor(UIColor(named: "secondary"), for: .normal)
        }
    }
    
    @IBAction func itemAddClick(_ sender: Any) {
        itemAdd.setTitle("1", for: .normal)
        itemAdd.isEnabled = false
        buttonsView.backgroundColor = UIColor(named: "secondary")
        buttonsView.layer.borderColor = UIColor(named: "secondary")?.cgColor
        itemAdd.setTitleColor(UIColor.white, for: .normal)
        itemMinus.isHidden = false
        itemPlus.isHidden = false
    }
    
    @IBAction func itemPlusClick(_ sender: Any) {
        var qty = Int(itemAdd.titleLabel!.text!)
    
            itemAdd.setTitle(String(qty!+1), for: .normal)
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
