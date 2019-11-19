//
//  CartViewController.swift
//  foodConsumerDummy
//
//  Created by Keerthi on 18/11/19.
//  Copyright © 2019 Keerthi. All rights reserved.
//

import UIKit

class CartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    @IBOutlet weak var emptyCartView: UIView!
    
    @IBOutlet weak var emptyCartViewTxt: UILabel!
    @IBOutlet weak var emptyCartBtn: UIButton!
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var cartRestaurantName: UILabel!
    
    @IBOutlet weak var cartItemsQty: UILabel!
    
    @IBOutlet weak var seperatorOne: UIView!
    
    @IBOutlet weak var cartTableView: UITableView!
    
    @IBOutlet weak var billDetailsTxt: UILabel!
    
    @IBOutlet weak var billItemTotalTxt: UILabel!
    
    @IBOutlet weak var billItemTotalValue: UILabel!
    
    @IBOutlet weak var restaurantCharges: UILabel!
    
    @IBOutlet weak var restaurantChargesValue: UILabel!
    @IBOutlet weak var seperatorTwo: UIView!
    
    @IBOutlet weak var seperatorThree: UIView!
    
    @IBOutlet weak var amountTotal: UILabel!
    
    @IBOutlet weak var amountTotalValue: UILabel!
    
    @IBOutlet weak var payBtn: UIButton!
    
    @IBOutlet weak var cartTableViewHeight: NSLayoutConstraint!
    
    let preferences  = UserDefaults.standard
    
    var items = 0
    var price = 0
    
    var selectedItems = [ItemListingViewController.Item](){
        didSet{
            
        }
    }
    
    
    @IBAction func payBtnClicked(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       if  preferences.object(forKey: "selectedItems") != nil{
        selectedItems = NSKeyedUnarchiver.unarchiveObject(with: preferences.object(forKey: "selectedItems") as! Data) as! [ItemListingViewController.Item]
            for it in selectedItems{
                price += Int(it.price.components(separatedBy: " ")[1])!
                items+=it.qty
            }
        }

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return  selectedItems.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemTableViewCell") as! ItemListingItemsTableViewCell
        cell.itemName.text = selectedItems[indexPath.row].itemName
        cell.itemPrice.text = selectedItems[indexPath.row].price
        cell.itemAdd.setTitle(String(selectedItems[indexPath.row].qty), for: .normal)
        cell.itemAdd.setTitleColor(UIColor(named: "secondary"), for: .normal)
        cell.buttonsView.backgroundColor = UIColor.white
        cell.itemPlus.setImage(UIImage(named: "icAddGreen"), for: .normal)
        cell.itemMinus.setImage(UIImage(named: "icMinusGreen"), for: .normal)
        return cell
     }
     
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
