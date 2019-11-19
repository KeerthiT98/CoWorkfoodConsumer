//
//  ItemListingViewController.swift
//  foodConsumerDummy
//
//  Created by Keerthi on 18/11/19.
//  Copyright © 2019 Keerthi. All rights reserved.
//

import UIKit

class ItemListingViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate{

    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var itemListingRestaurantName: UILabel!
    @IBOutlet weak var itemListingRestaurantTags: UILabel!
    
    @IBOutlet weak var itemSearchBar: UISearchBar!
    
    @IBOutlet weak var previouslyOrderedTxt: UILabel!
    
    @IBOutlet weak var itemPrevOrderedCollectionView: UICollectionView!
    
    @IBOutlet weak var itemListingTableView: UITableView!
    
    @IBOutlet weak var cartView: UIView!
    
    @IBOutlet weak var cartDetails: UILabel!
    
    
    let preferences = UserDefaults.standard
    
    var curItems = [itemDetails]()
    
    var price = 0
    
    var items = 0{
        didSet{
            if(items > 0){
                cartView.isHidden = false
                cartDetails.text = String(items) + " Items · Rs. "+String(price)
            }
            else{
                cartView.isHidden = true
            }
        }
    }
    
    var selectedItems = [Item](){
        didSet{
            var selectedListData = NSKeyedArchiver.archivedData(withRootObject: selectedItems)
            preferences.set(selectedListData, forKey: "selectedItems")
            itemListingTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupItemDetails()
        cartView.backgroundColor = UIColor(named: "secondary")
        cartView.layer.borderWidth = 1
        cartView.layer.borderColor = UIColor(named: "secondary")?.cgColor
        cartView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        cartView.isHidden = true
       
        if  preferences.object(forKey: "selectedItems") != nil{
             selectedItems = NSKeyedUnarchiver.unarchiveObject(with: preferences.object(forKey: "selectedItems") as! Data) as! [Item]
            for it in selectedItems{
                price += Int(it.price.components(separatedBy: " ")[1])!
                items+=it.qty
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableViewHeight.constant = itemListingTableView.contentSize.height
        scrollView.isScrollEnabled = true
        scrollView.contentSize.height = UIScreen.main.bounds.height
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemTableViewCell") as! ItemListingItemsTableViewCell
        cell.itemName.text = curItems[indexPath.row].name
        cell.itemPrice.text = curItems[indexPath.row].price
        cell.itemType.image = curItems[indexPath.row].itemType
        
        if(selectedItems.count==0){
        cell.itemPlus.isHidden = true
        cell.itemMinus.isHidden = true
        cell.itemAdd.setTitle("ADD", for: .normal)
        cell.itemAdd.setTitleColor(UIColor(named: "secondary"), for: .normal)
        }
        else{
            for it in selectedItems{
                if(it.itemName == curItems[indexPath.row].name){
                    cell.itemAdd.setTitle(String(it.qty), for: .normal)
                    cell.itemAdd.setTitleColor(UIColor.white, for: .normal)
                    cell.buttonsView.backgroundColor = UIColor(named: "secondary")
                }
            }
        }
        cell.itemMinus.tag = indexPath.row
        cell.itemMinus.addTarget(self, action: #selector(itemMinusClicked(sender:)), for: .touchUpInside)
        cell.itemAdd.tag = indexPath.row
        cell.itemAdd.addTarget(self, action: #selector(itemAddClicked(sender:)), for: .touchUpInside)
        cell.itemPlus.tag = indexPath.row
        cell.itemPlus.addTarget(self, action: #selector(itemPlusClicked(sender:)), for: .touchUpInside)
        cell.buttonsView.layer.borderColor = UIColor(named: "secondary")?.cgColor
        cell.buttonsView.layer.borderWidth = 1
        cell.buttonsView.layer.cornerRadius = 16
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 16
        cell.layer.borderColor = UIColor(named: "focus")?.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemPrevOrderCell", for: indexPath) as! ItemPrevOrderedCollectionViewCell
        cell.itemPrevOrderDetails.text = "Rajma Combo × 1 · Milk × 1"
        cell.itemPrevOrderedPrice.text = "Rs. 150"
        cell.itemPrevOrderedTime.text = "Date · Time"
        cell.itemPrevReorder.setTitle("REORDER", for: .normal)
        cell.itemPrevReorder.setTitleColor(UIColor(named: "secondary"), for: .normal)
        cell.itemPrevReorder.layer.borderWidth = 1
        cell.itemPrevReorder.layer.borderColor = UIColor(named: "secondary")?.cgColor
        cell.itemPrevReorder.layer.cornerRadius = 16
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 16
        cell.layer.borderColor = UIColor(named: "focus")?.cgColor
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
    
    private func setupItemDetails(){
        curItems.append(itemDetails.init(name: "Classic Crème Brûlée", price: "Rs. 123", itemType:UIImage(named:"icVeg")!))
        curItems.append(itemDetails.init(name: "Flourless Chocolate Espresso", price: "Rs. 123", itemType: UIImage(named: "icVeg")!))
        curItems.append(itemDetails.init(name: "Coconut Cream Pie.", price: "Rs. 123", itemType: UIImage(named: "icVeg")!))
        curItems.append(itemDetails.init(name: "Warm Apple Crostata", price: "Rs. 123", itemType: UIImage(named: "icVeg")!))
    }
    
    @objc func itemMinusClicked(sender: UIButton){
        let row = sender.tag
        price -= Int(curItems[row].price.components(separatedBy: " ")[1])!
        items -= 1
        
        var ind = -1
        
        for i in 0...selectedItems.count-1{
            if(selectedItems[i].itemName == curItems[row].name){
                ind = 1
            }
        }

        if(items > 1){
            var qty = selectedItems[ind].qty - 1
            selectedItems[ind] = Item.init(itemName: selectedItems[ind].itemName, price: selectedItems[ind].price, itemType: selectedItems[ind].itemType, qty: qty)
        }
        else{
            selectedItems.remove(at: ind)
        }
    }
    
    @objc func itemAddClicked(sender: UIButton){
        let row = sender.tag
        price += Int(curItems[row].price.components(separatedBy: " ")[1])!
        items+=1
        selectedItems.append(Item.init(itemName: curItems[row].name, price: curItems[row].price, itemType: curItems[row].itemType, qty: 1))
    }
    
    @objc func itemPlusClicked(sender: UIButton){
        let row = sender.tag
        price += Int(curItems[row].price.components(separatedBy: " ")[1])!
        items += 1
        var ind  = -1
        for i in 0...selectedItems.count-1{
            if(selectedItems[i].itemName == curItems[row].name){
                ind = 1
            }
        }
        var qty = selectedItems[ind].qty + 1
                   selectedItems[ind] = Item.init(itemName: selectedItems[ind].itemName, price: selectedItems[ind].price, itemType: selectedItems[ind].itemType, qty: qty)
        
    }
    
    @objc(_TtCC17foodConsumerDummy25ItemListingViewController4Item)class Item : NSObject,NSCoding{
    
        let itemName : String
        let price : String
        let itemType : UIImage
        let qty : Int
        
        init(itemName:String,price:String,itemType:UIImage,qty:Int){
            self.itemType = itemType
            self.itemName = itemName
            self.price = price
            self.qty = qty
        }
        
        func encode(with coder: NSCoder) {
            coder.encode(itemName, forKey: "itemName")
            coder.encode(price, forKey: "price")
            coder.encode(itemType, forKey: "itemType")
            coder.encode(qty, forKey: "qty")
            }
            
       required init?(coder: NSCoder) {
        itemName = coder.decodeObject(forKey: "itemName") as! String
        price = coder.decodeObject(forKey: "price") as! String
        itemType = coder.decodeObject(forKey: "itemType") as! UIImage
        qty = coder.decodeInteger(forKey: "qty")
            }
    }

    class itemDetails{
        let name : String
        let price : String
        let itemType : UIImage
        
        init(name: String,price:String,itemType:UIImage) {
            self.name = name
            self.price = price
            self.itemType = itemType
        }
    }

}
