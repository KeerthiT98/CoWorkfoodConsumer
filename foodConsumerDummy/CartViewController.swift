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
            if(items > 0){
                scrollview.isHidden = false
                emptyCartView.isHidden = true
                var selectedListData = NSKeyedArchiver.archivedData(withRootObject: selectedItems)
                preferences.set(selectedListData, forKey: "selectedItems")
                var item_val = 0
                var price_val = 0
                for it in selectedItems{
                    item_val += it.qty
                    price_val += (it.qty * Int(it.price.components(separatedBy: " ")[1])!)
                }
                var taxValue = Double(price_val)*0.05
                payBtn.setTitle("Pay · Rs. " + String(Double(price_val) + taxValue), for: .normal)
                cartItemsQty.text = String(items)+" Items Ordered"
                billItemTotalValue.text = "Rs. " + String(price_val)
                restaurantChargesValue.text = "Rs. " + String(taxValue)
                amountTotalValue.text = "Rs. " + String(Double(price_val) + taxValue)
                cartTableView.reloadData()
            }
            else{
                scrollview.isHidden = true
                emptyCartView.isHidden = false
                emptyCartBtn.setTitleColor(UIColor(named: "oyo_red"), for: .normal)
                emptyCartBtn.setTitle("PLACE NEW ORDER", for: .normal)
            }
        }
    }
    
    
    @IBAction func payBtnClicked(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableViewHeight.constant = cartTableView.contentSize.height
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "oyo_red")], for: .selected)
        
         navigationItem.hidesBackButton = true
        
        emptyCartBtn.setTitleColor(UIColor(named: "oyo_red"), for: .normal)
        emptyCartBtn.setTitle("PLACE NEW ORDER", for: .normal)
        
        payBtn.backgroundColor = UIColor(named: "secondary")
        
        seperatorOne.backgroundColor = UIColor(named: "text light")
        seperatorTwo.backgroundColor = UIColor(named: "text light")
        seperatorThree.backgroundColor = UIColor(named: "text light")
       if  preferences.object(forKey: "selectedItems") != nil{
        selectedItems = NSKeyedUnarchiver.unarchiveObject(with: preferences.object(forKey: "selectedItems") as! Data) as! [ItemListingViewController.Item]
            for it in selectedItems{
                price += (it.qty * Int(it.price.components(separatedBy: " ")[1])!)
                items+=it.qty
            }
        var taxValue = Double(price)*0.05
        payBtn.setTitle("Pay · Rs.  " + String(Double(price)+taxValue), for: .normal)
        cartItemsQty.text = String(items) + " Items Ordered"
        restaurantChargesValue.text = "Rs. " + String(taxValue)
        billItemTotalValue.text = "Rs. " + String(price)
        amountTotalValue.text = "Rs. " + String(Double(price) + taxValue)
        
        }
        
        if(items == 0){
           scrollview.isHidden = true
           emptyCartView.isHidden = false
           emptyCartBtn.setTitleColor(UIColor(named: "oyo_red"), for: .normal)
           emptyCartBtn.setTitle("PLACE NEW ORDER", for: .normal)
        }
        else{
            scrollview.isHidden = false
            var taxValue = Int(Double(price)*0.05)
            payBtn.setTitle("Pay · Rs. " + String(price+taxValue), for: .normal)
            emptyCartView.isHidden = true
        }
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cartTableViewHeight.constant = cartTableView.contentSize.height
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
       cartTableViewHeight.constant = cartTableView.contentSize.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return  selectedItems.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemTableViewCell") as! ItemListingItemsTableViewCell
        cell.itemName.text = selectedItems[indexPath.row].itemName
        cell.itemPrice.text = selectedItems[indexPath.row].price
        cell.itemType.image = selectedItems[indexPath.row].itemType
        cell.itemAdd.setTitle(String(selectedItems[indexPath.row].qty), for: .normal)
        cell.itemAdd.setTitleColor(UIColor(named: "secondary"), for: .normal)
        cell.buttonsView.backgroundColor = UIColor.white
        cell.buttonsView.layer.borderWidth = 1
        cell.buttonsView.layer.borderColor = UIColor(named: "secondary")?.cgColor
        cell.buttonsView.layer.cornerRadius = 16
        cell.itemMinus.tag = indexPath.row
        cell.itemPlus.tag = indexPath.row
        cell.itemMinus.addTarget(self, action: #selector(itemMinusClicked(sender:)), for: .touchUpInside)
        cell.itemPlus.tag = indexPath.row
        cell.itemPlus.addTarget(self, action: #selector(itemPlusClicked(sender:)), for: .touchUpInside)
        cell.itemPlus.setImage(UIImage(named: "icAddGreen"), for: .normal)
        cell.itemMinus.setImage(UIImage(named: "icMinusGreen"), for: .normal)
        return cell
     }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    
    @objc func itemMinusClicked(sender: UIButton){
        var row = sender.tag
        if(selectedItems[row].qty > 1){
            items -= 1
            price -= Int(selectedItems[row].price.components(separatedBy: " ")[1])!
             selectedItems[row] = ItemListingViewController.Item.init(itemName: selectedItems[row].itemName, price: selectedItems[row].price, itemType: selectedItems[row].itemType, qty: selectedItems[row].qty-1, restaurantName: selectedItems[row].restaurantName)
        }
        else{
            selectedItems.remove(at: row)
        }
    }
    
    @objc func itemPlusClicked(sender: UIButton){
        var row = sender.tag
        items+=1
        price += Int(selectedItems[row].price.components(separatedBy: " ")[1])!
        selectedItems[row] = ItemListingViewController.Item.init(itemName: selectedItems[row].itemName, price: selectedItems[row].price, itemType: selectedItems[row].itemType, qty: selectedItems[row].qty+1, restaurantName: selectedItems[row].restaurantName)
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
