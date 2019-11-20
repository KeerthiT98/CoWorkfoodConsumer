//
//  PaymentSuccessViewController.swift
//  foodConsumerDummy
//
//  Created by Keerthi on 19/11/19.
//  Copyright © 2019 Keerthi. All rights reserved.
//

import UIKit

class PaymentSuccessViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var orderDetails: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var paymentSuccessTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var trackingView: UIView!
    
    @IBOutlet weak var restaurantName: UILabel!
    
    @IBOutlet weak var restaurantLoc: UILabel!
    
    @IBOutlet weak var seperatorOne: UIView!
    
    @IBOutlet weak var itemsTable: UITableView!
    @IBOutlet weak var seperatorTwo: UIView!
    
    @IBOutlet weak var itemTotalValue: UILabel!
    
    @IBOutlet weak var taxValue: UILabel!
    
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var seperatorThree: UIView!
    
    @IBOutlet weak var paymentSuccessConfirmImg: UIImageView!
    
    @IBOutlet weak var trackingOrderConfirm: UILabel!
    @IBOutlet weak var kitchenTag: UILabel!
    
    @IBOutlet weak var trackingPickupTag: UILabel!
    
    @IBOutlet weak var dashedLine1: UIView!
    @IBOutlet weak var trackingKitchenTxt: UILabel!
    
    @IBOutlet weak var dashedLine2: UIView!
    @IBOutlet weak var paymentMethod: UILabel!
    
    @IBOutlet weak var trackingKitchenImg: UIImageView!
    @IBOutlet weak var trackingPickupImg: UIImageView!
    
    let preferences  = UserDefaults.standard
    
    var items = 0
    var price = 0
    
    var selectedItems = [ItemListingViewController.Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = UIColor(named: "secondary")
        seperatorOne.backgroundColor = UIColor(named: "text light")
        seperatorTwo.backgroundColor = UIColor(named: "text light")
        seperatorThree.backgroundColor = UIColor(named: "text light")
         navigationItem.hidesBackButton = true
        
        scrollView.layer.cornerRadius = 16
        scrollView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        trackingView.layer.cornerRadius = 16
        trackingView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
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
        return selectedItems.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentSuccessCell") as! PaymentSuccessItemsTableViewCell
        cell.foodType.image = selectedItems[indexPath.row].itemType
        cell.foodDetails.text = selectedItems[indexPath.row].itemName+" × "+String(selectedItems[indexPath.row].qty)
        cell.foodPrice.text = String(Int(selectedItems[indexPath.row].price.components(separatedBy: " ")[1])!*(selectedItems[indexPath.row].qty))
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
