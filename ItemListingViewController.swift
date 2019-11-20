//
//  ItemListingViewController.swift
//  foodConsumerDummy
//
//  Created by Keerthi on 18/11/19.
//  Copyright © 2019 Keerthi. All rights reserved.
//

import UIKit

class ItemListingViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate{

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
    
    var restroName = " "
    var restaurantTags = " "
    
    let preferences = UserDefaults.standard
    
    var filteredItems = [itemDetails]()
    
    var curItems = [itemDetails]()
    
    var sectionDict = ["Lunch","Desserts","Breakfast"]
    var sectionTimes = ["9AM - 12:00 PM","All Times","7PM - 11:30 PM"]
    var price = 0
    
    var searchOn = false
    
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchOn = false
        if(!searchText.isEmpty){
           searchOn = true
        filteredItems = curItems.filter({ curItem -> Bool in
            return (curItem.name.lowercased().contains(searchText.lowercased()) ||
                curItem.name.lowercased().contains(searchText.lowercased()))
        })
        }
        self.itemListingTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        itemListingRestaurantName.text = restroName
        itemListingRestaurantTags.text = restaurantTags
        tableViewHeight.constant = itemListingTableView.contentSize.height
        scrollView.isScrollEnabled = true
        scrollView.contentSize.height = UIScreen.main.bounds.height + 10000
        setupItemDetails()
        cartView.backgroundColor = UIColor(named: "secondary")
        cartView.layer.borderWidth = 1
        cartView.layer.borderColor = UIColor(named: "secondary")?.cgColor
        cartView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        cartView.isHidden = true
        itemSearchBar.backgroundImage = UIImage()
        itemSearchBar.delegate = self
       
        if  preferences.object(forKey: "selectedItems") != nil{
             selectedItems = NSKeyedUnarchiver.unarchiveObject(with: preferences.object(forKey: "selectedItems") as! Data) as! [Item]
            for it in selectedItems{
                price += (it.qty*Int(it.price.components(separatedBy: " ")[1])!)
                items+=it.qty
            }
        }
        
    }
    
//    override func updateViewConstraints() {
//        tableViewHeight.constant = itemListingTableView.contentSize.height
//        scrollView.isScrollEnabled = true
//        scrollView.contentSize.height = UIScreen.main.bounds.height + 1000
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableViewHeight.constant = itemListingTableView.contentSize.height
        scrollView.isScrollEnabled = true
        scrollView.contentSize.height = UIScreen.main.bounds.height + 1000
    }
    
     override func viewWillLayoutSubviews() {
         super.updateViewConstraints()
        tableViewHeight.constant = itemListingTableView.contentSize.height
     }
     
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(searchOn){
            return 1
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchOn){
        return filteredItems.count
        }
        else{
        return curItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemTableViewCell") as! ItemListingItemsTableViewCell
        var found = false
        var curSelectedItem  = Item.init(itemName: "", price: "", itemType: UIImage(), qty: 0,restaurantName: restroName)
          
        if(searchOn){
            for it in selectedItems{
                           if(it.itemName == filteredItems[indexPath.row].name && it.restaurantName == restroName){
                               found = true
                               curSelectedItem = it
                            
                               
                           }
        }
            cell.itemName.text = filteredItems[indexPath.row].name
                   cell.itemPrice.text = filteredItems[indexPath.row].price
                   cell.itemType.image = filteredItems[indexPath.row].itemType
        }
            else{
            for it in selectedItems{
                if(it.itemName == curItems[indexPath.row].name && it.restaurantName == restroName){
                    found = true
                    curSelectedItem = it
                    
                }
                
        }
            cell.itemName.text = curItems[indexPath.row].name
                   cell.itemPrice.text = curItems[indexPath.row].price
                   cell.itemType.image = curItems[indexPath.row].itemType
            }
        
        if(found){
            cell.itemAdd.setTitle(String(curSelectedItem.qty), for: .normal)
//            print(curItems[indexPath.row].name + "  found")

            cell.itemMinus.isHidden = false
            cell.itemPlus.isHidden = false
            cell.itemAdd.setTitleColor(UIColor.white, for: .normal)
            cell.buttonsView.backgroundColor = UIColor(named: "secondary")
        }
        else{
//            print(curItems[indexPath.row].name + "  not found")
            cell.itemPlus.isHidden = true
            cell.itemMinus.isHidden = true
            cell.buttonsView.backgroundColor = UIColor.white
            cell.itemAdd.setTitle("ADD", for: .normal)
            cell.itemAdd.setTitleColor(UIColor(named: "secondary"), for: .normal)
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! ItemHeaderView
        headerCell.sectionName.text = sectionDict[section]
        headerCell.sectionTimeRange.text = sectionTimes[section]
        headerCell.sectionTimeRange.textColor = UIColor(named: "text light")
        headerCell.sectionSeperator.backgroundColor = UIColor(named: "focus")
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 128
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
        if(searchOn){
            for i in 0...selectedItems.count-1{
                if(selectedItems[i].itemName == filteredItems[row].name && selectedItems[i].restaurantName == restroName){
                           ind = i
                       }
                   }
        }
        else{
        for i in 0...selectedItems.count-1{
            if(selectedItems[i].itemName == curItems[row].name && selectedItems[i].restaurantName == restroName){
                ind = i
            }
        }
        }

        if(selectedItems[ind].qty > 1){
            var qty = selectedItems[ind].qty - 1
            selectedItems[ind] = Item.init(itemName: selectedItems[ind].itemName, price: selectedItems[ind].price, itemType: selectedItems[ind].itemType, qty: qty,restaurantName:  selectedItems[ind].restaurantName)
        }
        else{
            print(ind)
            selectedItems.remove(at: ind)
        }
    }
    
    @objc func itemAddClicked(sender: UIButton){
        let row = sender.tag
        price += Int(curItems[row].price.components(separatedBy: " ")[1])!
        items += 1
        print(restroName)
        if(searchOn){
            selectedItems.append(Item.init(itemName: filteredItems[row].name, price: filteredItems[row].price, itemType: filteredItems[row].itemType, qty: 1,restaurantName:  restroName))
        }
        else{
        selectedItems.append(Item.init(itemName: curItems[row].name, price: curItems[row].price, itemType: curItems[row].itemType, qty: 1,restaurantName:  restroName))
        }
    }
    
    @objc func itemPlusClicked(sender: UIButton){
        let row = sender.tag
        price += Int(curItems[row].price.components(separatedBy: " ")[1])!
        items += 1
        var ind  = -1
        if(searchOn){
            for i in 0...selectedItems.count-1{
                      if(selectedItems[i].itemName == filteredItems[row].name && selectedItems[i].restaurantName == restroName){
                          ind = i
                      }
                  }
        }
        else{
        for i in 0...selectedItems.count-1{
            if(selectedItems[i].itemName == curItems[row].name && selectedItems[i].restaurantName == restroName){
                ind = i
            }
        }
        }
        var qty = selectedItems[ind].qty + 1
        selectedItems[ind] = Item.init(itemName: selectedItems[ind].itemName, price: selectedItems[ind].price, itemType: selectedItems[ind].itemType, qty: qty,restaurantName: selectedItems[ind].restaurantName)
        
    }
    
    
    
    @objc(_TtCC17foodConsumerDummy25ItemListingViewController4Item)class Item : NSObject,NSCoding{
    
        let itemName : String
        let price : String
        let itemType : UIImage
        let qty : Int
        let restaurantName : String
        
        init(itemName:String,price:String,itemType:UIImage,qty:Int,restaurantName: String){
            self.itemType = itemType
            self.itemName = itemName
            self.price = price
            self.qty = qty
            self.restaurantName = restaurantName
        }
        
        func encode(with coder: NSCoder) {
            coder.encode(itemName, forKey: "itemName")
            coder.encode(price, forKey: "price")
            coder.encode(itemType, forKey: "itemType")
            coder.encode(qty, forKey: "qty")
            coder.encode(restaurantName, forKey: "restaurantName")
            }
            
       required init?(coder: NSCoder) {
        itemName = coder.decodeObject(forKey: "itemName") as! String
        price = coder.decodeObject(forKey: "price") as! String
        itemType = coder.decodeObject(forKey: "itemType") as! UIImage
        qty = coder.decodeInteger(forKey: "qty")
        restaurantName = coder.decodeObject(forKey: "restaurantName") as! String
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
