//
//  HomeViewController.swift
//  foodConsumerDummy
//
//  Created by Keerthi on 18/11/19.
//  Copyright © 2019 Keerthi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var PrevOrderedCollectionView: UICollectionView!
    
    @IBOutlet weak var buildingName: UILabel!
    @IBOutlet weak var buildingView: UIView!
    @IBOutlet weak var restaurantTableView: UITableView!
    
    @IBOutlet weak var prevOrderedTxt: UILabel!
    @IBOutlet weak var restauarntsTxt: UILabel!
    
    var selectedRestaurantName = " "
    var selectedRestaurantTags = " "
    
    var restauarnts = [restaurantDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        setupRestaurantDetails()
        // Do any additional setup after loading the view.
        self.restaurantTableView.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 16))
        prevOrderedTxt.textColor = UIColor(named: "text light")
        restauarntsTxt.textColor = UIColor(named: "text light")
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "oyo_red")], for: .selected)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
     }
     
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restroCell") as! RestaurantTableViewCell
        cell.restaurantImg.image = UIImage(named: "Restaurant")
        cell.restaurantName.text = restauarnts[indexPath.section].restaurantName
        cell.restaurantTags.text = restauarnts[indexPath.section].restaurantTags
        cell.restaurantAvPrice.text = restauarnts[indexPath.section].restaurantAvPrice
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 16
        cell.layer.borderColor = UIColor(named: "focus")?.cgColor
        return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRestaurantName = restauarnts[indexPath.section].restaurantName
        selectedRestaurantTags = restauarnts[indexPath.section].restaurantTags
        performSegue(withIdentifier: "ItemListingSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let itemVC = segue.destination as! ItemListingViewController
        itemVC.restroName = selectedRestaurantName
        itemVC.restaurantTags = selectedRestaurantTags
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return restauarnts.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 0
        }
        return 16
    }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 5
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrevOrderedCell", for: indexPath) as! PrevOrderedCollectionViewCell
        cell.PrevOrderedRestaurantName.text = "VNB Factory"
        cell.PrevOrderDetails.text = "Rajma Combo × 1 · Milk × 1"
        cell.PrevOrderTime.text = "Sep 2 · 2:20 pm"
        cell.PrevOrderedPrice.text = "Rs. 150"
        cell.PrevOrderTime.textColor = UIColor(named: "text light")
        cell.PrevOrderedPrice.textColor = UIColor(named: "text light")
        cell.prevOrderedReorderBtn.setTitle("REORDER",for: .normal)
        cell.prevOrderedReorderBtn.setTitleColor(UIColor(named: "secondary"), for: .normal)
        cell.prevOrderedReorderBtn.layer.borderColor = UIColor(named: "secondary_2")?.cgColor
        cell.prevOrderedReorderBtn.layer.borderWidth = 1
        cell.prevOrderedReorderBtn.layer.cornerRadius = 16
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
    private func setupRestaurantDetails(){
        restauarnts.append(restaurantDetails.init(restaurantName: "Masala Fusion Delight", restaurantTags: "Chinese · Asian · Thai · Indian", restaurantAvPrice: "Rs. 200 for two"))
        restauarnts.append(restaurantDetails.init(restaurantName: "Restaurant Name", restaurantTags: "Chinese · Asian · Thai · Indian", restaurantAvPrice: "Rs. 200 for two"))
    }
    
    class restaurantDetails{
        var restaurantName : String
        var restaurantTags : String
        var restaurantAvPrice : String
        
        init(restaurantName: String,restaurantTags: String,restaurantAvPrice: String) {
            self.restaurantName = restaurantName
            self.restaurantTags = restaurantTags
            self.restaurantAvPrice = restaurantAvPrice
        }
    }

}
